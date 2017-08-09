unitFunc = {}

function unitFunc:gameStart()
  for i = 1,#cities do
    local loc1 = cities[i].loc
    mapFunc:checkAdjacent(loc1)
    a = true
    while a do
      local loc2 = adjOutput[love.math.random(#adjOutput)]
      if map[loc2] then
        if map[loc2].type ~= 'water' then
          unitFunc:spawnInfantry(loc2, cities[i].team)
          a = false
        end
      end
    end
  end
end

function unitFunc:spawnInfantry(loc, team)
  local infant = {name = 'infantry', team = team, selected = 0, location = loc, colour = teamColours1[team], movRange = 2, strength = 4, attacking = false, id = #units+1}
  table.insert(units, infant)
end

function unitFunc:drawAttackRadius()
  if phase == 'fight' then
  for i = 1,#units do
    if units[i].selected == 1 then
      tCol = units[i].colour
      unit1 = units[i]
      unitFunc:unitAttackRange(unit1.location, unit1.movRange+1)
      --love.graphics.print(#moveOutput or 'nope.avi', 20, 20)
      for k = 1,#attackOutput do
        love.graphics.setColor(tCol)
        createMap:genTilePos(attackOutput[k][1])
        local alignment = attackOutput[k][1]
        local dbug = attackOutput[k][4]
        local x = drawX
        local y = drawY
                          ---tr corner              tr corner               bottom
        local vertices = {x+squareSize-3, y+3, x+squareSize/2+3, y+3, x+squareSize-3, y+squareSize/2-3}
        love.graphics.setLineWidth(2)
        love.graphics.polygon('line', vertices)
      end
    end
  end
  end
end

function unitFunc:drawMovRadius()
  if phase == 'movement' then
    for i = 1,#units do
      if units[i].selected == 1 then
        tCol = units[i].colour
        unitFunc:moveLandlocked(units[i].location, units[i].movRange)
      	--love.graphics.print(#moveOutput or 'nope.avi', 20, 20)
      	for k = 1,#moveOutput do
      		love.graphics.setColor(tCol)
      		createMap:genTilePos(moveOutput[k][1])
          local alignment = moveOutput[k][1]
          local dbug = moveOutput[k][4]
      		local x = drawX
      		local y = drawY
                            ---tr corner              tr corner               bottom
      		local vertices = {x+squareSize-3, y+3, x+squareSize/2+3, y+3, x+squareSize-3, y+squareSize/2-3}
          love.graphics.setLineWidth(2)
          love.graphics.polygon('line', vertices)
          love.graphics.setColor(255,255,255)
          love.graphics.setFont(font)
          --love.graphics.print(tostring(alignment), x+3, y+3)
          --if k < 5 then
            --love.graphics.print(k, x, y+15)
          --end
          --love.graphics.setColor(255, 0, 0)
          --love.graphics.print(#moveOutput, x-400, x+15)
        end
          --[[for l = 1,#TESTTILES do
            love.graphics.setFont(status)
            love.graphics.print(#TESTTILES, 400, 400)
          end]]

      end
    end
  end
end

--[[function unitFunc:drawTESTING()
  for i = 1,#units do
    if units[i].selected == 1 then
      --unitFunc:checkGrid(units[i].location, units[i].movRange)
    	love.graphics.print(#rangeOutput or 'nope.avi', 20, 20)
    	for k = 1,#rangeOutput do
    		love.graphics.setColor(0,0,0)
    		createMap:genTilePos(rangeOutput[k])
    		local x = drawX
    		local y = drawY
                          ---tr corner              tr corner               bottom
    		local vertices = {x+squareSize-3, y-6, x+squareSize/2+3, y+3, x+squareSize-3, y+squareSize/2-3}
        love.graphics.setLineWidth(2)
        love.graphics.polygon('line', vertices)
      end
    end
  end
end]]

function unitFunc:select()
  for i = 1,#units do
    if units[i].team == currControl or currControl == 0 then
      local loc = units[i].location
      createMap:genTilePos(loc)
      worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
      localX, localY = love.mouse.getPosition()
      if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
        active = true
        for k = 1,#units do
          units[k].selected = 0
        end
        units[i].selected = 1
        active = true
        break
      else
        for k = 1,#units do
          units[k].selected = 0
        end
      end
    end
  end
end

function unitFunc:turnTickMove(loc1, loc2, movRange, unit)
  unitFunc:moveLandlocked(loc1, movRange)
  for k = 1,#moveOutput do
    if moveOutput[k][1] == loc2  then
      units[unit].location = loc2
      units[unit].selected = 0
    end
  end
end


function unitFunc:move(loc2)
  if autoTurn then
    for i = 1,#units do
      if units[i].selected == 1 then
        --unitFunc:checkGrid(units[i].location, units[i].movRange)
        unitFunc:moveLandlocked(units[i].location, units[i].movRange)
        for k = 1,#moveOutput do
          if moveOutput[k][1] == loc2  then
            units[i].location = loc2
            units[i].selected = 0
          end
        end
      end
    end
  else
    for i = 1,#units do
      if units[i].selected == 1 then
        local unit = i
        turnTimer:addUnitMoveOrder(units[i].team, units[i].location, loc2, units[i].movRange, unit)
      end
    end
  end
end

function unitFunc:moveLandlocked(tile1, range)
	mvprOutput = {}
  mvOutput = {}
	local b = tile1
	for q = -range,range do
    local tileSel = b+q
    local tileCol = tileSel%gridSize
    local tileRow = math.ceil(tileSel/gridSize)
    if tileCol == 0 then
      tileCol = gridSize
    end
    bColumn = b%gridSize
    if bColumn == 0 then
      bColumn = gridSize
    end
    --TESTTILES = {}
    if tileSel > 0 and tileSel <= gridSize^2 and tileCol == bColumn+q then
      local tile = {tileSel, tileCol, tileRow, 4}
      table.insert(mvprOutput, tile)
      --table.insert(TESTTILES, tileSel)
      --createMap:genTilePos(tileSel)
      --love.graphics.print(tostring(q), drawX+(squareSize/2), drawY+(squareSize/2))
    end

    for i = 1,#mvprOutput do
      local x = mvprOutput[i]
      if x[3] == math.ceil(b/gridSize) then
        local rnge = math.abs(b-x[1])
        local height = range-rnge
        if height == 0 then
          local tileSel = x[1]
          local tileCol = tileSel%gridSize
          local tileRow = math.ceil(tileSel/gridSize)
          if tileSel > 0 and tileSel <= gridSize^2 --[[and tileCol == bColumn+q]] then
            local tile = {tileSel, tileCol, tileRow}
            table.insert(mvOutput, tile)
          end
        else
          for k = 0,height do
            local f = -k
            local avoid = {}
            local run = true
            local tileSel = x[1]+(f*gridSize)
            local tileCol = tileSel%gridSize
            local tileRow = math.ceil(tileSel/gridSize)
            if f ~= 0 and tileSel > 0 and tileSel <= gridSize^2 then
              if map[tileSel].type == water then
                table.insert(avoid, f)
                break
              end
              for i = 0,#avoid do
                if f == avoid[i] then
                  run = false
                end
              end
            end
            if tileSel > 0 and tileSel <= gridSize^2 --[[and tileCol == bColumn+q]] and run == true then
              local tile = {tileSel, tileCol, tileRow}
              if tileSel ~= b then
                table.insert(mvOutput, tile)
                createMap:genTilePos(tileSel)
                --love.graphics.print(tostring(f), drawX+(squareSize/2), drawY+(squareSize/2))
                --love.graphics.print(tostring(k), drawX+(squareSize/2), drawY+(squareSize/2))
              else
                run = true
              end
            end
          end
          for k = 1,height do
            local run = true
            local avoid = {}
            local tileSel = x[1]+(k*gridSize)
            local tileCol = tileSel%gridSize
            local tileRow = math.ceil(tileSel/gridSize)
            if tileSel > 0 and tileSel < gridSize^2 then
              if map[tileSel].type == water then
                table.insert(avoid, k)
                break
              end
            end
            for i = 0,#avoid do
              if k == avoid[i] then
                run = false
              end
            end
            if tileSel > 0 and tileSel <= gridSize^2 --[[and tileCol == bColumn+q]] and run == true then
              local tile = {tileSel, tileCol, tileRow}
              table.insert(mvOutput, tile)
              createMap:genTilePos(tileSel)
              love.graphics.setColor(150,0,150)
              --love.graphics.print(tostring(k), drawX+(squareSize/2), drawY+(squareSize/2))
            else
              run = true
            end
          end
        end
      end
    end
    --removing water tiles
    local remove = {}
    for i = 1,#mvOutput do
      local y = mvOutput[i]
      local x = y[1]
      if map[x].type == water then
        table.insert(remove, y)
      end
    end
    --[[for i = 1,#remove do
      local df = remove[i]
      if df[3] == math.ceil(b/gridSize) then
        local rnge = math.abs(b-df[1])
        local height = range-rnge
        if height == 0 then
          local c = df[1]-b
          if c < 0 then
            if math.abs(c) == 3 then

            elseif math.abs(c) == 2 then
              table.insert(remove, df+3)
            else
              table.insert(remove, df+2)
            end
          elseif c > 0 then
            if c == 3 then
              break
            elseif c == 2 then
              table.insert(remove, df+3)
            else
              table.insert(remove, df+2)
            end
          else
            theRealTruth = 'doot'
          end
        end
      end
    end]]

    for k = 1,#remove do
      for i = 1,#mvOutput do
        local x = mvOutput[i][1]
        local q = remove[k][1]
        if x == q then
          table.remove(mvOutput, i)
          break
        end
      end
    end
    --water tiles are removed





    --[[mvprOutput = {}
    for i = 1,#mvOutput do
      local R = mvOutput[i][1]
      for k = -1,1 do
        local tileSel1 = R+k
        local tileSel2 = R+(k*gridSize)
        local tileCol1 = tileSel1%gridSize
        local tileRow1 = math.ceil(tileSel1/gridSize)
        local tileCol2 = tileSel2%gridSize
        local tileRow2 = math.ceil(tileSel2/gridSize)
        --Returns tiles in a t shape around the initial tile
        if tileSel1 > 0 and tileSel1 < gridSize^2 then
          local tile = {tileSel1, tileCol1, tileRow1, false}
          if tile[2] == R%gridSize and tile[3] == math.ceil(R/gridSize) then
            meaningoflife = 'h3xd3hdx'
          else
            table.insert(mvprOutput, tile)
          end
        end
        if tileSel2 > 0 and tileSel2 < gridSize^2 then
          local tile = {tileSel2, tileCol2, tileRow2, false}
          if tile[2] == R%gridSize and tile[3] == math.ceil(R/gridSize) then
          else
            table.insert(mvprOutput, tile)
          end
        end
      end
    end
    local remove = {}
    for k = 1,#mvprOutput do
      local q = mvprOutput[k][1]
      for i = 1,#mvOutput do
        local x = mvOutput[i][1]
        if mvOutput[i][4] == false and x == q then
           mvOutput[i][4] = true
          break
        end
      end
    end]]
    --[[for i = 1,#mvOutput do
      if mvOutput[i][4] == false then
        local x = mvOutput[i][1]
        createMap:genTilePos(x)
        love.graphics.setColor(tCol)
        love.graphics.circle('fill', drawX+(squareSize/2), drawY+(squareSize/2), 5)
        table.insert(remove, x)
      end
    end
    for k = 1,#remove do
      for i = 1,#mvOutput do
        local x = mvOutput[i][1]
        local q = remove[k]
        if x == q then
          table.remove(mvOutput, i)
          break
        end
      end
    end]]
    local mviOutput = {}
    for i = 1,#mvOutput do
      local x = mvOutput[i][1]
      local inp = true
      for k = 1,#mviOutput do
        if mviOutput[k][1] == x then
          inp = false
        end
      end
      if inp == true then
        table.insert(mviOutput, mvOutput[i])
      end
    end

    moveOutput = {}
    for i = 1,#mviOutput do
      table.insert(moveOutput, mviOutput[i])
    end
  end
end

function unitFunc:unitAttackRange(tile1, range)
  	atkprOutput = {}
    atkOutput = {}
  	local b = tile1
  	for q = -(range-1),(range-1) do
      local tileSel = b+q
      local tileCol = tileSel%gridSize
      local tileRow = math.ceil(tileSel/gridSize)
      if tileCol == 0 then
        tileCol = gridSize
      end
      bColumn = b%gridSize
      if bColumn == 0 then
        bColumn = gridSize
      end
      --TESTTILES = {}
      if tileSel > 0 and tileSel <= gridSize^2 and tileCol == bColumn+q then
        local tile = {tileSel, tileCol, tileRow, 4}
        table.insert(atkprOutput, tile)
        --table.insert(TESTTILES, tileSel)
        --createMap:genTilePos(tileSel)
        --love.graphics.print(tostring(q), drawX+(squareSize/2), drawY+(squareSize/2))
      end

      for i = 1,#atkprOutput do
        local x = atkprOutput[i]
        if x[3] == math.ceil(b/gridSize) then
          local rnge = math.abs(b-x[1])
          local height = (range-1)-rnge
          if height == 0 then
            local tileSel = x[1]
            local tileCol = tileSel%gridSize
            local tileRow = math.ceil(tileSel/gridSize)
            if tileSel > 0 and tileSel <= gridSize^2 --[[and tileCol == bColumn+q]] then
              local tile = {tileSel, tileCol, tileRow}
              table.insert(atkOutput, tile)
            end
          else
            for k = 0,height do
              local f = -k
              local avoid = {}
              local run = true
              local tileSel = x[1]+(f*gridSize)
              local tileCol = tileSel%gridSize
              local tileRow = math.ceil(tileSel/gridSize)
              if f ~= 0 and tileSel > 0 and tileSel <= gridSize^2 then
                if map[tileSel].type == water then
                  table.insert(avoid, f)
                  break
                end
                for i = 0,#avoid do
                  if f == avoid[i] then
                    run = false
                  end
                end
              end
              if tileSel > 0 and tileSel <= gridSize^2 --[[and tileCol == bColumn+q]] and run == true then
                local tile = {tileSel, tileCol, tileRow}
                if tileSel ~= b then
                  table.insert(atkOutput, tile)
                  createMap:genTilePos(tileSel)
                  --love.graphics.print(tostring(f), drawX+(squareSize/2), drawY+(squareSize/2))
                  --love.graphics.print(tostring(k), drawX+(squareSize/2), drawY+(squareSize/2))
                else
                  run = true
                end
              end
            end
            for k = 1,height do
              local run = true
              local avoid = {}
              local tileSel = x[1]+(k*gridSize)
              local tileCol = tileSel%gridSize
              local tileRow = math.ceil(tileSel/gridSize)
              if tileSel > 0 and tileSel < gridSize^2 then
                if map[tileSel].type == water then
                  table.insert(avoid, k)
                  break
                end
              end
              for i = 0,#avoid do
                if k == avoid[i] then
                  run = false
                end
              end
              if tileSel > 0 and tileSel <= gridSize^2 --[[and tileCol == bColumn+q]] and run == true then
                local tile = {tileSel, tileCol, tileRow}
                table.insert(atkOutput, tile)
                createMap:genTilePos(tileSel)
                love.graphics.setColor(150,0,150)
                --love.graphics.print(tostring(k), drawX+(squareSize/2), drawY+(squareSize/2))
              else
                run = true
              end
            end
          end
        end
      end

      --removing water tiles
      local remove = {}
      for i = 1,#atkOutput do
        local y = atkOutput[i]
        local x = y[1]
        if map[x].type == water then
          table.insert(remove, y)
        end
      end

      for k = 1,#remove do
        for i = 1,#atkOutput do
          local x = atkOutput[i][1]
          local q = remove[k][1]
          if x == q then
            table.remove(atkOutput, i)
            break
          end
        end
      end
      --water tiles are removed

      local atkiOutput = {}
      for i = 1,#atkOutput do
        local x = atkOutput[i][1]
        local inp = true
        for k = 1,#atkiOutput do
          if atkiOutput[k][1] == x then
            inp = false
          end
        end
        if inp == true then
          table.insert(atkiOutput, atkOutput[i])
        end
      end

      attackOutput = {}
      for i = 1,#atkiOutput do
        table.insert(attackOutput, atkiOutput[i])
      end
    end
  end


function unitFunc:checkGrid(tile1, range)
	rngOutput = {}
  rangeOutput = {}
	local b = tile1
	for q = -range,range do
    for k = -range,range do
      --[[if k == 0 and q == 0 then
        theRealTruth = 'hah, lol prankd u gud famalam'
      else]]
        tileSel = b+(k*gridSize)+q
        tileCol = tileSel%gridSize
        tileRow = math.ceil(tileSel/gridSize)
        if tileCol == 0 then
          tileCol = 35
        end
        bColumn = b%gridSize
        if bColumn == 0 then
          bColumn = 35
        end
        if tileCol then
          if tileSel > 0 and tileSel < gridSize^2 and tileCol == bColumn+q then
            table.insert(rngOutput, tileSel)
          end
        end
      --end
    end
    rangeOutput = {}
    --run = true
    for i = 1,#rngOutput do
      table.insert(rangeOutput, rngOutput[i])
    end
    rngOutput = {}
  end
end

return unitFunc
