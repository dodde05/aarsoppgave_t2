local http = require("socket.http")
local ltn12 = require("ltn12")

local body = {}

local res, code, headers, status = http.request{
    method = "POST",
    url = "http://localhost:8080",
    source = {
        ["simen"] = "erkul"
    },
    headers = {
        ["content-type"] = "application/json"
    },
    sink = ltn12.sink.table(body)
}

Response = table.concat(body)