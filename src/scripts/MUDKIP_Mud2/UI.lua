
if getBorderBottom() == 0 then
  setBorderBottom(select(2, calcFontSize(getFontSize())) * 1.1)
end

if getBorderTop() == 0 then
  setBorderTop(select(2, calcFontSize(getFontSize())) * 1.1)
end

MUDKIP_Mud2.bottompanel =
  Geyser.Container:new(
    {
      name = "bottompanel",
      x = 0, y = -getBorderBottom(),
      width = "100%", height = getBorderBottom(),
    }
  )

MUDKIP_Mud2.toppanel =
  Geyser.Container:new(
    {
      name = "toppanel",
      x = 0, y = 0,
      width = "100%", height = getBorderTop()
  }
)

MUDKIP_Mud2.stambar =
  Geyser.Gauge:new(
    {
      name = "stambar",
      x = "1.25%", y = 0,
      width = "47.5%", height = "100%"
    },
    MUDKIP_Mud2.bottompanel
  )

MUDKIP_Mud2.magicbar =
  Geyser.Gauge:new(
    {
      name = "magicbar",
      x = "51.25%", y = 0,
      width = "47.5%", height = "100%"
    },
    MUDKIP_Mud2.bottompanel
  )

MUDKIP_Mud2.stambar:setColor("#00cc00")
MUDKIP_Mud2.stambar:setText("Stamina: ?/? [Please fes or qs]")
MUDKIP_Mud2.stambar.text:setToolTip("Pro tip: keep this above 0 to not die")

--[[
  Helper function which is given a current and max stat value,
    and returns the stat thing as a percent,
    and an appropriate hex colour for it (green-red gradient)
]]--
function MUDKIP_Mud2.ui:getPercentAndColor(_stat,_maxStat)
  local percent = math.floor((_stat / _maxStat * 100) + 0.5)
  local theColor = "#ff0000"

  if percent <= 0 then
    theColor =  "#ff0000"
  elseif percent <= 5 then
    theColor = "#ff0000"
  elseif percent <= 10 then
    theColor = "#ee0000"
  elseif percent <= 20 then
    theColor = "#cc0000"
  elseif percent <= 25 then
    theColor = "#aa0000"
  elseif percent <= 30 then
    theColor = "#880000"
  elseif percent <= 40 then
    theColor = "#884400"
  elseif percent <= 50 then
    theColor = "#886600"
  elseif percent <= 60 then
    theColor = "#888800"
  elseif percent <= 70 then
    theColor = "#668800"
  elseif percent <= 80 then
    theColor = "#448800"
  elseif percent == 100 then
    theColor = "#00d000"
  else
    theColor = "#00cc00"
  end

  return percent, theColor
end


function MUDKIP_Mud2.ui:updateStaminaBar(_stam, _maxStam)
  -- this gets the percent as an integer, rounded to the nearest whole percent
  local hpPercent = math.floor((_stam / _maxStam * 100) + 0.5)

  local stamSuffix = ""
  local stambar = MUDKIP_Mud2.stambar

  if hpPercent <= 0 then
    stambar:setColor("#ff0000")
  elseif hpPercent <= 5 then
    stambar:setColor("#ff0000")
    stamSuffix = ". So brave!"
  elseif hpPercent <= 10 then
    stambar:setColor("#ee0000")
    stamSuffix = ". You might want to consider fleeing."
  elseif hpPercent <= 20 then
    stambar:setColor("#cc0000")
    stamSuffix = ". PANIC!"
  elseif hpPercent <= 25 then
    stambar:setColor("#aa0000")
    stamSuffix = ". DANGER ZONE."
  elseif hpPercent <= 30 then
    stambar:setColor("#880000")
    stamSuffix = ". Not good."
  elseif hpPercent <= 40 then
    stambar:setColor("#884400")
  elseif hpPercent <= 50 then
    stambar:setColor("#886600")
  elseif hpPercent <= 60 then
    stambar:setColor("#888800")
  elseif hpPercent <= 70 then
    stambar:setColor("#668800")
  elseif hpPercent <= 80 then
    stambar:setColor("#448800")
  elseif hpPercent == 100 then
    stambar:setColor("#00d000")
    stamSuffix = ". Good job!"
  else
    stambar:setColor("#00cc00")
  end

  stambar:setValue(hpPercent)

  if hpPercent <= 0 then
    stambar:setText("You are dead.")
  else
    stambar:setText("Stamina: " .. _stam .. "/" .. _maxStam .. stamSuffix)
  end
