local get_user = require('get_user')

describe('get_user', function()
   local GITTER_TOKEN = os.getenv('GITTER_TOKEN')

   it('returns a table when required', function()
      local module_type = type(get_user)
      local expected = 'table'
      assert.are.equal(module_type, expected)
   end)

   it('returns user as a string when called', function()
      local user = get_user(GITTER_TOKEN)
      local user_type = type(user)
      local expected = 'string'
      assert.are.equal(user_type, expected)
   end)

   it('returns nil and error if no token', function()
      local user, err = get_user()
      local expected = 'No token given'
      assert.has_no(user)
      assert.are.equal(err, expected)
   end)
end)
