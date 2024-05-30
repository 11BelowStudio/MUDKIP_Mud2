--[[
  checks if MUDKIP thinks the player is in game.
  If so, it checks (and resets) whether it should semi-auto fes.

  If both conditions are met, this alias will cause
  the command sent by the player to have a ￼␛-[fes￼␛-] appended
  to the front of it, thereby sending a fes request along with
  the player's intended command (which allows the info panels to be updated).

  Otherwise the command is just sent as-is.

  There may be unforeseen consequences for this approach.
  But it *should* work. Hopefully.
]]--

if MUDKIP_Mud2:isInGame() and MUDKIP_Mud2:checkResetSemiAutoFes() then
  send("￼␛-[fes￼␛-]" .. command)
  return
else
  send(command)
end