local get_room = require('get_room')
local send_message = require('send_message')
local cjson = require('cjson')

describe('send_message', function()
   local URI = 'gitterhq/sandbox'
   local GITTER_TOKEN = os.getenv('GITTER_TOKEN')
   local MESSAGE = 'Hello World'
   local room = cjson.decode(get_room(URI, GITTER_TOKEN))

   it('returns a table when required', function()
      local actual = type(send_message)
      local expected = 'table'
      assert.are.equal(actual, expected)
   end)

   it('returns text response when called', function()
      local res = send_message(room, GITTER_TOKEN, MESSAGE)
      local actual = type(res)
      local expected = 'string'
      assert.are.equal(actual, expected)
   end)

   it('returns nil and error if no room given', function()
      local body, err = send_message(nil, GITTER_TOKEN, MESSAGE)
      local expected = 'No room given'
      assert.has.no(body)
      assert.are.equal(err, expected)
   end)

   it('returns nil and error if no token given', function()
      local body, err = send_message(room, nil, MESSAGE)
      local expected = 'No token given'
      assert.has.no(body)
      assert.are.equal(err, expected)
   end)

   it('returns nil and error if no message given', function()
      local body, err = send_message(room, GITTER_TOKEN)
      local expected = 'No message given'
      assert.has.no(body)
      assert.are.equal(err, expected)
   end)
end)
