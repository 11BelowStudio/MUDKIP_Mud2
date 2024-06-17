-- this alias is used to send emotes like 'laugh' when you accidentally send 'laughs' instead
if MUDKIP_Mud2:isInGame() then
  --send(matches.emote) -- matches.namedGroup doesn't work for aliases for some reason.
  send(matches[2]) -- this does seem to work. weird.
else
  -- sends command as-is if you're not in-game
  send(command)
end