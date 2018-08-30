local request = require("http.request")

local mt = {__call = function(_, room, token, message)
   if not room then return nil, 'No room given' end
   if not token then return nil, 'No token given' end
   if not message then return nil, 'No message given' end

   local room_id = room.id
   local uri = 'https://api.gitter.im/v1/rooms/' .. room_id .. '/chatMessages'
   local req_body = '{"text":"' .. message .. '"}'

   local req = request.new_from_uri(uri)
   req.headers:upsert(':method', 'POST')
   req.headers:upsert('content-type', 'application/json')
   req.headers:upsert('accept', 'application/json')
   req.headers:upsert('authorization', 'Bearer ' .. token, true)
   req:set_body(req_body)

   local headers, stream = req:go()
   local body, err = stream:get_body_as_string()
   if err then return nil, err end
   if headers:get(':status') ~= '200' then return nil, body end

   return body
end}

return setmetatable({}, mt)
