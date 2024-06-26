

if not MUDKIP_Mud2.stats then

  MUDKIP_Mud2.stats = {
    stamina = 50,
    maxStamina = 50,
    effStr = 0,
    str = 0,
    effDex = 0,
    dex = 0,
    magic = 0,
    maxMagic = 50,
    pts = 0,
    dreamWord = "",
    blind = false,
    deaf = false,
    crippled = false,
    dumb = false,
    weather = "F",
    resetMins = 0,
    initialized = false
  }

else

  if not MUDKIP_Mud2.stats.initialized then
    MUDKIP_Mud2.stats.initialized = false
    MUDKIP_Mud2.stats.stamina = 50
    MUDKIP_Mud2.stats.maxStamina = 50
    MUDKIP_Mud2.stats.effStr = 0
    MUDKIP_Mud2.stats.str = 0
    MUDKIP_Mud2.stats.effDex = 0
    MUDKIP_Mud2.stats.dex = 0
    MUDKIP_Mud2.stats.magic = 0
    MUDKIP_Mud2.stats.maxMagic = 50
    MUDKIP_Mud2.stats.pts = 0
    MUDKIP_Mud2.stats.dreamWord = ""
    MUDKIP_Mud2.stats.blind = false
    MUDKIP_Mud2.stats.deaf = false
    MUDKIP_Mud2.stats.crippled = false
    MUDKIP_Mud2.stats.dumb = false
    MUDKIP_Mud2.stats.weather = "F"
    MUDKIP_Mud2.stats.resetMins = 0
  end

end

local M2Stats = MUDKIP_Mud2.stats


function M2Stats:toStringTemp()
  return "sta:" .. tostring(self.stamina)..", maxSta: "..tostring(self.maxStamina)..", effStr: "..tostring(self.effStr) .. ", str: " ..tostring(self.str) .. ", effDex: "..tostring(self.effDex)..", dex: "..tostring(self.dex)..", magic: "..tostring(self.magic)..", maxMagic: "..tostring(self.maxMagic)..", pts: "..tostring(self.pts)..", blind: "..tostring(self.blind)..", deaf: "..tostring(self.deaf)..", crip: "..tostring(self.crippled)..", dumb: " .. tostring(self.dumb)..", mins: "..tostring(self.resetMins)..", weather: "..self.weather..", dWord: " .. self.dreamWord
end

-- Called by the fes trigger to update status based on fes output
function M2Stats:updateFes(
  _sta, _maxSta, _effStr, _str, _effDex, _dex, _mag, _maxMag,
  _pts, _blind, _deaf, _crip, _dumb, _mins, _weather
)

  self.initialized = true

  self.stamina = tonumber(_sta)
  self.maxStamina = tonumber(_maxSta)
  self.effStr = tonumber(_effStr)
  self.str = tonumber(_str)
  self.effDex = tonumber(_effDex)
  self.dex = tonumber(_dex)
  self.magic = tonumber(_mag)
  self.maxMagic = tonumber(_maxMag)
  self.pts = tonumber(_pts)
  self.blind = (_blind == "Y")
  self.deaf = (_deaf == "Y")
  self.crippled = (_crip == "Y")
  self.dumb = (_dumb == "Y")
  self.resetMins = tonumber(_mins)
  self.weather = _weather

  MUDKIP_Mud2:getUI():updateTheStuff()

  --cecho("\n"..M2Stats:toStringTemp())
end

-- called when you are dead.
function M2Stats:youAreDead()
  self.stamina = 0
  --self.effStr = 0
  --self.effDex = 0
  --self.magic = 0
  MUDKIP_Mud2:getUI():updateTheStuff()
end

-- Called by the qs trigger to update the stats based on parsed qs output.
-- note: _mag may be nil.
function M2Stats:updateQs(
  _effStr, _effDex, _sta, _maxSta, _mag, _pts
)

  self.stamina = tonumber(_sta)
  self.maxStamina = tonumber(_maxSta)
  self.effStr = tonumber(_effStr)
  self.effDex = tonumber(_effDex)
  self.pts = tonumber(_pts)

  local magic = tonumber(_mag)

  if (magic ~= nil) then
    self.magic = magic
    if magic > self.maxMagic then
      self.maxMagic = magic
    end
  else
    self.magic = 0
  end
  MUDKIP_Mud2:getUI():updateTheStuff()

  --cecho("\n"..M2Stats:toStringTemp())
end

-- called by the stam update trigger to update stamina
-- note: _maxStam may be nil.
function M2Stats:updateStam(_stam, _maxStam)

  self.stamina = tonumber(_stam)
  local maxStam = tonumber(_maxStam)
  if (maxStam ~= nil) then
    -- only update maxStam if the stamina trigger showed maxStam
    self.maxStamina = maxStam
  end

  if self.stamina > self.maxStamina then
    self.maxStamina = self.stamina
  end

  --cecho("\n"..M2Stats:toStringTemp())

  MUDKIP_Mud2:getUI():updateTheStuff()
end

-- updates known points for the persona automagically whenever points get updated 
function M2Stats:updatePoints(_pts)
  self.pts = tonumber(_pts)

  MUDKIP_Mud2:getUI():updateTheStuff()
  --cecho("\n"..M2Stats:toStringTemp())
end

function M2Stats:setDreamword(_dreamWord)
  self.dreamWord = _dreamWord
  --cecho("\n"..M2Stats:toStringTemp())

  MUDKIP_Mud2:getUI():updateTheStuff()
end

function M2Stats:clearDreamword()
  self.dreamWord = ""
  --cecho("\n"..M2Stats:toStringTemp())
  MUDKIP_Mud2:getUI():updateTheStuff()
end

-- returns the current weather as a 6-character string
function M2Stats:getWeatherString()
  local weatherString = "??????"
  local _weather = self.weather
  if _weather == nil or _weather == "" then
    weatherString = "??????"
  elseif _weather == "F" then
    weatherString = "Sunny&nbsp;"
  elseif _weather == "C" then
    weatherString = "Cloudy"
  elseif _weather == "R" then
    weatherString = "Rain&nbsp;&nbsp;"
  elseif _weather == "S" then
    weatherString = "Snow&nbsp;&nbsp;"
  elseif _weather == "O" then
    weatherString = "OvCast"
  elseif _weather == "T" then
    weatherString = "TStorm"
  elseif _weather == "B" then
    weatherString = "Blizz&nbsp;"
  else
    weatherString = "?&nbsp;" .. _weather .. "&nbsp;?"
  end

  return weatherString
end

function M2Stats:getDreamword()
  return self.dreamWord
end