
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

function MUDKIP_Mud2.ui:getPercent(_stat,_maxStat)
  return math.floor((_stat / _maxStat * 100) + 0.5)
end

--[[
  Helper function which is given a current and max stat value,
    and returns the stat thing as a percent,
    and an appropriate hex colour for it (green-red gradient)
]]--
function MUDKIP_Mud2.ui:getPercentAndColor(_stat,_maxStat)
  local percent = MUDKIP_Mud2.ui:getPercent(_stat,_maxStat)
  local theColor = "#ff0000"

  if percent <= 5 then
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

--[[
give this function the known stam, maxStam,
  and calculated stam percent and colour from getPercentAndColor,
  and this will go and update the stamina bar appropriately.
]]--
function MUDKIP_Mud2.ui:updateStaminaBar(_stam,_maxStam,_percent,_color)

  local stambar = MUDKIP_Mud2.stambar

  local stamSuffix = ""
  if _percent <= 5 then
    stamSuffix = ". So brave!"
  elseif _percent <= 10 then
    stamSuffix = ". You might want to consider fleeing."
  elseif _percent <= 20 then
    stamSuffix = ". PANIC!"
  elseif _percent <= 25 then
    stamSuffix = ". DANGER ZONE."
  elseif _percent <= 30 then
    stamSuffix = ". Not good."
  end

  stambar:setValue(_percent)
  stambar:setColor(_color)
  if _stam <= 0 then
    stambar:setText("You are dead.")
  else
    stambar:setText("Stamina: " .. _stam .. "/" .. _maxStam .. stamSuffix)
  end

end


function MUDKIP_Mud2.ui:updateStaminaBarOld(_stam, _maxStam)
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
  elseif hpPercent >= 100 then
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

  if _mag <= 0 then
    magicbar:setText("In terms of magic you have no magic.")
    magicbar.text:setToolTip("Go touch the touchstone smh my head")
  else
    magicbar:setText("Magic: " .. _mag .. "/" .. _maxMag .. magSuffix)
    magicbar.text:setToolTip("Have fun!")
  end
end

function MUDKIP_Mud2.ui:updateStaminaTemp()
  MUDKIP_Mud2.ui:updateStaminaBarOld(MUDKIP_Mud2.stats.stamina, MUDKIP_Mud2.stats.maxStamina)
end

function MUDKIP_Mud2.ui:updateBars()
  MUDKIP_Mud2.ui:updateStaminaBarOld(MUDKIP_Mud2.stats.stamina, MUDKIP_Mud2.stats.maxStamina)
  MUDKIP_Mud2.ui:updateMagicBar(MUDKIP_Mud2.stats.magic, MUDKIP_Mud2.stats.maxMagic)
end

--"MUDKIP for MUD2 status bar!"
MUDKIP_Mud2.leftstats =
  Geyser.Label:new(
    {
      name = "leftstats",
      x = 0,y = 0,
      width = "55%",height = "100%",
      bgColor = "black",
      message = " Sta:000/000&emsp;Dex:000/000 Str:000/000&emsp;Mag:000/000&emsp;Pts:000,000",
    },
    MUDKIP_Mud2.toppanel
  )
MUDKIP_Mud2.leftstats:setStyleSheet([[
  qproperty-alignment: 'AlignLeft | AlignVCenter';
  qproperty-font: ]].. getFontSize() .. [[pt ]]..getFont()..[[;
]])

MUDKIP_Mud2.rightstats =
  Geyser.Label:new(
    {
      name = "rightstats",
      x="55%",y=0,
      width = "45%",height = "100%",
      bgColor = "black",
      message = "placeholder placeholder"
    },
    MUDKIP_Mud2.toppanel
  )

MUDKIP_Mud2.rightstats:setStyleSheet([[
  qproperty-alignment: 'AlignRight | AlignVCenter';
  qproperty-font: ]].. getFontSize() .. [[pt ]]..getFont()..[[;
]])

-- function by Paul Kulchenko
-- https://stackoverflow.com/a/10990879
local function numWithCommas(n)
  return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
                                :gsub(",(%-?)$","%1"):reverse()
end


local function statusText(_blind,_deaf,_crippled,_dumb)
  local output = '&nbsp;<b style="color:#800000;">'

  if _blind then
    output = output .. "Bl"
  else
    output = output .. "&nbsp;&nbsp;"
  end
  output = output .. "&nbsp;"

  if _deaf then
    output = output .. "Df"
  else
    output = output .. "&nbsp;&nbsp;"
  end
  output = output .. "&nbsp;"

  if _crippled then
    output = output .. "Cr"
  else
    output = output .. "&nbsp;&nbsp;"
  end
  output = output .. "&nbsp;"

  if _dumb then
    output = output .. "Dm"
  else
    output = output .. "&nbsp;&nbsp;"
  end
  output = output .. "</b>&nbsp;"

  return output