end

MUDKIP_Mud2.magicbar:setColor("#800080")
MUDKIP_Mud2.magicbar:setText("Magic: ?/? [Please fes or qs]")
MUDKIP_Mud2.magicbar.text:setToolTip("Please fes so this bar will work thanks")





function MUDKIP_Mud2.ui:updateMagicBar(_mag, _maxMag)
  -- this gets the percent as an integer, rounded to the nearest whole percent
  local magicPercent = math.floor((_mag / _maxMag * 100) + 0.5)

  local magSuffix = ""
  local magicbar = MUDKIP_Mud2.magicbar

  if magicPercent <= 0 then
    magicbar:setColor("#800080")
  elseif magicPercent <= 10 then
    magicbar:setColor("#200020")
    magSuffix = ". Watch out!"
  elseif magicPercent <= 20 then
    magicbar:setColor("#300030")
    magSuffix = ". PANIC!"
  elseif magicPercent <= 25 then
    magicbar:setColor("#400040")
    magSuffix = ". DANGER ZONE."
  elseif magicPercent <= 30 then
    magicbar:setColor("#500050")
    magSuffix = ". Not good."
  elseif magicPercent <= 40 then
    magicbar:setColor("#600060")
  elseif magicPercent <= 60 then
    magicbar:setColor("#700070")
  elseif magicPercent <= 80 then
    magicbar:setColor("#800080")
  elseif magicPercent == 100 then
    magicbar:setColor("#a000a0")
    magSuffix = ". Go FOD someone I guess???"
  else
    magicbar:setColor("#900090")
  end

  magicbar:setValue(magicPercent)

  if magicPercent <= 0 then
    magicbar:setText("In terms of magic you have no magic.")
    magicbar.text:setToolTip("Go touch the touchstone smh my head")
  else
    magicbar:setText("Magic: " .. _mag .. "/" .. _maxMag .. magSuffix)
    magicbar.text:setToolTip("Have fun!")
  end
end

function MUDKIP_Mud2.ui:updateStaminaTemp()
  MUDKIP_Mud2.ui:updateStaminaBar(MUDKIP_Mud2.stats.stamina, MUDKIP_Mud2.stats.maxStamina)
end

function MUDKIP_Mud2.ui:updateBars()
  MUDKIP_Mud2.ui:updateStaminaBar(MUDKIP_Mud2.stats.stamina, MUDKIP_Mud2.stats.maxStamina)
  MUDKIP_Mud2.ui:updateMagicBar(MUDKIP_Mud2.stats.magic, MUDKIP_Mud2.stats.maxMagic)
end

--"MUDKIP for MUD2 status bar!"
MUDKIP_Mud2.statslabel =
  Geyser.Label:new(
    {
      name = "statslabel",
      x = 0,y = 0,
      width = "75%",height = "100%",
      bgColor = "black",
      message = "Sta:000/000&emsp;Dex:000/000 Str:000/000&emsp;Mag:000/000&emsp;Pts:000,000",
    },
    MUDKIP_Mud2.toppanel
  )


  MUDKIP_Mud2.statslabel =
  Geyser.Label:new(
    {
      name = "statslabel",
      x = 0,y = 0,
      width = "75%",height = "100%",
      bgColor = "black",
      message = "Sta:000/000&emsp;Dex:000/000 Str:000/000&emsp;Mag:000/000&emsp;Pts:000,000",
    },
    MUDKIP_Mud2.toppanel
  )



registerAnonymousEventHandler("MUDKIP_Mud2 on prompt", "MUDKIP_Mud2.ui:updateBars")
-- TODO: make labels in top panel for those stats
raiseEvent("MUDKIP_Mud2 on prompt")