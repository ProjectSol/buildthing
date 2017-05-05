unitFunc = {}

function unitFunc:gameStart()
  for i = 1,#cities do
    local loc1 = cities[i].loc
    mapFunc:checkAdjacent(loc1)
    a = true
    while a do
      local k = love.math.random(1,#tileOutput)
      local loc2 = tileOutput[k]
      if map[loc2].type ~= 'water' then
        unitFunc:spawnInfantry(loc2, cities[i].team)
        a = false
      end
    end
  end
end

function unitFunc:spawnInfantry(loc, team)

end

return unitFunc
