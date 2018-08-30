local fetch = require('fetch')

describe('fetch', function()
   it('returns a table when required', function()
      local actual = type(fetch)
      local expected = 'table'
      assert.are.equal(actual, expected)
   end)

   it('returns a iterator function when called', function()
      local actual = type(fetch())
      local expected = 'function'
      assert.are.equal(actual, expected)
   end)
end)
