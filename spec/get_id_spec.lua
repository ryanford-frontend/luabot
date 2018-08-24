local get_id = require('get_id')

describe('get_id', function()
   local ROOM = 'gitterhq/sandbox'
   local GITTER_TOKEN = os.getenv('GITTER_TOKEN')

   it('requiring returns a table', function()
      assert.is_true(type(get_id) == 'table')
   end)

   it('returns an id as a string', function()
      local id = get_id(ROOM, GITTER_TOKEN)
      assert.are_equal(type(id), 'string')
   end)

   it('fails without a room uri', function()
      assert.has_error(function()
         get_id(nil, GITTER_TOKEN)
      end, "No room uri given")
   end)

   it('fails without a token', function()
      assert.has_error(function()
         get_id('gitterhq/sandbox')
      end, "No token given")
   end)
end)
