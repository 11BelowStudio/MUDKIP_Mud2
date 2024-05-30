-- suppresses the auto fes when looking in the tearoom I guess
if true then
  if matches.prefix == "*" then
    deleteLine()
    moveCursor(0,getLineNumber()-1) -- moves cursor back 1 line
  end
end


MUDKIP_Mud2:updateFes(
	matches.sta,
	matches.maxSta,
	matches.effStr,
	matches.str,
	matches.effDex,
	matches.dex,
	matches.mag,
	matches.maxMag,
	matches.pts,
	matches.blind,
	matches.deaf,
	matches.crip,
	matches.dumb,
	matches.mins,
	matches.weather
)