-- suppresses the auto fes when looking in the tearoom I guess
-- along with the semi-auto fes thing
if true then

	local blankText = MUDKIP_Mud2:getBlankReplacePlaceholder()

  if matches.prefix == "*" then
		replaceLine(blankText)
    deleteLine()
  else
		-- if this wasn't preceeded by a 'fes' line (if this was from a user-requested fes), we hide this fes
    local fesLineNumber = getLineNumber()
    moveCursor(0,getLineNumber()-1)
    local prevLine = getCurrentLine()
    if prevLine ~= "fes" then
      moveCursor(0, fesLineNumber)
			replaceLine(blankText)
      deleteLine()
    end
  end
end


MUDKIP_Mud2.stats:updateFes(
	matches.sta,
	matches.maxSta,
	matches.effStr,
	matches.str,
	matches.effDex,
	matches.dex,
	matches.mag,
	matches.maxMag,
	matches.pts:gsub(",", ""),
	matches.blind,
	matches.deaf,
	matches.crip,
	matches.dumb,
	matches.mins,
	matches.weather
)