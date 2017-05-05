CITY = {}

function CITY.getIncome()
  local localIncome = self.baseMaintenance + self.moneyProduced + self.buildingMaintenance
  return localIncome
end

function CITY.create(num)

end

function CITY.getUnhappiness()
  unhappinessTotal = 3
  self.unhappiness = unhappinessTotal
end

function CITY.popGrowth()
  local a = self.pop
  local b =  self.storedFood
  if b>=a then
    local eaten = self.pop*1.5
    if eaten > self.storedFood then
      eaten = self.storedFood
    end
    self.storedFood = self.storedFood-eaten
    self.popGrowthProg = self.popGrowthProg + self.pop/(eaten/5)
  else
    self.popGrowthProg = self.popGrowthprog - (a-b)
    self.storedFood = self.storedFood-self.pop
  end
  if self.popGrowthProg >= 1 then
    self.pop = self.pop+1
    self.storedFood = self.storedFood-self.pop
    self.popGrowthProg = self.popGrowthProg-1
  elseif self.popGrowthProg <  0 then
    self.pop = self.pop-1
    self.storedFood = self.storedFood-self.pop
    self.popGrowthProg = self.popGrowthProg+1
  end
end

function CITY:gameStart()
  local num = {}
  local k = 0
  for i = 1,#map do
    if map[i].type == city then
      local k = k+1
      table.insert(num, k)
    end
  end
  for i = 1,#map do
    if map[i].type == city then
      local g = #cities+1 or 1
      local name = 'ecksdee'
      local loc = i
      local team = g
      local colour = teamColours1[g]
      local cit = {name = name, loc = loc, team = team, colour = colour}

      table.insert(cities, cit)
      --[[city.pop = 1
      city.popGrowthProg = 0

      city.storedFood = 5
      city.foodStorageBase = 5
      city.foodStorageIncrease = 0
      city.farming = 0.5
      city.consumption = city.getFoodConsumption
      city.foodExcess = city.getExcessFood

      city.buildings = {}

      city.baseMaintenance = -1
      city.buildingMaintenance = 0
      city.moneyProduced = 0
      city.cityIncome = city.getIncome

      city.baseHappiness = 3
      city.unhappiness = city.getUnhappiness
      city.currHappiness = city.baseHappiness]]
    end
  end
end

function CITY:textDec()
  for i = 1,#cities do

  end
end

return CITY
