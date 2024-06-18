--display("ns:" .. copy2decho())
--display("w:"..copy2decho(matches.w)..",ns:"..copy2decho(matches.ns)..",e:"..copy2decho(matches.e))

MUDKIP_Mud2.map:setCompassDirs(copy2decho(matches.w),copy2decho(matches.ns),copy2decho(matches.e))
local blankLine = MUDKIP_Mud2:getBlankReplacePlaceholder()
replaceLine(blankLine)
deleteLine()
