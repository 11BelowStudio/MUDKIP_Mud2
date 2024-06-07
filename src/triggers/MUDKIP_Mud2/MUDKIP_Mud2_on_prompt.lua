raiseEvent("MUDKIP_Mud2 on prompt")

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
  if (tempLine ~= thisLine) and (thisLine ~= blankLine) then
    foundNonDuplicateLine = true
    --display("\nfound non-dupe!")
  else
    replaceLine(blankLine)
    deleteLine()
    moveCursor(0, getLineNumber() - 1)
  end
until foundNonDuplicateLine

moveCursor(0, thisLineNumber)
