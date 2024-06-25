--[[
This file contains most of the code for the very cool
CLICKABLE OUTPUT OF THE 'map' COMMAND
provided by MUDKIP_Mud2.

(very epic, I know)
]]--


local M2Map = MUDKIP_Mud2.map or {}

-- initialization of stuff

M2Map.nw = "<128,0,0:0,0,0>nw<r>"
M2Map.n="<128,0,0:0,0,0>nn<r>"
M2Map.ne="<128,0,0:0,0,0>ne<r>"
M2Map.up="<128,0,0:0,0,0>up<r>"
M2Map.w="<128,0,0:0,0,0>ww<r>"
M2Map.e="<128,0,0:0,0,0>ee<r>"
M2Map.sw="<128,0,0:0,0,0>sw<r>"
M2Map.s="<128,0,0:0,0,0>ss<r>"
M2Map.se="<128,0,0:0,0,0>se<r>"
M2Map.down="<128,0,0:0,0,0>dn<r>"
M2Map._space = "<0,0,0:0,0,0> <r>"

M2Map.mapLine = 0

M2Map.validMapId = 0 -- you need to click the most recent map.

function M2Map:updateMap()
  
  self.validMapId = self.validMapId + 1
  local thisMapId = self.validMapId
  
  decho("\n"..self._space)
  dechoLink(self.nw,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'nw')","move nw",true)
  decho(self._space)
  dechoLink(self.n,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'n')","move n",true)
  decho(self._space)
  dechoLink(self.ne,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'ne')","move ne",true)
  decho(self._space)
  dechoLink(self.up,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'up')","move up",true)
  decho("\n")
  
  decho(self._space)
  dechoLink(self.w,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'w')","move w",true)
  decho(self._space)
  decho(self._space .. self._space)
  decho(self._space)
  dechoLink(self.e,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'e')","move e",true)
  decho("\n")
  
  decho(self._space)
  dechoLink(self.sw,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'sw')","move sw",true)
  decho(self._space)
  dechoLink(self.s,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'s')","move s",true)
  decho(self._space)
  dechoLink(self.se,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'se')","move se",true)
  decho(self._space)
  dechoLink(self.down,"MUDKIP_Mud2.map:attemptMove("..thisMapId..",'down')","move down",true)
  decho("\n")

end

function M2Map:attemptMove(mapId, direction)
  if (mapId == self.validMapId) then
    send(direction)
  end
end

function M2Map:resetMapLine()
  self.mapLine = 0
end

function M2Map:setUpOrDown(mapDir)
  if self.mapLine == 0 then
    self.up = mapDir
  else
    self.down = mapDir
    self:updateMap()
    self.mapLine = 0
  end
end

function M2Map:setCompassDirs(wDir,nsDir,eDir)
  if self.mapLine == 0 then
    self.nw = wDir
    self.n = nsDir
    self.ne = eDir
  elseif self.mapLine == 1 then
    self.w = wDir
    self.e = eDir
  else
    self.sw = wDir
    self.s = nsDir
    self.se = eDir
  end
  self.mapLine = self.mapLine + 1
end