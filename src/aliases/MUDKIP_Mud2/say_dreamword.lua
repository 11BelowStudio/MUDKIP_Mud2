
if MUDKIP_Mud2:isInGame() then
  local dword = MUDKIP_Mud2:getDreamword()
  if dword ~= "" then
    send('say ' .. dword)
  else
    MUDKIP_Mud2:mcecho("Cannot say an unknown dreamword!","warn")
  end
end