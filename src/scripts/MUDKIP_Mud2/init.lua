--[[
MUDKIP for MUD2
(Multi User Dungeon Kool Information Panels)

]]--

if not MUDKIP_Mud2 then

  _G.MUDKIP_Mud2 = {}

  MUDKIP_Mud2.AppName = "__PKGNAME__"

  MUDKIP_Mud2._VERSION = getPackageInfo("__PKGNAME__","version")

  --[[--
  simply returns the version of MUDKIP_Mud2
  @treturn string version string
  ]]
  function MUDKIP_Mud2:getVersion()
    return MUDKIP_Mud2._VERSION
  end


  --[[--
  A wrapper function around cecho for MUDKIP to cecho MUDKIP-specific messages (with MUDKIP prefixes) to the main console.

  @string _message - the message to cecho to the main console. colour will be reset by default.
  @string[opt] _messageType - type of message. optional. 'error'/'warn'/'info' have preformatted types. nil/empty omitted. anything else displayed as-is.
  ]]
  function MUDKIP_Mud2:mcecho(_message, _messageType)
    local prefix = "\n<b><DarkOrange>[<ansiLightCyan>MUDKIP<DarkOrange>]"
    local type = ""
    -- first check if the message string isn't nil
    if (_messageType ~= nil) and (#string.gsub(_messageType, "^%s*(.-)%s*$", "%1") ~= 0) then
      if _messageType == "error" then
        type = " <ansiLightRed>ERROR!"
      elseif _messageType == "warn" or _messageType == "warning" then
        type = " <ansiYellow>WARN"
      elseif _messageType == "info" then
        type = " <ansiLightYellow>INFO"
      else
        type = " " .. _messageType
      end
    end
    local endprefix = "</b></i></u></o></s><reset> - "

    cecho("main",prefix .. type .. endprefix .. _message)
  end

  MUDKIP_Mud2.updates = MUDKIP_Mud2.updates or {}

  local M2Updates = MUDKIP_Mud2.updates

  function MUDKIP_Mud2:getUpdates()
    return self.updates
  end

  MUDKIP_Mud2.utils = MUDKIP_Mud2.utils or {}

  function MUDKIP_Mud2:getUtils()
    return self.utils
  end

  local M2Utils = MUDKIP_Mud2.utils

  MUDKIP_Mud2.map = MUDKIP_Mud2.map or {}

  function MUDKIP_Mud2:getMap()
    return self.map
  end

  local M2Map = MUDKIP_Mud2.map

  --local M2UI = {}

  MUDKIP_Mud2.ui = MUDKIP_Mud2.ui or {}

  local M2UI = MUDKIP_Mud2.ui

  function MUDKIP_Mud2:getUI()
    return self.ui
  end

  MUDKIP_Mud2.stats = MUDKIP_Mud2.stats or {}

  function MUDKIP_Mud2:getStats()
    return self.stats
  end

  local M2Stats = MUDKIP_Mud2.stats

  

  MUDKIP_Mud2._isInGame = false

  -- use this to update whether or not the player is in game
  function MUDKIP_Mud2:setInGame(_isInGame)
    self._isInGame = _isInGame
  end

  -- returns true if currently in-game
  function MUDKIP_Mud2:isInGame()
    return self._isInGame
  end

  -- hopefully nobody is going to be able to output this exact line.
  MUDKIP_Mud2._BLANK = '!!~MUDKIPBLANK~!! ".fo.qq. ".fo.qq.$!!~MUDKIPBLANK~!!'

  function MUDKIP_Mud2:getBlankReplacePlaceholder()
    return self._BLANK
  end


  MUDKIP_Mud2:mcecho("MUDKIP_Mud2 v" .. MUDKIP_Mud2:getVersion() .. " initialized!\n", "info")

  -- this is called on an uninstall event.
  function MUDKIP_Mud2:Uninstall(event, package)
    -- if we've uninstalled MUDKIP_Mud2
    if package == self.AppName then
      local is_updating = self.updates:isUpdating()
      if is_updating then
        self:mcecho("MUDKIP_Mud2 auto update in progress!","info")
      else
        self:mcecho("Uninstalling MUDKIP_Mud2, please come back soon!","info")
      end
      self.ui:onUninstall()
      _G.MUDKIP_Mud2 = nil
      return false
    else
      return true
    end
  end

end

registerNamedEventHandler(
  MUDKIP_Mud2.AppName,
  "__PKGNAME__UninstallHandler",
  "sysUninstallPackage",
  function (event, package)
    return MUDKIP_Mud2:Uninstall(event, package)
  end,
  true
)