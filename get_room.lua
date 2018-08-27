local request = require('http.request')

local mt = {__call = function(_, room, token)
   if not room then return nil, 'No room uri given' end
   if not token then return nil, 'No token given' end

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
   local body, err = stream:get_body_as_string()
   if err then return nil, err end

   return body
end}

return setmetatable({}, mt)
