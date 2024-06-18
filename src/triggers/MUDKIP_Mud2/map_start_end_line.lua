--display("updown:" .. copy2decho())
--display("updown:" .. copy2decho(matches.updown))
local updown = copy2decho(matches.updown)

local thisLine = getCurrentLine()
local thisLineNumber = getLineNumber()
local blankLine = MUDKIP_Mud2:getBlankReplacePlaceholder()
replaceLine(blankLine)
deleteLine()
MUDKIP_Mud2.utils:clearBlankAndDupeLines()
--[[
local foundNonDuplicateLine = false
--local thisUnformatted = copy2decho()
--display(thisUnformatted)
moveCursor(0, getLineNumber() - 1)

repeat
  local tempLine = getCurrentLine()
  --local thisUnformatted = copy2decho()
  --display(thisUnformatted .. "\n")
  if (tempLine ~= "") and (tempLine ~= thisLine) and (thisLine ~= blankLine) then
    foundNonDuplicateLine = true
    --display("\nfound non-dupe!")
  else
    replaceLine(blankLine)
    deleteLine()
    moveCursor(0, getLineNumber() - 1)
  end
until foundNonDuplicateLine
]]--

MUDKIP_Mud2.map:setUpOrDown(updown)