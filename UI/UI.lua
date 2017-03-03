UI = {}

function UI:drawUI()
  --[[Food(stop soldiers and civilians alike from starving),
      Money(used to build, buy and fund other programs),
      metal(Used to build or as a trade resource),
      Ammunition(Troops with no bullets, are troops that stop being scary),
      Waste(Split into trench waste and city waste, how likely soldiers are to become diseased, how like civvies are to become diseased),
      Trade Goods(When kept at home give a bonus to happiness, smaller than luxuries, can be converted directly to money),
      Luxuries (Soap, Chocolate, The Arts, very good at keeping people happy, but are burnt through quickly and cost a lot)]]
  UI:drawStatusBar()
  UI:drawFancyShit()
  --UI:drawUnits()
end

function UI:loadDescriptions()
  moneyDescription =
  [[  This is a representation of the amount of money your
  empire has. Having your money reduced to zero or
  below while your income is negative will apply penalties
  to all aspects of your empire.

  ($]]..player.resources.money..moneyIncome..[[)

  +"grossIncome"
  -"unitMaint"-"buildingMaint"-"prjctCost"
  -"tradedAway"+"tradedFor"]]
  metalDescription =
  [[  This is a representation of the amount of raw metal
  your empire has. Metal is used create buildings
  for your cities, manufacture ammunition and fund
  projects to enhance your empire.

  (]]..player.resources.metal..metalIncome..[[)

  +"grossIncome"
  -"buidlingMaint"-"ammoMnu"-"prjctCost"
  -"tradedAway"+"tradedFor"]]
  foodDescription =
  [[  This is a representation of the amount of food your
  empire has. Food is used to stop your civilians and
  soldiers dying of starvation, excess food can be used to
  trade.

  (]]..player.resources.food..foodIncome..[[)

  +"grossIncome"
  -"civEat"-"soldierEat"
  -"tradedAway"+"tradedFor"]]
  ammunitionDescription =
  [[  This is a representation of the amount of ammunition
  your empire has. Without bullets your soldiers can't
  shoot your enemies, or defend your borders. Keep the
  chain of supply and demand going and you're one step
  closer to defeating your enemies.

  (]]..player.resources.ammunition..ammunitionIncome..[[)

  +grossIncome
  -"supplyToArmy"
  -"tradedAway"+"tradedFor"]]
  luxuriesDescription =
  [[  This is a representation of the ability of your population
  to indlge in luxuries like a hot shower and a night at
  the theatre. This resource has a much larger impact on
  global happiness than trade goods, but are also far
  more difficult to produce.

  (]]..player.resources.luxuries..luxuriesIncome..[[)

  +grossIncome
  -"populousConsumption"
  -"tradedAway"+"tradedFor"]]
  tradeGoodsDescription =
  [[  This is a representation of the amount of goods that your
  your empire produces that have no immediate impact on
  your war effort. These trade goods when kept in high
  numbers keep your populous happy, of course, for the
  more monetarily minded, these goods can be converted
  into cash quickly.

  (]]..player.resources.tradeGoods..tradeGoodsIncome..[[)

  +grossIncome
  -"populousConsumption"-"amountSoldEnMasse"
  -"tradedAway"+"tradedFor"]]
  wasteDescription =
  [[  This is a representation of the cleanliness of your
  empires cites. The higher this number, the
  unhappier your people.

  (]]..player.resources.waste..[[)

  +"grossCityWaste"
  -"buildingEffects"-"projectEffects"
  ]]
end

function UI:updateDisplay()
  if player.income.money >= 0 then
    moneyIncome = ' + '..player.income.money
  elseif player.income.money < 0 then
    moneyIncome = ' - '..math.abs(player.income.money)
  end
  moneyDisplay = love.graphics.newText( status, ' = '..player.resources.money..moneyIncome)

  if player.income.metal >= 0 then
    metalIncome = ' + '..player.income.metal
  elseif player.income.metal < 0 then
    metalIncome = ' - '..math.abs(player.income.metal)
  end
  metalDisplay = love.graphics.newText( status, ' = '..player.resources.metal..metalIncome)

  if player.income.food >= 0 then
    foodIncome = ' + '..player.income.food
  elseif player.income.food < 0 then
    foodIncome = ' - '..math.abs(player.income.food)
  end
  foodDisplay = love.graphics.newText( status, ' = '..player.resources.food..foodIncome)

  if player.income.tradeGoods >= 0 then
    tradeGoodsIncome = ' + '..player.income.tradeGoods
  elseif player.income.tradeGoods < 0 then
    tradeGoodsIncome = ' - '..math.abs(player.income.tradeGoods)
  end
  tradeGoodsDisplay = love.graphics.newText( status, ' = '..player.resources.tradeGoods..tradeGoodsIncome)

  if player.income.luxuries >= 0 then
    luxuriesIncome = ' + '..player.income.luxuries
  elseif player.income.luxuries < 0 then
    luxuriesIncome = ' - '..math.abs(player.income.luxuries)
  end
  luxuriesDisplay = love.graphics.newText( status, ' = '..player.resources.luxuries..luxuriesIncome)

  if player.income.ammunition >= 0 then
    ammunitionIncome = ' + '..player.income.ammunition
  elseif player.income.ammunition < 0 then
    ammunitionIncome = ' - '..math.abs(player.income.ammunition)
  end
  ammunitionDisplay = love.graphics.newText( status, ' = '..player.resources.ammunition..ammunitionIncome)
  if player.income.waste >= 0 then
    wasteIncome = ' + '..player.income.waste
  elseif player.income.waste < 0 then
    wasteIncome = ' - '..math.abs(player.income.waste)
  end
  wasteDisplay = love.graphics.newText( status, ' = '..player.resources.waste)
