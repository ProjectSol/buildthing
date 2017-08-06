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
  --UI:drawUnits()
end

function UI:loadDescriptions()
  moneyDescription = "This is a representation of the amount of money your empire has. Having your money reduced to zero or below while your income is negative will apply penalties to all aspects of your empire."
  moneyNumbersDesc = "("..player.resources.money..moneyIncome..") +'grossIncome' -'unitMaint' -'buildingMaint'-'prjctCost' -'tradedAway' +'tradedFor'"

  metalDescription = "This is a representation of the amount of raw metal your empire has. Metal is used create buildings for your cities, manufacture ammunition and fund projects to enhance your empire."
  metalNumbersDesc = "("..player.resources.metal..metalIncome..") +grossIncome' -'buidlingMaint' -'ammoMnu' -'prjctCost' -'tradedAway' +'tradedFor'"

  foodDescription = "This is a representation of the amount of food your empire has. Food is used to stop your civilians and soldiers dying of starvation, excess food can be used to trade."
  foodNumbersDesc = "("..player.resources.food..foodIncome..") +'grossIncome' -'civEat' -'feedingSoldiers' -'tradedAway' +'tradedFor'"

  ammunitionDescription = "This is a representation of the amount of ammunition your empire has. Without bullets your soldiers can't shoot your enemies, or defend your borders. Keep the chain of supply and demand going and you're one step closer to defeating your enemies."
  ammunitionNumbersDesc = "("..player.resources.ammunition..ammunitionIncome..") +grossIncome -'supplyToArmy' -'tradedAway' +'tradedFor'"

  luxuriesDescription = "This is a representation of the ability of your population to indlge in luxuries like a hot shower and a night at the theatre. This resource has a much larger impact on global happiness than trade goods, but are also far more difficult to produce."
  luxuriesNumbersDesc = "("..player.resources.luxuries..luxuriesIncome..") +grossIncome -'populousConsumption' -'tradedAway' +'tradedFor'"

  tradeGoodsDescription = "This is a representation of the amount of goods that your empire produces that have no immediate impact on your war effort. These trade goods when kept in high numbers keep your populous happy, of course, for the more monetarily minded, these goods can be converted into cash quickly."
  tradeGoodsNumbersDesc = "("..player.resources.tradeGoods..tradeGoodsIncome..") +grossIncome -'populousConsumption' -'amountSoldEnMasse' -'tradedAway' +'tradedFor'"

  wasteDescription = "This is a representation of the cleanliness of your empires cities. If this number gets too high even people in clean cities will start to get angry as well."
  wasteNumbersDesc = "("..player.resources.waste..") +'grossCityWaste'  -'buildingEffects'   -'projectEffects'"
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

  local moneyTip = gui.create( "label" )
  moneyTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  moneyTip:setSize( 600-5,400 )
  moneyTip:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  moneyTip:setFont(status)
  moneyTip:setTextOffset(0,10)
  function moneyTip:paint(w, h)
    if moneyToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      --love.graphics.print(moneyTip.__text, moneyTip:getPos())
      moneyTip:setTextColor( 50, 50, 50 )
      moneyTip:setText(moneyDescription)
    else
      moneyTip:setText('')
    end
  end

  local moneyNumbers = gui.create( "label" )
  moneyNumbers:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+215 )
  moneyNumbers:setSize( 300-5,200 )
  moneyNumbers:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  moneyNumbers:setFont(status)
  function moneyNumbers:paint(w, h)
    if moneyToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      moneyNumbers:setTextOffset(0,10)
      moneyNumbers:setTextColor( 50, 50, 50 )
      moneyNumbers:setText(moneyNumbersDesc)
    else
      moneyNumbers:setText('')
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

  local metalTip = gui.create( "label" )
  metalTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  metalTip:setSize( 600-5,400 )
  metalTip:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  metalTip:setFont(status)
  function metalTip:paint(w, h)
    if metalToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      metalTip:setTextOffset(0,10)
      metalTip:setTextColor( 50, 50, 50 )
      metalTip:setText(metalDescription)
    else
      metalTip:setText('')
    end
  end

  local metalNumbers = gui.create( "label" )
  metalNumbers:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+215 )
  metalNumbers:setSize( 300-5,200 )
  metalNumbers:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  metalNumbers:setFont(status)
  function metalNumbers:paint(w, h)
    if metalToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      metalNumbers:setTextOffset(0,10)
      metalNumbers:setTextColor( 50, 50, 50 )
      metalNumbers:setText(metalNumbersDesc)
    else
      metalNumbers:setText('')
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

  local ammunitionTip = gui.create( "label" )
  ammunitionTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  ammunitionTip:setSize( 600-5,400 )
  ammunitionTip:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  ammunitionTip:setFont(status)
  function ammunitionTip:paint(w, h)
    if ammunitionToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      ammunitionTip:setTextOffset(0,10)
      ammunitionTip:setTextColor( 50, 50, 50 )
      ammunitionTip:setText(ammunitionDescription)
    else
      ammunitionTip:setText('')
    end
  end

  local ammunitionNumbers = gui.create( "label" )
  ammunitionNumbers:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+215 )
  ammunitionNumbers:setSize( 300-5,200 )
  ammunitionNumbers:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  ammunitionNumbers:setFont(status)
  function ammunitionNumbers:paint(w, h)
    if ammunitionToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      ammunitionNumbers:setTextOffset(0,10)
      ammunitionNumbers:setTextColor( 50, 50, 50 )
      ammunitionNumbers:setText(ammunitionNumbersDesc)
    else
      ammunitionNumbers:setText('')
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

  local foodTip = gui.create( "label" )
  foodTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  foodTip:setSize( 600-5,400 )
  foodTip:setTextAlignment( TEXT_CENTRE, TEXT_TOP )
  function foodTip:paint(w, h)
    if foodToolTip then
      foodTip:setTextColor(255, 255, 255)
      love.graphics.setColor(20, 20, 20, 255)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      foodTip:setTextOffset(0,10)
      foodTip:setFont(status)
      foodTip:setTextColor( 50, 50, 50 )
      foodTip:setText(foodDescription)
    else
      foodTip:setText('')
    end
  end

  local foodNumbers = gui.create( "label" )
  foodNumbers:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+215 )
  foodNumbers:setSize( 300-5,200 )
  foodNumbers:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  foodNumbers:setFont(status)
  function foodNumbers:paint(w, h)
    if foodToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      foodNumbers:setTextOffset(0,10)
      foodNumbers:setTextColor( 50, 50, 50 )
      foodNumbers:setText(foodNumbersDesc)
    else
      foodNumbers:setText('')
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

  local luxuriesTip = gui.create( "label" )
  luxuriesTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  luxuriesTip:setSize( 600-10,400 )
  luxuriesTip:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  luxuriesTip:setFont(status)
  function luxuriesTip:paint(w, h)
    if luxuriesToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+10, h, 10, 10, 20 )
      luxuriesTip:setTextOffset(0,10)
      luxuriesTip:setTextColor( 50, 50, 50 )
      luxuriesTip:setText(luxuriesDescription)
    else
      luxuriesTip:setText('')
    end
  end

  local luxuriesNumbers = gui.create( "label" )
  luxuriesNumbers:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+215 )
  luxuriesNumbers:setSize( 300-5,200 )
  luxuriesNumbers:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  luxuriesNumbers:setFont(status)
  function luxuriesNumbers:paint(w, h)
    if luxuriesToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      luxuriesNumbers:setTextOffset(0,10)
      luxuriesNumbers:setTextColor( 50, 50, 50 )
      luxuriesNumbers:setText(luxuriesNumbersDesc)
    else
      luxuriesNumbers:setText('')
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

  local tradeGoodsTip = gui.create( "label" )
  tradeGoodsTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  tradeGoodsTip:setSize( 600-5,400 )
  tradeGoodsTip:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  tradeGoodsTip:setFont(status)
  function tradeGoodsTip:paint(w, h)
    if tradeGoodsToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      tradeGoodsTip:setTextOffset(0,10)
      tradeGoodsTip:setTextColor( 50, 50, 50 )
      tradeGoodsTip:setText(tradeGoodsDescription)
    else
      tradeGoodsTip:setText('')
    end
  end

  local tradeGoodsNumbers = gui.create( "label" )
  tradeGoodsNumbers:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+215 )
  tradeGoodsNumbers:setSize( 300-5,200 )
  tradeGoodsNumbers:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  tradeGoodsNumbers:setFont(status)
  function tradeGoodsNumbers:paint(w, h)
    if tradeGoodsToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      tradeGoodsNumbers:setTextOffset(0,10)
      tradeGoodsNumbers:setTextColor( 50, 50, 50 )
      tradeGoodsNumbers:setText(tradeGoodsNumbersDesc)
    else
      tradeGoodsNumbers:setText('')
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

  local wasteTip = gui.create( "label" )
  wasteTip:setPos( love.graphics:getWidth()/4,love.graphics:getHeight()/4+15 )
  wasteTip:setSize( 600-5,400 )
  wasteTip:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  wasteTip:setFont(status)
  function wasteTip:paint(w, h)
    if wasteToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", 0, 0, w+5, h, 10, 10, 20 )
      wasteTip:setTextOffset(0,10)
      wasteTip:setTextColor( 50, 50, 50 )
      wasteTip:setText(wasteDescription)
    else
      wasteTip:setText('')
    end
  end

  local wasteNumbers = gui.create( "label" )
  wasteNumbers:setPos( love.graphics:getWidth()/4+5,love.graphics:getHeight()/4+215 )
  wasteNumbers:setSize( 300-5,200 )
  wasteNumbers:setTextAlignment(TEXT_CENTRE, TEXT_TOP)
  wasteNumbers:setFont(status)
  function wasteNumbers:paint(w, h)
    if wasteToolTip then
      love.graphics.setColor(20, 20, 20)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle( "line", -5, 0, w+5, h, 10, 10, 20 )
      wasteNumbers:setTextOffset(0,10)
      wasteNumbers:setTextColor( 50, 50, 50 )
      wasteNumbers:setText(wasteNumbersDesc)
    else
      wasteNumbers:setText('')
    end
  end

  local cityPanel1 = gui.create( "panel" )
  cityPanel1:setPos( 5,love.graphics:getHeight()/16 )
  cityPanel1:setSize( 500,love.graphics:getHeight()-love.graphics:getHeight()/16-40 )
  function cityPanel1:paint(w, h)
    if cityPanel1Display then
      love.graphics.setColor(200, 200, 200, 230)
      love.graphics.rectangle( "fill", 0, 0, w, h)
      --cityPanel1:setText('placeholder')
    else
      --cityPanel1:setText('')
    end
  end
  cityName = 'Something Broke'
  local cityPanel2 = gui.create( "label" )
  cityPanel2:setPos( 5,love.graphics:getHeight()/16 )
  cityPanel2:setSize( 501,love.graphics:getHeight()-love.graphics:getHeight()/16-40 )
  cityPanel2:setTextAlignment( TEXT_CENTRE, TEXT_TOP )
  cityPanel2:setTextOffset( 0, 10 )
  cityPanel2:setFont(status)
  function cityPanel2:paint(w, h)
    if cityPanel1Display then
      love.graphics.setColor( 50, 50, 50 )
      love.graphics.setLineWidth(10)
      love.graphics.rectangle('line', 0, 0, w, h, 10, 10, 20)
      cityPanel2:setTextColor( 50, 50, 50 )
      cityPanel2:setText(cityName)
    else
      cityPanel2:setText('')
    end
  end



  --i, n, m, bx, by, bw, bh, br, bg, bb, ba, tf, TF, rT, gT, bT
  --buttonFunc:Setup(1, 'kill me', "line", 20, tenthMeasure, 150, 30, 155, 255, 0, 255, true, true, 255, 255, 255)
