local get_room = require('get_room')

describe('get_room', function()
   local URI = 'gitterhq/sandbox'
   local GITTER_TOKEN = os.getenv('GITTER_TOKEN')

   it('returns a table when required', function()
      local module_type = type(get_room)
      local expected = 'table'
      assert.are.equal(module_type, expected)
   end)

   it('returns an room as a string when called', function()
      local room = get_room(URI, GITTER_TOKEN)
      local room_type = type(room)
      local expected = 'string'
      assert.are.equal(room_type, expected)
   end)

   it('returns nil and error if no room uri', function()
      local room, err = get_room(nil, GITTER_TOKEN)
      local expected = 'No room uri given'
      assert.has_no(room)
      assert.are.equal(err, expected)
   end)

   it('returns nil and error if no token', function()
      local room, err = get_room('gitterhq/sandbox')
      local expected = 'No token given'
      assert.has_no(room)
      assert.are.equal(err, expected)
   end)
end)
