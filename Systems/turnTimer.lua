turnTimer = {}

turnLog = {}

function turnTimer:switchTurnMode()
  if autoTurn then
    autoTurn = false
  else
    autoTurn = true
  end
end

function turnTimer:addUnitMoveOrder(team, loc1, loc2, movRange, unit)
  local unitMove = {"unitMove", team, loc1, loc2, movRange, unit, complete = false}
  table.insert(turnLog, unitMove)
end

function turnTimer:addUnitBuildOrder(team, location, turnsRemaning)
  local unitBuild = {"unitBuild", location, team, turnsRemaning, complete = false}
  table.insert(turnLog, unitBuild)
end

function turnTimer:exectueLog()
  for i = 1,#turnLog do
    local log = turnLog[i]
    local log1 = turnLog[i][1]
    if log1 == "unitStatusShift" then

    elseif log1 == "unitMove" then
      unitFunc:turnTickMove(log[3], log[4], log[5], log[6])
      turnLog[i].complete = true
    elseif log1 == "unitBuild" then
      if log[4] == 1 then
        unitFunc:spawnInfantry(log[2], log[3])
        turnLog[i].complete = true
      else
        turnLog[i][4] = turnLog[i][4]-1
      end
    end
  end
  doot = true
  for k = 1,#turnLog do
    for i = 1,#turnLog do
      if turnLog[i].complete == true then
        table.remove(turnLog, i)
        break
      end
    end
  end
end

--[[function turnTimer:runTurn()
  turnTimer:executeLog()
  turnLog = {}
end]]

return turnTimer