--[[
  local cityPanel3 = gui.create( "button" )
  cityPanel3:setPos( 20,tenthMeasure )
  cityPanel3:setSize( 150, 30 )
  --love.graphics.setLineWidth(2)
  function cityPanel3:paint(w, h)
    --if cityPanel3Display then
      cityPanel3:setPos( 20,tenthMeasure )
      cityPanel3:setSize( 150, 30 )
      cityPanel3:setTextColor(80, 80, 80)
      love.graphics.setColor(125, 125, 125, 200)
      love.graphics.rectangle( "fill", 0, 0, w, h )
      cityPanel3:setTextOffset(0,0)
      cityPanel3:setFont(status)
    if currBuildCity then
      cityPanel3:setText('Build Infantry')
    else
      cityPanel3:setText("No city selected")
    end
  end
  X = 0
  function cityPanel3:doClick()
    X=X+1
    dbugPrint = tostring(X)
    --if currBuildCity and cityPanel3Display then
      local c = love.math.random(-1,1)
      local m = love.math.random(-1,1)
      local g = (gridSize*m)+c
      local f = currBuildCity.loc
      turnTimer:addUnitBuildOrder(currBuildCity.team, f, 2, currBuildCity.number)
      currBuildCity.building = true
    --end
  end
]]





  local unitPanel1 = gui.create( "panel" )
  unitPanel1:setSize( 500, love.graphics:getHeight()-love.graphics:getHeight()/16-40 )
  unitPanel1:setPos( love.graphics:getWidth()-unitPanel1:getWidth()-5, love.graphics:getHeight()/16)
  function unitPanel1:paint(w, h)
    if unitPanelDisplay then
      love.graphics.setColor( 200, 200, 200, 230 )
      love.graphics.setLineWidth(10)
      love.graphics.rectangle('fill', 0, 0, w, h, 10, 10, 20)
    end
  end

  local unitPanel2 = gui.create( "label" )
  unitPanel2:setSize( 500, love.graphics:getHeight()-love.graphics:getHeight()/16-40 )
  unitPanel2:setPos( love.graphics:getWidth()-unitPanel2:getWidth()-5, love.graphics:getHeight()/16 )
  unitPanel2:setTextAlignment( TEXT_CENTRE, TEXT_TOP )
  unitPanel2:setTextOffset(0,10)
  unitPanel2:setFont(status)
  function unitPanel2:paint(w, h)
    if unitPanel2Display then
      love.graphics.setColor( 50, 50, 50 )
      love.graphics.setLineWidth(10)
      love.graphics.rectangle('line', 0, 0, w, h, 10, 10, 20)
      unitPanel2:setTextColor( 50, 50, 50 )
      unitPanel2:setText(unitName)
    else
      unitPanel2:setText('')
    end
  end






  local passTurn = gui.create( "button" )
  passTurn:setPos(105, lg.getHeight()-30 )
  passTurn:setSize( 95, 30 )
  --love.graphics.setLineWidth(2)
  function passTurn:paint(w, h)
    passTurn:setTextColor(255, 255, 255)
    love.graphics.setColor(0, 0, 200, 255)
    love.graphics.rectangle( "fill", 0, 0, w, h )
    passTurn:setTextOffset(0,0)
    passTurn:setFont(status)
    passTurn:setText("Pass Turn")
  end
  function passTurn:doClick()
    --dbugPrint = 'passTurn received'
    turnTimer:exectueLog()
  end

  local autoTurn = gui.create( "button" )
  autoTurn:setPos(0, lg:getHeight()-30 )
  autoTurn:setSize( 95, 30 )
  --love.graphics.setLineWidth(2)
  function autoTurn:paint(w, h)
    autoTurn:setTextColor(255, 255, 255)
    love.graphics.setColor(0, 200, 0, 255)
    love.graphics.rectangle( "fill", 0, 0, w, h )
    autoTurn:setTextOffset(0,0)
    autoTurn:setFont(status)
    autoTurn:setText("Auto Turn")
  end
  function autoTurn:doClick()
    turnTimer:switchTurnMode()
  end

  local devMode = gui.create( "button" )
  devMode:setPos(210, lg:getHeight()-30 )
  devMode:setSize( 95, 30 )
  --love.graphics.setLineWidth(2)
  function devMode:paint(w, h)
    devMode:setTextColor(255, 255, 255)
    love.graphics.setColor(200, 0, 0, 255)
    love.graphics.rectangle( "fill", 0, 0, w, h )
    devMode:setTextOffset(0,0)
    devMode:setFont(status)
    devMode:setText("Dev/Player")
  end
  function devMode:doClick()
    turnTimer:switchPlayerOrDev()
  end