end
  

function MUDKIP_Mud2.ui:updateTheStuff()
  -- getting stuff as local variables so there's less hassle writing it out all over again
  local _stam = MUDKIP_Mud2.stats.stamina
  local _maxStam = MUDKIP_Mud2.stats.maxStamina
  local _mag = MUDKIP_Mud2.stats.magic
  local _maxMag = MUDKIP_Mud2.stats.maxMagic
  local _effDex = MUDKIP_Mud2.stats.effDex
  local _dex = MUDKIP_Mud2.stats.dex
  local _effStr = MUDKIP_Mud2.stats.effStr
  local _str = MUDKIP_Mud2.stats.str
  local _pts = MUDKIP_Mud2.stats.pts
  local _isBlind = MUDKIP_Mud2.stats.blind
  local _isDeaf = MUDKIP_Mud2.stats.deaf
  local _isCrippled = MUDKIP_Mud2.stats.crippled
  local _isDumb = MUDKIP_Mud2.stats.dumb
  local _dreamWord = MUDKIP_Mud2.stats.dreamWord
  local _mins = MUDKIP_Mud2.stats.resetMins
  local _weather = MUDKIP_Mud2.stats.weather

  local leftStats = MUDKIP_Mud2.leftstats
  local rightStats = MUDKIP_Mud2.rightstats

  -- calc additional local variables re stamina
  local stamPercent, stamColor = MUDKIP_Mud2.ui:getPercentAndColor(_stam,_maxStam)

  -- use those local variables to update stambar
  MUDKIP_Mud2.ui:updateStaminaBar(_stam,_maxStam,stamPercent,stamColor)

  -- and then we update the magic bar
  MUDKIP_Mud2.ui:updateMagicBar(_mag,_maxMag)


  -- and now the complicated bit - putting together the status info string :(

  local stamInfo = string.format(
    '&nbsp;Sta:<b style="color:%s;">%3d</b>/<span style="color:#00d000">%3d</span>',
    stamColor, _stam, _maxStam
  )

  local magicInfo = ""
  if _mag > 0 then
    -- only bother making the magic text if there is magic
    local _, magicColor = MUDKIP_Mud2.ui:getPercentAndColor(_mag,_maxMag)

    magicInfo = string.format(
      '&nbsp;Mag:<b style="color:%s;">%3d</b>/<span style="color:#00d000">%3d</span>',
      magicColor, _mag, _maxMag
    )
  end

  local _, dexColor = MUDKIP_Mud2.ui:getPercentAndColor(_effDex, _dex)

  local dexInfo = string.format(
    '&nbsp;Dex:<b style="color:%s;">%3d</b>/<span style="color:#00d000">%3d</span>',
    dexColor, _effDex, _dex
  )

  local _, strColor = MUDKIP_Mud2.ui:getPercentAndColor(_effStr, _str)

  local strInfo = string.format(
    '&nbsp;Str:<b style="color:%s;">%3d</b>/<span style="color:#00d000">%3d</span>',
    strColor, _effStr, _str
  )

  local ptsString = string.format(
    '&nbsp;&nbsp;&nbsp;Pts:<b>%s</b>',
    numWithCommas(_pts)
  )

  local leftLabelText = string.format(
    [[<left><p style="color:#008080;">
    %s%s %s %s %s %s
    </p></left>]],
    stamInfo, magicInfo, dexInfo, strInfo, ptsString, statusText(_isBlind,_isDeaf,_isCrippled,_isDumb)
  )

  leftStats:echo(leftLabelText)

  -- and now the other label.

  if _dreamWord ~= "" then
    _dreamWord = "&nbsp;".._dreamWord.."&nbsp;"
  end

  local dreamWordText = string.format(
    '<b style="color:#000000;background-color:#008080;">%s</b>&nbsp;',
    _dreamWord
  )

  local weatherText = string.format(
    'Weather:<b style="color:#008000;">%s</b>&nbsp;',
    MUDKIP_Mud2:getWeatherString()
  )

  local timeLeftText = string.format(
    'Time:<b style="color:#008080;">%3d</b>&nbsp;',
    _mins
  )

  local rightLabelText = string.format(
    [[<right><p style="color:#008080;">
    %s&nbsp;&nbsp;&nbsp;%s&nbsp;&nbsp;&nbsp;%s 
    </p></right>]],
    dreamWordText, weatherText, timeLeftText
  )

  rightStats:echo(rightLabelText)

end



registerAnonymousEventHandler("MUDKIP_Mud2 on prompt", "MUDKIP_Mud2.ui:updateTheStuff")
-- TODO: make labels in top panel for those stats
raiseEvent("MUDKIP_Mud2 on prompt")