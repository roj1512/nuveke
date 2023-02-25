import std/options
import std/tables
import std/json
import osproc
import asyncdispatch
import httpbeast

proc getHandler*(config: Table[string, string]): OnRequest =
    return proc(req: Request): Future[void] =
        let m = req.httpMethod()
        if not m.isSome or m.get() != HttpPost:
            req.send(Http405)
        if req.body.isSome:
            let body = req.body.get()
            let payload = parseJson(body)
            let repository = payload["repository"]["full_name"].getStr()
            if config.hasKey(repository):
                let dir = config[repository]
                discard execCmdEx("git pull", workingDir = dir)
                discard execCmdEx("docker compose stop", workingDir = dir)
                discard execCmdEx("docker compose build", workingDir = dir)
                discard execCmdEx("docker compose up -d", workingDir = dir)
        else:
            req.send(Http400)
        req.send(Http200)
