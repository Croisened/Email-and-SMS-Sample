--[[
  Only store data you need to share across scenes that you aren't persisting in some other manner in here.
  Just add any variables you need to the table....
--]]

local Globals = 
{
    ["phone"] = "5555555555",
    ["emailTo"] = "yourEmail@yourDomain.com",
   
  

}
 
function getGlobal(key)
    local val = Globals[key]
    return val
end
 
function setGlobal(key, val)
    Globals[key] = val
    return
end