end

function UI:symbols()
  local baseTipPanel = gui.create( "panel" )
  baseTipPanel:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  baseTipPanel:setSize( 600,400 )
  function baseTipPanel:paint(w, h)
    if basePanel then
      love.graphics.setColor(200, 200, 200)
      love.graphics.rectangle( "fill", 0, 0, w, h)
    end
  end

  local moneySymb = gui.create( "panel" ) -- create a panel object
  moneySymb:setPos( 0, 0 ) -- set position to 200, 200
  moneySymb:setSize( 30, 30 ) -- set width and height to 150, 150
  function moneySymb:paint(w, h)
    love.graphics.setColor(200, 200, 10)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end
  function moneySymb:onCursorEntered()
    moneyToolTip = true
    basePanel = true
  end
  function moneySymb:onCursorExited()
    moneyToolTip = false
    basePanel = false
  end

  local moneyTip = gui.create( "button" )
  moneyTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  moneyTip:setSize( 600,400 )
  moneyTip:setTextOffset(0,moneyTip:getHeight()/2-40)
  function moneyTip:paint(w, h)
    if moneyToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w, h, 10, 10, 20 )
      --love.graphics.print(moneyTip.__text, moneyTip:getPos())
      moneyTip:setText(moneyDescription)
    else
      moneyTip:setText('')
    end
  end

  local metalSymb = gui.create( "panel" )
  metalSymb:setPos(150, 0)
  metalSymb:setSize(30, 30)
  function metalSymb:paint(w, h)
    love.graphics.setColor(150, 150, 150)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end
  function metalSymb:onCursorEntered()
    metalToolTip = true
    basePanel = true
  end
  function metalSymb:onCursorExited()
    metalToolTip = false
    basePanel = false
  end

  local metalTip = gui.create( "button" )
  metalTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  metalTip:setSize( 600,400 )
  function metalTip:paint(w, h)
    if metalToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w, h, 10, 10, 20 )
      metalTip:setTextOffset(0,metalTip:getHeight()/2-40)
      metalTip:setText(metalDescription)
    else
      metalTip:setText('')
    end
  end

  local ammunitionSymb = gui.create( "panel" )
  ammunitionSymb:setPos(300, 0)
  ammunitionSymb:setSize(30, 30)
  function ammunitionSymb:paint(w, h)
    love.graphics.setColor(150, 50, 50)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end
  function ammunitionSymb:onCursorEntered()
    ammunitionToolTip = true
    basePanel = true
  end
  function ammunitionSymb:onCursorExited()
    ammunitionToolTip = false
    basePanel = false
  end

  local ammunitionTip = gui.create( "button" )
  ammunitionTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  ammunitionTip:setSize( 600,400 )
  function ammunitionTip:paint(w, h)
    if ammunitionToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w, h, 10, 10, 20 )
      ammunitionTip:setTextOffset(0,ammunitionTip:getHeight()/2-40)
      ammunitionTip:setText(ammunitionDescription)
    else
      ammunitionTip:setText('')
    end
  end

  local foodSymb = gui.create( "panel" )
  foodSymb:setPos(450, 0)
  foodSymb:setSize(30, 30)
  function foodSymb:paint(w, h)
    love.graphics.setColor(75, 150, 50)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end
  function foodSymb:onCursorEntered()
    foodToolTip = true
    basePanel = true
  end
  function foodSymb:onCursorExited()
    foodToolTip = false
    basePanel = false
  end

  local foodTip = gui.create( "button" )
  foodTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  foodTip:setSize( 600,400 )
  function foodTip:paint(w, h)
    if foodToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w, h, 10, 10, 20 )
      foodTip:setTextOffset(0,foodTip:getHeight()/2-40)
      foodTip:setText(foodDescription)
    else
      foodTip:setText('')
    end
  end

  local luxuriesSymb = gui.create( "panel" )
  luxuriesSymb:setPos(600, 0)
  luxuriesSymb:setSize(30, 30)
  function luxuriesSymb:paint(w, h)
    love.graphics.setColor(150, 25, 150)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end
  function luxuriesSymb:onCursorEntered()
    luxuriesToolTip = true
    basePanel = true
  end
  function luxuriesSymb:onCursorExited()
    luxuriesToolTip = false
    basePanel = false
  end

  local luxuriesTip = gui.create( "button" )
  luxuriesTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  luxuriesTip:setSize( 600,400 )
  function luxuriesTip:paint(w, h)
    if luxuriesToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w, h, 10, 10, 20 )
      luxuriesTip:setTextOffset(0,luxuriesTip:getHeight()/2-40)
      luxuriesTip:setText(luxuriesDescription)
    else
      luxuriesTip:setText('')
    end
  end

  local tradeGoodsSymb = gui.create( "panel" )
  tradeGoodsSymb:setPos(750, 0)
  tradeGoodsSymb:setSize(30, 30)
  function tradeGoodsSymb:paint(w, h)
    love.graphics.setColor(69, 39, 9)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end
  function tradeGoodsSymb:onCursorEntered()
    tradeGoodsToolTip = true
    basePanel = true
  end
  function tradeGoodsSymb:onCursorExited()
    tradeGoodsToolTip = false
    basePanel = false
  end

  local tradeGoodsTip = gui.create( "button" )
  tradeGoodsTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  tradeGoodsTip:setSize( 600,400 )
  function tradeGoodsTip:paint(w, h)
    if tradeGoodsToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w, h, 10, 10, 20 )
      tradeGoodsTip:setTextOffset(0,tradeGoodsTip:getHeight()/2-40)
      tradeGoodsTip:setText(tradeGoodsDescription)
    else
      tradeGoodsTip:setText('')
    end
  end

  local wasteSymb = gui.create( "panel" )
  wasteSymb:setPos(900, 0)
  wasteSymb:setSize(30, 30)
  function wasteSymb:paint(w, h)
    love.graphics.setColor(150, 195, 50)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end
  function wasteSymb:onCursorEntered()
    wasteToolTip = true
    basePanel = true
  end
  function wasteSymb:onCursorExited()
    wasteToolTip = false
    basePanel = false
  end

  local wasteTip = gui.create( "button" )
  wasteTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  wasteTip:setSize( 600,400 )
  function wasteTip:paint(w, h)
    if wasteToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w, h, 10, 10, 20 )
      wasteTip:setTextOffset(0,wasteTip:getHeight()/2-40)
      wasteTip:setText(wasteDescription)
    else
      wasteTip:setText('')
    end
  end
