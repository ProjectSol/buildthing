cCreation = {}

function cCreation:displayCityPage()
  for i = 1,#map do
    if map[i].type == city then
      createMap:genTilePos(i)
      --abaca = drawX
      --cbcac = drawY
      if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
        cityPanel1Display = true
        cityPanel2Display = true
      else
        cityPanel1Display = false
        cityPanel2Display = false
      end
    end
  end
  --[[if cityPage[i] == true then
    if checkCollision(cityPanel:getPos(), cityPanel:getSize(), worldX, worldY, 1, 1) then
      cityPage[i] = false
    end
  end]]
end

function cCreation:drawCityPages()

end

function cCreation:gameStart()
  for i = 1,#map do
    if map[i].type == city then
      table.insert(cities, map[i])
    end
  end
  for i = 1,#cities do
    cities[i].team = i
  end
end

function cCreation:markCities()
  for i = 1,#map do
    if map[i].type == city then
      table.insert(cities, map[i])
    end
  end
end

function cCreation:cityPanelDeclaration()
  local cityPanel1 = gui.create( "panel" )
  cityPanel1:setPos( 5,love.graphics:getHeight()/16 )
  cityPanel1:setSize( 300,love.graphics:getHeight()-love.graphics:getHeight()/16-40 )
  function cityPanel1:paint(w, h)
    if cityPanel1Display then
      love.graphics.setColor(200, 200, 200, 230)
      love.graphics.rectangle( "fill", 0, 0, w, h)
    end
  end

  local cityPanel2 = gui.create( "button" )
  cityPanel2:setPos( 5,love.graphics:getHeight()/16 )
  cityPanel2:setSize( 300,love.graphics:getHeight()-love.graphics:getHeight()/16-40 )
  function cityPanel2:paint(w, h)
    if cityPanel2Display then
      love.graphics.setColor(50, 50, 50)
      love.graphics.setLineWidth(10)
      love.graphics.rectangle('line', 0, 0, w, h, 10, 10, 20)
    end
  end
end

function cCreation:textDec()
  for i = 1,#cities do
    cityPanel2:setText(cityText[i])
  end
end

return cCreation
