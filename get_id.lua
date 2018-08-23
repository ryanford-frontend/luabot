local mt = {__call = function(_, room, token)
   local request = require('http.request')
   local cjson = require('cjson.safe')

   local uri = 'https://api.gitter.im/v1/rooms'
   local req_body = '{"uri":"' .. room ..'"}'
   local req_timeout = 10

   local req = request.new_from_uri(uri)

   req.headers:upsert(':method', 'POST')
   req.headers:upsert('content-type', 'application/json')
   req.headers:upsert('accept', 'application/json')
   req.headers:upsert('authorization', 'Bearer ' .. token, true)
   req:set_body(req_body)

   local _, stream = req:go(req_timeout)

   local body = assert(stream:get_body_as_string())

   body = assert(cjson.decode(body))

   return(body.id)
end}

return setmetatable({}, mt)
