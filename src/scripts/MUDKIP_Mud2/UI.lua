

-- makes sure top and bottom borders are like 1.1x font size px
if getBorderBottom() == 0 then
  setBorderBottom(select(2, calcFontSize(getFontSize())) * 1.1)
end

if getBorderTop() == 0 then
  setBorderTop(select(2, calcFontSize(getFontSize())) * 1.1)
end

local M2UI = MUDKIP_Mud2.ui

M2UI.bottomPanel =
  Geyser.Container:new(
    {
      name = "bottomPanel",
      x = 0, y = -getBorderBottom(),
      width = "100%", height = getBorderBottom(),
    }
  )

M2UI.topPanel =
  Geyser.Container:new(
    {
      name = "topPanel",
      x = 0, y = 0,
      width = "100%", height = getBorderTop()
  }
)

M2UI.stambar =
  Geyser.Gauge:new(
    {
      name = "stambar",
      x = "1.25%", y = 0,
      width = "47.5%", height = "100%",
      fontSize = getFontSize() * 0.75
    },
    M2UI.bottomPanel
  )

--M2UI.stambar.text:setStyleSheet([[
--  qproperty-font: ]].. getFontSize() .. [[pt ]]..getFont()..[[;
--]])

M2UI.magicbar =
  Geyser.Gauge:new(
    {
      name = "magicbar",
      x = "51.25%", y = 0,
      width = "47.5%", height = "100%",
      fontSize = getFontSize() * 0.75
    },
    M2UI.bottomPanel
  )


--M2UI.magicbar.text:setStyleSheet([[
--  qproperty-font: ]].. getFontSize() .. [[pt ]]..getFont()..[[;
--]])


M2UI.stambar:setColor("#00cc00")
M2UI.stambar:setText("Stamina: ?/? [Please fes or qs]")
M2UI.stambar.text:setToolTip("Pro tip: keep this above 0 to not die")

function M2UI:getPercent(_stat,_maxStat)
  return math.floor((_stat / _maxStat * 100) + 0.5)
end

--[[
  Helper function which is given a current and max stat value,
    and returns the stat thing as a percent,
    and an appropriate hex colour for it (green-red gradient)
]]--
function M2UI:getPercentAndColor(_stat,_maxStat)
  local percent = math.min(self:getPercent(_stat,_maxStat),100)
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
    theColor = "#22aa00"
  else
    theColor = "#339900"
  end

  return percent, theColor
end

--[[
give this function the known stam, maxStam,
  and calculated stam percent and colour from getPercentAndColor,
  and this will go and update the stamina bar appropriately.
]]--
function M2UI:updateStaminaBar(_stam,_maxStam,_percent,_color)

  local stamSuffix = ""
  if _percent <= 5 then
    stamSuffix = ". <i>So brave!</i>"
  elseif _percent <= 10 then
    stamSuffix = ". <i>You might want to consider fleeing.</i>"
  elseif _percent <= 20 then
    stamSuffix = ". <i>PANIC!</i>"
  elseif _percent <= 25 then
    stamSuffix = ". <i>DANGER ZONE.</i>"
  elseif _percent <= 30 then
    stamSuffix = ". <i>Not good.</i>"
  elseif _percent >= 100 then
    stamSuffix = ". <i>Good job!</i>"
  end

  self.stambar:setValue(_percent)
  self.stambar:setColor(_color)
  if _stam <= 0 then
    self.stambar:setText("You are dead.")
  else
    self.stambar:setText("Stamina: <b>" .. _stam .. "</b>/" .. _maxStam .. stamSuffix)
  end

end

M2UI.magicbar:setColor("#800080")
M2UI.magicbar:setText("Magic: <b>?</b>/? [Please fes or qs]")
M2UI.magicbar.text:setToolTip("Please fes so this bar will work thanks")


function M2UI:updateMagicBar(_mag, _maxMag)
  -- this gets the percent as an integer, rounded to the nearest whole percent
  local magicPercent = math.min(math.floor((_mag / _maxMag * 100) + 0.5),100)

  local magSuffix = ""
  local magicbar = self.magicbar

  if magicPercent <= 0 then
    magicbar:setColor("#800080")
  elseif magicPercent <= 10 then
    magicbar:setColor("#200020")
    magSuffix = ". <i>Watch out!</i>"
  elseif magicPercent <= 20 then
    magicbar:setColor("#300030")
    magSuffix = ". <i>PANIC!</i>"
  elseif magicPercent <= 25 then
    magicbar:setColor("#400040")
    magSuffix = ". <i>DANGER ZONE.</i>"
  elseif magicPercent <= 30 then
    magicbar:setColor("#500050")
    magSuffix = ". <i>Not good.</i>"
  elseif magicPercent <= 40 then
    magicbar:setColor("#600060")
  elseif magicPercent <= 60 then
    magicbar:setColor("#700070")
  elseif magicPercent <= 80 then
    magicbar:setColor("#800080")
  elseif magicPercent == 100 then
    magicbar:setColor("#a000a0")
    magSuffix = ". <i>Go FOD someone I guess???</i>"
  else
    magicbar:setColor("#900090")
  end

  magicbar:setValue(magicPercent)

  if _mag <= 0 then
    magicbar:setText("In terms of magic you have no magic.")
    magicbar.text:setToolTip("Go touch the touchstone smh my head")
  else
    magicbar:setText("Magic: <b>" .. _mag .. "</b>/" .. _maxMag .. magSuffix)
    magicbar.text:setToolTip("Have fun!")
  end
