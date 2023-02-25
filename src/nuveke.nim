# import std/tables
# import std/json
# import httpbeast
# import handler
import std/osproc

when isMainModule:
  let output = execCmd("echo 1")

  echo output

  # let jsonNode = parseFile("/etc/nuveke.json")
  # var config = initTable[string, string]()
  # for key in jsonNode.keys:
  #   config[key] = jsonNode[key].getStr()
  # run(getHandler(config))
