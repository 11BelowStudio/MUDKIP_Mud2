if MUDKIP_Mud2:isInGame() then
  local dword = MUDKIP_Mud2.stats:getDreamword()
  if dword ~= "" then
    send('say ' .. string.upper(dword))
    MUDKIP_Mud2.stats:clearDreamword()
  else
    MUDKIP_Mud2:mcecho("Cannot say an unknown dreamword!","warn")
  end
end