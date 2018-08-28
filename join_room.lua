local request = require("http.request")

local mt = {__call = function(_, room, user, token)
   if not room then return nil, 'No room given' end
   if not user then return nil, 'No user given' end
   if not token then return nil, 'No token given' end

   local room_id = room.id
   local user_id = user[1].id
   local uri = 'https://api.gitter.im/v1/user/' .. user_id .. '/rooms'
   local req_body = '{"id":"' .. room_id .. '"}'
   local req_timeout = 10

   local req = request.new_from_uri(uri)
   req.headers:upsert(':method', 'POST')
   req.headers:upsert('content-type', 'application/json')
   req.headers:upsert('accept', 'application/json')
   req.headers:upsert('authorization', 'Bearer ' .. token, true)
   req:set_body(req_body)

   local headers, stream = req:go(req_timeout)
   local body, err = stream:get_body_as_string()
   if err then return nil, err end
   if headers:get(':status') ~= '200' then return nil, body end

   return body
end}

return setmetatable({}, mt)
