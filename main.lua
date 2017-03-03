textDraw = require 'TextDelay.textDraw'
mapFunc = require 'MapFunc.map'
createMap = require 'MapFunc.createMap'
camera = require 'hump.camera'
UI = require 'UI.UI'
require 'SaveTableToFile.SaveTable'
require "enet"
require "UI._table"
require "UI.gui"
json = require 'json4lua.json.json'
require "Empire/cityCreation"
--dbStuff = require 'testDB.databaseStuff'
--require('sqlite.sqlite3');

function mapDeclarations()
	love.math.setRandomSeed( os.time() )
	mapC = {}
	player = {}
	player.resources = {money = 10000, metal = 500, food = 10000, tradeGoods = 40, luxuries = 5, ammunition = 50000, waste = 0}
	player.income = {money = 100, metal = 6, food = 500, tradeGoods = 3, luxuries = -4, ammunition = 150, waste = 0.05}
	gridSize = 50
	squareSize = 20
	startX, startY = 0,0
	saveButtonH = squareSize*2
	saveButtonW = squareSize*7
	currType = 'city'
	zoom = 1
	xShift = 0
	yShift = 0
	cities = {}
	visUnits = {}
	map = {}
	mapSetup = {}
	tileOutput = {}
	r = {}
	g = {}
	b = {}
	util = {}
	function util.isInArea( x, y, x2, y2, w, h )
    if x >= x2 and x <= x2 + w and y >= y2 and y <= y2+h then
        return true
    end
    return false
	end
end

function loadFiles( dir )
	local objects = love.filesystem.getDirectoryItems( dir )
	local tbl = {}
	for i = 1,#objects do
		if love.filesystem.isDirectory( dir.."/"..objects[ i ] ) then
			tbl[ #tbl + 1 ] = dir.."/"..objects[ i ]
		else
			local name = dir.."/"..string.sub( objects[ i ], 0, string.len( objects[ i ] ) - 4 )
			require( name )
		end
	end

	for i = 1,#tbl do
		loadFiles( tbl[ i ] )
	end
end

function updateDeclarations()
	cCreation:markCities()
end

function love.load()
	--[[local host = enet.host_create"localhost:6789"
  local event = host:service(100)
  if event and event.type == "receive" then
    print("Got message: ", event.data, event.peer)
    event.peer:send(event.data)
  end
	print(host:peer_count())]]
	mapDeclarations()
	--loadFiles('UI/gui')
	--mapFunc:pullMapData()
	m = 0
	counter = 0
	world = love.physics.newWorld(0, 0, true)
	mapFunc:defineColours()
	createMap:loadGrid()
	createMap:loadMapEditor()
	mapFunc:mapColour()
	Camera = camera(love.graphics:getWidth()/2, love.graphics:getHeight()/2-31)
	worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
	localX, localY = love.mouse.getPosition()
	--[[cCreation:gameStart()
	cCreation:cityPanelDeclaration()
	UI:updateDisplay()
	UI:symbols()
	UI:loadDescriptions()]]
end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 + w1 > x2 and
		y1 + h1 > y2 and
		x1 < x2 + w2 and
		y1 < y2 + h2
end

function love.mousemoved( x, y, dx, dy, istouch )
	mapFunc:cameraMovement(dx, dy)
end

function love.update()
	gui.update()
	worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
	localX, localY = love.mouse.getPosition()
	createMap:assignSquares()
end

function love.mousepressed(x, y, button, istouch)
	worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
	localX, localY = love.mouse.getPosition()
	createMap:recordMap()
	mapFunc:mapColour()
	cCreation:displayCityPage()
	gui.buttonCheck( x, y, button )
end

function love.mousereleased(x, y, button, isTouch)
	gui.buttonReleased( x, y, button, istouch )
end

function love.wheelmoved(dx, dy)
	gui.wheelMoved( dx, dy )
end

function love.keypressed(key)
	if key == "escape" then
    love.event.quit()
	end
  --[[if key == "backspace" then
    -- get the byte offset to the last UTF-8 character in the string.
    local byteoffset = utf8.offset(text, -1)

    if byteoffset then
      -- remove the last UTF-8 character.
      -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
      text = string.sub(text, 1, byteoffset - 1)
    end
  end]]
end

line1 = 'dude game sux'
line2 = 'See above and come to your own conclusion'

textDraw:delayedNewText(line1, 1)
textDraw:delayedNewText(line2, 2)

function debugPrint()
	if dbugPrint then
		love.graphics.print(dbugPrint, dbugX or 0, dbugY or 0)
	end
end

function love.draw()
	Camera:attach()
	mapFunc:drawMap()
	Camera:detach()
	mapFunc:drawMapEditor()
	--textDraw:delayDraw(1, 0.05, 475, 30, mainFont)
  --textDraw:delayDraw(2, 0.05, 475, 50, mainFont)
	--love.graphics.print(counter, 0,10)
	--UI:drawUI()
	love.graphics.setBackgroundColor(200, 200, 200, 255)
	if debug then
		love.graphics.setFont(font)
		love.graphics.setColor(150, 150, 150)
		fps = tostring(love.timer.getFPS())
		love.graphics.print("Current FPS: "..fps, love.graphics:getWidth()-100, 16)
	end
		love.graphics.setColor(200, 50, 50)
		love.graphics.print(love.mouse.getY(), 200, 200)
	debugPrint()
	gui.draw()
end