end

function UI:drawStatusBar()
  love.graphics.setColor(0, 20, 60, 255)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 30)

  love.graphics.setColor(0, 20, 60, 255)
  love.graphics.rectangle('fill', 0, lg:getHeight()-30, love.graphics.getWidth(), 30)
  love.graphics.setColor(200, 200, 200)
  love.graphics.setFont(status)
  love.graphics.print(phase, lg:getWidth()/2-status:getWidth(phase),lg:getHeight()-20)

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

function UI:displayUnitPage()
  for i = 1,#units do
    if units[i] then
      local loc = units[i].location
      createMap:genTilePos(loc)
      worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
      localX, localY = love.mouse.getPosition()
      if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
        unitPanelDisplay = true
        unitName = units[i].name
        notUnselected = false
        for k = 1,#units do
          units[k].selected = 0
        end
        break
      else
        unitPanelDisplay = false
      end
    end
  end
end

function UI:checkDoubleClickMapFalse()
  blockRun = true
end

function UI:checkDoubleClickMap()
  local clickDelay = 0.45
  if blockRun == false then
    if clickTF == true then
      if love.timer.getTime() <= clickTime then
        clickTF = false
        return true
      else
        clickTF = true
        clickTime = love.timer.getTime()+clickDelay
        return false
      end
    else
      clickTF = true
      clickTime = love.timer.getTime()+clickDelay
      return false
    end
  else
    blockRun = false
  end
