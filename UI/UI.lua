UI = {}

function UI:drawUI()
  --[[Food(stop soldiers and civilians alike from starving),
      Money(used to build, buy and fund other programs),
      Metals(Used to build or as a trade resource),
      Ammunition(Troops with no bullets, are troops that stop being scary),
      Waste(Split into trench waste and city waste, how likely soldiers are to become diseased, how like civvies are to become diseased),
      Trade Goods(When kept at home give a bonus to happiness, smaller than luxuries, can be converted directly to money),
      Luxuries (Soap, Chocolate, The Arts, very good at keeping people happy, but are burnt through quickly and cost a lot)]]
  UI:drawStatusBar()
  UI:drawFancyShit()
  UI:displayUnits()
end

function UI:symbols()
  local moneySymb = gui.create( "panel" ) -- create a panel object
  moneySymb:setPos( 0, 0 ) -- set position to 200, 200
  moneySymb:setSize( 30, 30 ) -- set width and height to 150, 150
  function moneySymb:paint(w, h)
    love.graphics.setColor(200, 200, 10)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end

  local metalsSymb = gui.create( "panel" )
  metalsSymb:setPos(120, 0)
  metalsSymb:setSize(30, 30)
  function metalsSymb:paint(w, h)
    love.graphics.setColor(150, 150, 150)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end

  local ammunitionSymb = gui.create( "panel" )
  ammunitionSymb:setPos(240, 0)
  ammunitionSymb:setSize(30, 30)
  function ammunitionSymb:paint(w, h)
    love.graphics.setColor(150, 50, 50)
    love.graphics.rectangle( "fill", 0, 0, w, h )
  end
end

function UI:drawStatusBar()
  dbugPrint = tostring(love.mouse.getX())
  local moneyDisplay = love.graphics.newText( status, ' = '..playerResources.money)

  local metalDisplay = love.graphics.newText( status, ' = '..playerResources.metal)

  local foodDisplay = love.graphics.newText( status, ' = '..playerResources.food)

  local tradeDisplay = love.graphics.newText( status, ' = '..playerResources.tradeGoods)

  local luxuriesDisplay = love.graphics.newText( status, ' = '..playerResources.luxuries)

  local ammunitionDisplay = love.graphics.newText( status, ' = '..playerResources.ammunition)

  local wasteDisplay = love.graphics.newText( status, ' = '..playerResources.civilWaste..' / '..playerResources.soldierWaste)

  love.graphics.setColor(0, 20, 60, 255)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 30)

  --replace with an apple or something
  love.graphics.setColor(50, 200, 50)
  love.graphics.rectangle('fill', 240, 0, 30, 30)

  --text
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(moneyDisplay, 30, 10)

  love.graphics.draw(metalDisplay, 150, 10)

  love.graphics.draw(ammunitionDisplay, 270, 10)

  love.graphics.draw(foodDisplay, 390, 10)

end

function UI:drawFancyShit()

end

function UI:displayUnits()

end

return UI
