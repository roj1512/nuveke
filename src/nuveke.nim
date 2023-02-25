import std/tables
import std/json
import httpbeast
import handler

when isMainModule:
  let jsonNode = parseFile("/etc/nuveke.json")
  var config = initTable[string, string]()
  for key in jsonNode.keys:
    config[key] = jsonNode[key].getStr()
  run(getHandler(config))