end

function UI:displayCityPage()
  for i = 1,#map do
    if map[i].type == city then
      local loc = i
      createMap:genTilePos(loc)
      worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
      localX, localY = love.mouse.getPosition()
        if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
          cityPanel1Display = true
          cityPanel2Display = true
          for k = 1,#cities do
            if cities[k].loc == i  then
              if currControl == cities[k].team or currControl == 0 then
                cityName = cities[k].name
                currBuildCity = cities[k]
                --dbugPrint = k
                break
              end
            end
          end
        break
        --cityName = cities[i].name
        --cityProduction = cities[i].production
      else
        cityPanel1Display = false
        cityPanel2Display = false
        cityPanel3Display = false
        currBuildCity = nil
      end
    end
  end
end

function UI:drawUnits()
  for i = 1,#map do
    if map[i].type == city then
      local loc = i
      createMap:genTilePos(loc)
      UI:cityTag(drawX, drawY, i)
    end
  end
  for i = 1,#units do
    if units[i] then
      local loc = units[i].location
      createMap:genTilePos(loc)
      UI:unitTag(drawX, drawY, i)
    end
  end
end

function UI:unitTag(x, y, i)
  local white = {255, 255, 255, 255}
  love.graphics.setColor(units[i].colour or white)
  local vertices = {x+squareSize-1, y+1, x+squareSize/2, y+1, x+squareSize-1, y+squareSize/2}
  love.graphics.polygon('fill', vertices)
  --love.graphics.print(tostring(units[i].name),x+i/2,y)
