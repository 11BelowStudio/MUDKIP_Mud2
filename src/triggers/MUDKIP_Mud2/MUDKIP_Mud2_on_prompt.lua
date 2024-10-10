local c2d = copy2decho()
if not ((c2d == "<0,0,255:0,0,0>*<r>") or (c2d == "<0,0,255:0,0,0>(*)<r>")) then
  return
end

raiseEvent("MUDKIP_Mud2 on prompt")

MUDKIP_Mud2.map:resetMapLine()
MUDKIP_Mud2.utils:clearBlankAndDupeLines()

--[[
local thisLine = getCurrentLine()
local thisLineNumber = getLineNumber()
local blankLine = MUDKIP_Mud2:getBlankReplacePlaceholder()
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

moveCursor(0, thisLineNumber)
--]]