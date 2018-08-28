local request = require('http.request')

local mt = {__call = function(_, token)
   if not token then return nil, 'No token given' end

   local uri = 'https://api.gitter.im/v1/user'
   local req_timeout = 10

   local req = request.new_from_uri(uri)
   req.headers:upsert('content-type', 'application/json')
   req.headers:upsert('accept', 'application/json')
   req.headers:upsert('authorization', 'Bearer ' .. token, true)

   local headers, stream = req:go(req_timeout)
   local body, err = stream:get_body_as_string()
   if err then return nil, err end
   if headers:get(':status') ~= '200' then return nil, body end

   return body
end}

return setmetatable({}, mt)