end

function UI:cityTag(x, y, i)
  local white = {255, 255, 255, 255}
  for q = 1,#cities do
    if cities[q].loc == i then
      love.graphics.setColor(cities[q].colour or white)
      local vertices = {x+1, y+1, x+1, y+squareSize/2-1, x+squareSize/2-1, y+1}
      love.graphics.polygon('fill', vertices)
      --love.graphics.polygon('fill', x,y, x-1,y-1, x+1,y+1)
    end
  end
end

function UI:menuButn()
  buttons = {}
  local base = {mode='fill',x=100,y=100,h=30,w=150,colour={125,125,125,100,100,100},nameColour={75,75,75,50,50,50},name='UNNAMEDBUTTON', id=0}
  -- for id building infantry is 1, 0 just makes dbugPrint popup an error and the remaining will be defined at a later date

  local buildInfantGlobal = base
  buildInfantGlobal.name = 'Build Infantry'
  buildInfantGlobal.x = 30
  buildInfantGlobal.y = tenthMeasure
  buildInfantGlobal.id = 1
  table.insert(buttons, buildInfantGlobal)

  local controlMode = base
  controlMode.name = 'Dev/Player mode'
  controlMode.x = 210
  controlMode.y = love.graphics:getHeight()-30
  controlMode.w = 95
  controlMode.h = 30
  controlMode.id = 2
  table.insert(buttons, controlMode)
end

return UI
