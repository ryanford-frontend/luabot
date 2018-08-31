local cqueues = require('cqueues')
local cjson = require('cjson.safe')
local get_user = require('get_user')
local get_room = require('get_room')
local join_room = require('join_room')
local leave_room = require('leave_room')
local config = require('config')

local GITTER_TOKEN = config.token or os.getenv('GITTER_TOKEN')
local room_list = config.rooms

local user = cjson.decode(get_user(GITTER_TOKEN))
local cq = cqueues.new()

for _, uri in ipairs(room_list) do
   cq:wrap(function()
      local room = cjson.decode(get_room(uri, GITTER_TOKEN))
      join_room(room, user, GITTER_TOKEN)
      cqueues.sleep(5)
      leave_room(room, user, GITTER_TOKEN)
   end)
end

cq:loop()
