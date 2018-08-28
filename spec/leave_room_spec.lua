local get_user = require('get_user')
local get_room = require('get_room')
local join_room = require('join_room')
local cjson = require('cjson')

describe('join_room', function()
   local URI = 'gitterhq/sandbox'
   local GITTER_TOKEN = os.getenv('GITTER_TOKEN')
   local room = cjson.decode(get_room(URI, GITTER_TOKEN))
   local user = cjson.decode(get_user(GITTER_TOKEN))

   it('returns a table when required', function()
      local module_type = type(join_room)
      local expected = 'table'
      assert.are.equal(module_type, expected)
   end)

   it('returns text response when called', function()
      local res = join_room(room, user, GITTER_TOKEN)
      local res_type = type(res)
      local expected_type = 'string'
      assert.are.equal(res_type, expected_type)
   end)

   it('returns nil and error if no room given', function()
      local body, err = join_room(nil, user, GITTER_TOKEN)
      local expected = 'No room given'
      assert.has.no(body)
      assert.are.equal(err, expected)
   end)

   it('returns nil and error if no user given', function()
      local body, err = join_room(room, nil, GITTER_TOKEN)
      local expected = 'No user given'
      assert.has.no(body)
      assert.are.equal(err, expected)
   end)

   it('returns nil and error if no token given', function()
      local body, err = join_room(room, user)
      local expected = 'No token given'
      assert.has.no(body)
      assert.are.equal(err, expected)
   end)
end)
