--[[
MUDKIP for MUD2
(Multi User Dungeon Kool Informational Panels)

]]--

if not MUDKIP_Mud2 then

  _G.MUDKIP_Mud2 = {}

  local M2UI = {}

  MUDKIP_Mud2.ui = M2UI

  local M2Stats = {
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
    resetMins = 0
  }

  MUDKIP_Mud2.stats = M2Stats

  function M2Stats:toStringTemp()
    return "sta:" .. tostring(self.stamina)..", maxSta: "..tostring(self.maxStamina)..", effStr: "..tostring(self.effStr) .. ", str: " ..tostring(self.str) .. ", effDex: "..tostring(self.effDex)..", dex: "..tostring(self.dex)..", magic: "..tostring(self.magic)..", maxMagic: "..tostring(self.maxMagic)..", pts: "..tostring(self.pts)..", blind: "..tostring(self.blind)..", deaf: "..tostring(self.deaf)..", crip: "..tostring(self.crippled)..", dumb: " .. tostring(self.dumb)..", mins: "..tostring(self.resetMins)..", weather: "..self.weather..", dWord: " .. self.dreamWord
  end

  -- Called by the fes trigger to update status based on fes output
  function MUDKIP_Mud2:updateFes(
    _sta, _maxSta, _effStr, _str, _effDex, _dex, _mag, _maxMag,
    _pts, _blind, _deaf, _crip, _dumb, _mins, _weather
  )
    M2Stats.stamina = tonumber(_sta)
    M2Stats.maxStamina = tonumber(_maxSta)
    M2Stats.effStr = tonumber(_effStr)
    M2Stats.str = tonumber(_str)
    M2Stats.effDex = tonumber(_effDex)
    M2Stats.dex = tonumber(_dex)
    M2Stats.magic = tonumber(_mag)
    M2Stats.maxMagic = tonumber(_maxMag)
    M2Stats.pts = tonumber(_pts)
    M2Stats.blind = (_blind == "Y")
    M2Stats.deaf = (_deaf == "Y")
    M2Stats.crippled = (_crip == "Y")
    M2Stats.dumb = (_dumb == "Y")
    M2Stats.resetMins = tonumber(_mins)
    M2Stats.weather = _weather

    M2UI:updateBars()

    --cecho("\n"..M2Stats:toStringTemp())
  end

  -- Called by the qs trigger to update the stats based on parsed qs output.
  -- note: _mag may be nil.
  function MUDKIP_Mud2:updateQs(
    _effStr, _effDex, _sta, _maxSta, _mag, _pts
  )

    M2Stats.stamina = tonumber(_sta)
    M2Stats.maxStamina = tonumber(_maxSta)
    M2Stats.effStr = tonumber(_effStr)
    M2Stats.effDex = tonumber(_effDex)
    M2Stats.pts = tonumber(_pts)

    local magic = tonumber(_mag)

    if (magic ~= nil) then
      M2Stats.magic = magic
      if magic > M2Stats.maxMagic then
        M2Stats.maxMagic = magic
      end
    else
      M2Stats.magic = 0
    end
    M2UI:updateBars()

    --cecho("\n"..M2Stats:toStringTemp())
  end

  -- called by the stam update trigger to update stamina
  -- note: _maxStam may be nil.
  function MUDKIP_Mud2:updateStam(_stam, _maxStam)

    M2Stats.stamina = tonumber(_stam)
    local maxStam = tonumber(_maxStam)
    if (maxStam ~= nil) then
      -- only update maxStam if the stamina trigger showed maxStam
      M2Stats.maxStamina = maxStam
    end

    if M2Stats.stamina > M2Stats.maxStamina then
        M2Stats.maxStamina = M2Stats.stamina
      end

    --cecho("\n"..M2Stats:toStringTemp())

    M2UI:updateBars()
  end

  -- updates known points for the persona automagically whenever points get updated 
  function MUDKIP_Mud2:updatePoints(_pts)
    M2Stats.pts = tonumber(_pts)

    --cecho("\n"..M2Stats:toStringTemp())
  end

  function MUDKIP_Mud2:setDreamword(_dreamWord)
    M2Stats.dreamWord = _dreamWord
    --cecho("\n"..M2Stats:toStringTemp())
  end

  function MUDKIP_Mud2:clearDreamword()
    M2Stats.dreamWord = ""
    --cecho("\n"..M2Stats:toStringTemp())
  end

end