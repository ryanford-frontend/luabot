local get_id = require('get_id')

describe('get_id', function()
   local ROOM = 'gitterhq/sandbox'
   local GITTER_TOKEN = os.getenv('GITTER_TOKEN')

   it('returns a table when required', function()
      local module_type = type(get_id)
      local expected = 'table'
      assert.are.equal(module_type, expected)
   end)

   it('returns an id as a string when called', function()
      local id = get_id(ROOM, GITTER_TOKEN)
      local id_type = type(id)
      local expected = 'string'
      assert.are.equal(id_type, expected)
   end)

   it('returns nil and error if no room uri', function()
      local id, err = get_id(nil, GITTER_TOKEN)
      local expected = 'No room uri given'
      assert.has_no(id)
      assert.are.equal(err, expected)
   end)

   it('returns nil and error if no token', function()
      local id, err = get_id('gitterhq/sandbox')
      local expected = 'No token given'
      assert.has_no(id)
      assert.are.equal(err, expected)
   end)
end)
