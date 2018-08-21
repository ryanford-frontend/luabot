local luabot = require('luabot')

describe('luabot', function()
   it('returns a string', function()
      assert.equal('hello world', luabot.speak('hello world'))
   end)
end)