end

function UI:drawStatusBar()
  love.graphics.setColor(0, 20, 60, 255)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 30)

  --text
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(moneyDisplay, 30, 10)

  love.graphics.draw(metalDisplay, 180, 10)

  love.graphics.draw(ammunitionDisplay, 330, 10)

  love.graphics.draw(foodDisplay, 480, 10)

  love.graphics.draw(luxuriesDisplay, 630, 10)

  love.graphics.draw(tradeGoodsDisplay, 780, 10)

  love.graphics.draw(wasteDisplay, 930, 10)

end

function UI:drawFancyShit()

end

function UI:drawUnits()
  for i = 1,#map do
    if map[i].type == city then
      createMap:genTilePos(i)
      UI:cityTag(drawX, drawY, i)
    end
  end
  for i = 1,#visUnits do
    if visUnits[i] then
      local loc = visUnits[i].location
      createMap:genTilePos(loc)
      UI:unitTag(drawX, drawY, i)
    end
  end
end

function UI:unitTag(x, y, i)
  local white = {255, 255, 255, 255}
  love.graphics.setColor(visUnit.playerColour)
  local vertices = {x+1, y+1, x+1, y+squareSize/2, x+squareSize/2, y+1}
  love.graphics.polygon('fill', vertices)
end

function UI:cityTag(x, y, i)
  local white = {255, 255, 255, 255}
  love.graphics.setColor(player.colour or white)
  local vertices = {x+1, y+1, x+1, y+squareSize/2, x+squareSize/2, y+1}
  love.graphics.polygon('fill', vertices)
  --love.graphics.polygon('fill', x,y, x-1,y-1, x+1,y+1)
end

return UI