end

--"MUDKIP for MUD2 status bar!"
M2UI.leftStats =
  Geyser.Label:new(
    {
      name = "leftStats",
      x = 0,y = 0,
      width = "66%",height = "100%",
      color = "#202020",
      message = " Sta:000/000&emsp;Dex:000/000 Str:000/000&emsp;Mag:000/000&emsp;Pts:000,000",
      format = "l",
      fontSize = getFontSize() * 0.66
    },
    M2UI.topPanel
  )


M2UI.rightStats =
  Geyser.Label:new(
    {
      name = "rightStats",
      x="63%",y=0,
      width = "37%",height = "100%",
      color = "#202020",
      message = "placeholder placeholder",
      format = "r",
      fontSize = getFontSize() * 0.66
    },
    M2UI.topPanel
  )


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



function M2UI:updateTheStuff()
  -- getting stuff as local variables so there's less hassle writing it out all over again
  local _stats = MUDKIP_Mud2.stats
  
  if false then -- this is here for checking what this looks like with a LOT of numbers and stats
    _stats = {
      stamina = 888,
      maxStamina = 888,
      effStr = 888,
      str = 888,
      effDex = 828,
      dex = 847,
      magic = 888,
      maxMagic = 888,
      pts = 8888888,
      dreamWord = "sghgasgagasfg",
      blind = true,
      deaf = true,
      crippled = true,
      dumb = true,
      weather = "TStorm",
      resetMins = 163,
      initialized = false
    }
    function _stats:getWeatherString()
      return "TStorm"
    end
  end
  
  local _stam = _stats.stamina
  local _maxStam = _stats.maxStamina
  local _mag = _stats.magic
  local _maxMag = _stats.maxMagic
  local _effDex = _stats.effDex
  local _dex = _stats.dex
  local _effStr = _stats.effStr
  local _str = _stats.str
  local _pts = _stats.pts
  local _isBlind = _stats.blind
  local _isDeaf = _stats.deaf
  local _isCrippled = _stats.crippled
  local _isDumb = _stats.dumb
  local _dreamWord = _stats.dreamWord
  local _mins = _stats.resetMins
  local _weather = _stats:getWeatherString()


  -- calc additional local variables re stamina
  local stamPercent, stamColor = self:getPercentAndColor(_stam,_maxStam)

  -- use those local variables to update stambar
  self:updateStaminaBar(_stam,_maxStam,stamPercent,stamColor)

  -- and then we update the magic bar
  self:updateMagicBar(_mag,_maxMag)


  -- and now the complicated bit - putting together the status info strings :(

  local stamInfo = string.format(
    '&nbsp;Sta:<b style="color:%s;">%3d</b>/<span style="color:#00d000">%3d</span>',
    stamColor, _stam, _maxStam
  )

  local magicInfo = ""
  if _mag > 0 then
    -- only bother making the magic text if there is magic
    local _, magicColor = self:getPercentAndColor(_mag,_maxMag)

    magicInfo = string.format(
      '&nbsp;Mag:<b style="color:%s;">%3d</b>/<span style="color:#00d000">%3d</span>',
      magicColor, _mag, _maxMag
    )
  end

  local _, dexColor = self:getPercentAndColor(_effDex, _dex)

  local dexInfo = string.format(
    '&nbsp;Dex:<b style="color:%s;">%3d</b>/<span style="color:#00d000">%3d</span>',
    dexColor, _effDex, _dex
  )

  local _, strColor = self:getPercentAndColor(_effStr, _str)

  local strInfo = string.format(
    '&nbsp;Str:<b style="color:%s;">%3d</b>/<span style="color:#00d000">%3d</span>',
    strColor, _effStr, _str
  )

  local ptsString = string.format(
    '&nbsp;&nbsp;Pts:<b>%-7s</b>',
    numWithCommas(_pts)
  )

  local leftLabelText = string.format(
    [[<left style="color:#008080;">
    %s %s %s %s %s %s
    [MUDKIP v%s]</left>]],
    stamInfo, magicInfo, dexInfo, strInfo, ptsString, statusText(_isBlind,_isDeaf,_isCrippled,_isDumb),
    MUDKIP_Mud2:getVersion()
  )

  self.leftStats:echo(leftLabelText)

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
    _weather
  )

  local timeLeftText = string.format(
    'Time:<b style="color:#008080;">%3d</b>&nbsp;',
    _mins
  )

  local rightLabelText = string.format(
    [[<right style="color:#008080;">
    %s&nbsp;&nbsp;&nbsp;%s&nbsp;&nbsp;&nbsp;%s 
    </right>]],
    dreamWordText, weatherText, timeLeftText
  )

  self.rightStats:echo(rightLabelText)

end

M2UI:updateTheStuff()

--[[
Use this when uninstalling MUDKIP_Mud2.

Hides everything, and sets top/bottom borders to 0.
]]--
function M2UI:onUninstall()
  self.rightStats:hide()
  self.leftStats:hide()
  self.rightStats = nil
  self.leftStats = nil
  self.topPanel:hide()

  self.magicbar:hide()
  self.stambar:hide()
  self.magicbar = nil
  self.stambar = nil
  self.bottomPanel:hide()
  self.bottomPanel = nil

  setBorderTop(0)
  setBorderBottom(0)
end


registerAnonymousEventHandler("MUDKIP_Mud2 on prompt", "MUDKIP_Mud2.ui:updateTheStuff")
raiseEvent("MUDKIP_Mud2 on prompt")