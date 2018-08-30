local mt = {__call = function(_, dir)
   dir = dir or ''
   return io.popen('ls ' .. dir)
      :read('*a')
      :gmatch('([%w_]+)%.lua')
end}

return setmetatable({}, mt)
