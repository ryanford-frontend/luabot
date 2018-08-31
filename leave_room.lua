local request = require("http.request")

local mt = {__call = function(_, room, user, token)
   if not room then return nil, 'No room given' end
   if not user then return nil, 'No user given' end
   if not token then return nil, 'No token given' end

   local room_id = room.id
   local user_id = user[1].id
   local uri = 'https://api.gitter.im/v1/rooms/' .. room_id ..'/users/' .. user_id
   local req_body = '{}'

   local req = request.new_from_uri(uri)
   req.headers:upsert(':method', 'DELETE')
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
