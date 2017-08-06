turnTimer = {}

turnLog = {}

phase = "movement"
phases = {"movement", "battle"}

function turnTimer:switchTurnMode()
  if autoTurn then
    autoTurn = false
  else
    autoTurn = true
  end
end

function turnTimer:switchPlayerOrDev()
  if currBuildCity then
    if currControl == 0 then
      currControl = currBuildCity.team
      dbugPrint = 'TEAM: '..tostring(currControl)
    else
      currControl = 0
      dbugPrint = 'Using the Developer Interface'
    end
  elseif currControl > 0 then

  else
    dbugPrint = 'Double click a city to join that team'
  end
end

function turnTimer:addUnitMoveOrder(team, loc1, loc2, movRange, unit)
  --entry four is the turns remaining so that the formatting for unit building doesn't look all janky
  local unitMove = {"unitMove", team, loc1, 1, loc2, movRange, unit, complete = false}
  table.insert(turnLog, unitMove)
end

function turnTimer:addUnitBuildOrder(team, location, turnsRemaning, city)
  local unitBuild = {"unitBuild", location, team, turnsRemaning, city, complete = false}
  table.insert(turnLog, unitBuild)
end

function turnTimer:exectueLog()
  for i = 1,#turnLog do
    local log = turnLog[i]
    local log1 = turnLog[i][1]
    if phase == 'movement' then
      if log1 == "unitMove" then
        unitFunc:turnTickMove(log[3], log[5], log[6], log[7])
        turnLog[i].complete = true
      elseif log1 == "unitBuild" then
        if log[4] == 1 then
          unitFunc:spawnInfantry(log[2], log[3])
          turnLog[i].complete = true
          for i = 1,#cities do
            if log1.city == cities[i].number then
              cities[i].building = false
            end
          end
        else
          turnLog[i][4] = turnLog[i][4]-1
        end
      end
    elseif phase == 'fight' then

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
