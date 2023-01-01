require("checkers")
require("extensions")
require("search")
require("time")
require("version")
require("reloader")
require("user")
require("migration")

boot = function(replicationUser, replicationPassword, delay)
  if (replicationUser ~= nil and replicationPassword ~= nil) then 
      initializeUser(replicationUser, replicationPassword)
      if (delay ~= nil) then 
        require("fiber").sleep(delay)
      end
    box.ctl.promote()  
  end
  initializeVersion()
end

sample = function() 
  print("I am custom lua function")
end

-- You can add your own custom code here