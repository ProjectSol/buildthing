textDraw = require 'TextDelay.textDraw'
mapFunctions = require 'MapFunc.map'
createMap = require 'MapFunc.createMap'
camera = require 'hump.camera'
require('SaveTableToFile.SaveTable')
--dbStuff = require 'testDB.databaseStuff'
json = require 'json4lua.json.json'
--require('sqlite.sqlite3');


function love.load()
	m = 0
	counter = 0
	world = love.physics.newWorld(0, 0, true)
	map:defineColours()
	createMap:loadGrid()
	createMap:loadMapEditor()
	Camera = camera(200,150)
	worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
	localX, localY = love.mouse.getPosition()
end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 + w1 > x2 and
		y1 + h1 > y2 and
		x1 < x2 + w2 and
		y1 < y2 + h2
end

function love.update()
	worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
	localX, localY = love.mouse.getPosition()
	createMap:assignSquares()
end

--[[function love.mousepressed(x, y, button, istouch)
	worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
	localX, localY = love.mouse.getPosition()
end]]

function love.keypressed(key)
  --[[if key == "backspace" then
    -- get the byte offset to the last UTF-8 character in the string.
    local byteoffset = utf8.offset(text, -1)

    if byteoffset then
      -- remove the last UTF-8 character.
      -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
      text = string.sub(text, 1, byteoffset - 1)
    end
  end]]
  if key == "escape" then
    love.event.quit()
  end
end

line1 = 'This is a stand in for more potential text'
line2 = 'See above and come to your own conclusion'

textDraw:delayedNewText(line1, 1)
textDraw:delayedNewText(line2, 2)

function love.draw()
	Camera:attach()
	mapFunctions:drawMap()
	Camera:detach()
	mapFunctions:drawMapEditor()
  if debug then
    love.graphics.setFont(font)
		love.graphics.setColor(255, 255, 255)
		fps = tostring(love.timer.getFPS())
		love.graphics.print("Current FPS: "..fps, 9, 10)
	end
	textDraw:delayDraw(1, 0.05, 475, 30, mainFont)
  textDraw:delayDraw(2, 0.05, 475, 50, mainFont)
	--love.graphics.print(counter, 0,10)
end
