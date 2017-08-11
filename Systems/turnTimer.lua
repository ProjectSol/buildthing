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

function turnTimer:runInfantBuild()
  if currBuildCity and cityPanel3Display and currBuildCity.building ~= true then
    local c = love.math.random(-1,1)
    local m = love.math.random(-1,1)
    local g = (gridSize*m)+c
    local f = currBuildCity.loc
    turnTimer:addUnitBuildOrder(currBuildCity.team, f, 2, currBuildCity.number)
    currBuildCity.building = true
  end
end

function turnTimer:switchPlayerOrDev()
  --dbugPrint = currControl
  if currBuildCity then
    if currControl == 0 then
      currControl = currBuildCity.team
    --  dbugPrint = 'TEAM: '..tostring(currControl)
    else
      currControl = 0
    --  dbugPrint = 'Using the Developer Interface'
    end
  elseif currControl >= 1 then
    currControl = 0
  else
    --dbugPrint = 'Double click a city to join that team'
  end
end

function turnTimer:addUnitMergeOrder()

end

function turnTimer:addUnitMoveOrder(team, loc1, loc2, movRange, unit)
  --entry four is the turns remaining so that the formatting for unit building doesn't look all janky
  if phase == 'movement' then
    local unitMove = {"unitMove", team, loc1, 1, loc2, movRange, unit, complete = false}
    table.insert(turnLog, unitMove)
  end
end

function turnTimer:addUnitBuildOrder(team, location, turnsRemaning, city)
  local unitBuild = {"unitBuild", location, team, turnsRemaning, city, complete = false}
  table.insert(turnLog, unitBuild)
end

function turnTimer:addUnitAttackOrder(unit1, unit2)
  --[[for k = 1,#units do
    if units[k].selected == 1 then
      unit1 = units[k]
      unitFunc:unitAttackRange(unit1.location, unit1.movRange+1)
    end
    for i = 1,#attackOutput do
      if unit2.loc == attackOutput[i] then]]
        --[[local attackOrder = {"attackOrder", unit1, unit2, 1, complete = false}
        table.insert(turnLog, attackOrder)]]
        --notUnselected = false
      --[[end
    end
  end]]
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
          cities[log[5]].building = false
        else
          turnLog[i][4] = turnLog[i][4]-1
        end
      end
      --phase = 'fight'
    elseif phase == 'fight' then
      if log1 == "attackOrder" then
        unitFunc:unitAttackRange(log[2].location, log[2].movRange)
        for i = 1,#attackOutput do
          if log[3].location == attackOutput[i] then
            dbugPrint = 'yes'
            local unit1Strength = log[2].strength
            local unit2Strength = log[3].strength
            if log[3].attacking then
              output1 = (unit2Strength/4)*0.8
              output2 = unit2Strength/4
              if output1 < 1 then
                output1 = 1
              end
              if output2 < 1 then
                output2 = 1
              end
            else
              output1 = (unit2Strength/4)
              output2 = unit2Strength/4
              if output1 < 1 then
                output1 = 1
              end
              if output2 < 1 then
                output2 = 1
              end
            end
            for i = 1,#units do
              if units[i].id == log[3].id then
                units[i].strength = units[i].strength-output1
              end
              if units[i].id == log[2].id then
                units[i].strength = units[i].strength-output2
              end
            end
            log.complete = true
          end
        end
      else
        dbugPrint = 'A unit was out of range'
        log.complete = true
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
  if phase == 'movement' and autoTurn then
    phase = 'fight'
  elseif phase == 'movement' and not autoTurn then
    phase = 'movement'
  elseif phase == 'fight' then
    phase = 'movement'
  end
  local remove = {}
  for i = 1,#units do
    local y = units[i]
    local x = y[1]
    if y.strength <= 0 then
      table.insert(remove, y)
    end
  end

  for k = 1,#remove do
    for i = 1,#units do
      local x = units[i].location
      local q = remove[k].location
      if x == q then
        table.remove(units, i)
        break
      end
    end
  end
end

return turnTimer
