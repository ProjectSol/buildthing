textDraw = require 'TextDelay/textDraw'
mapFunc = require 'MapFunc/map'
createMap = require 'MapFunc/createMap'
camera = require 'hump/camera'
UI = require 'UI/UI'
require 'SaveTableToFile/SaveTable'
require "UI/_table"
require "UI/gui"
require "lume/lume"
json = require 'json4lua/json/json'
require "Empire/cityCreation"
require "Empire/unitFunc"
require "Systems/turnTimer"
jupiter = require "SaveTableToFile/Jupiter-master/jupiter"
luaTable = require("SaveTableToFile/LuaTable")
lg = love.graphics

--require "Serial-master/serial"


--[[function dotheotherthing()
	if run then
		worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
		localX, localY = love.mouse.getPosition()
		for i = 1,#map do
			createMap:genTilePos(i)
			if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
				lg.setFont(debugFont)
				lg.print(i%gridSize, 200, 500)
				lg.print(math.ceil(i/gridSize), 200, 600)
			end
		end
	end
end]]

function mapDeclarations()
	love.math.setRandomSeed( os.time() )
	currMap = 'europe'
	mapC = {}
	player = {}
	player.resources = {money = 10000, metal = 5000, food = 100, tradeGoods = 40, luxuries = 5, ammunition = 50000, waste = 0}
	player.income = {money = 0, metal = 0, food = 0, tradeGoods = 0, luxuries = 0, ammunition = 0, waste = 0}
	gridSize = 35
	squareSize = 40
	startX, startY = 0,0
	saveButtonH = squareSize*2
	saveButtonW = squareSize*7
	currType = 'city'
	clickTF = false
	clickTime = love.timer.getTime()
	zoom = 1
	xShift = 0
	yShift = 0
	autoTurn = true
	cities = {}
	--[[teamColours1 = {
	{46,208,176}, {41,128,185},
	{26, 194, 93},{142,68,173},
	{96,105,127}, {241,196,15},
	{211,84,0}, {192,57,43},
	{255,140,0}, {255,28,0},
	{255,0,255}, {34,139,34},
	{139,90,0}, {94,38,18},
	{10,10,10}, {255,255,255}
}]]

	--[[infant1 = {name = 'infantry1', team = 6, teamId = 1, location = 61, colour = teamColours1[6]}
	infant2 = {name = 'infantry2', team = 3, teamId = 1, location = 164, colour = teamColours1[3]}
	units = {infant1, infant2}]]
	--The above was test units
	units = {}
	map = {}
	mapSetup = {}
	adjTileOutput = {}
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

function teamColours()
	teamColours1 = {
	{46,208,176}, {60,60,175},
	{169, 216, 149},{142,68,173},
	{96,105,127}, {241,196,15},
	{225,110,0}, {255,28,0},
	{169,175,179}, {139,126,102},
	{255,0,255}, {68, 112, 68},
	{139,90,0}, {178, 103, 103},
	{20,20,20}, {255,255,255}
	}
	--[[teamColours = {
	Turquoise = {26,188,156},
	Blue = {41,128,185}, Emerald = {241,196,15},
	Purple = {142,68,173}, Asphalt = {56,75,97},
	Sun = {241,196,15}, Pumpkin = {211,84,0},
	Red = {192,57,43}, Silver = {189,195,199},
	Wheat = {139,126,102}, Pink = {255,0,255},
	Green = {34,139,34}, Brown = {139,90,0},
	Sepia = {94,38,18}, Black = {0,0,0}
}]]
end

function updateDeclarations()
	UI:updateDisplay()
end

function love.load()
	--[[local host = enet.host_create"localhost:6789"
  local event = host:service(100)
  if event and event.type == "receive" then
    print("Got message: ", event.data, event.peer)
    event.peer:send(event.data)
  end
	print(host:peer_count())]]
	teamColours()
	mapDeclarations()
	loadFiles('UI/gui')
	mapFunc:pullMapData()
	m = 0
	counter = 0
	world = love.physics.newWorld(0, 0, true)
	mapFunc:defineColours()
	--createMap:loadGrid()
	loopTable = true
	--createMap:loadMapEditor()
	mapFunc:mapColour()
	local centred = lg:getWidth() - (gridSize*squareSize+gridSize)
	if centred >= 0 then
		Camera = camera(lg:getWidth()/2-centred/2, lg:getHeight()/2-31)
	else
		Camera = camera(lg:getWidth()/2, lg:getHeight()/2-31)
	end
	worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
	localX, localY = love.mouse.getPosition()
	CITY:gameStart()
	unitFunc:gameStart()

	UI:updateDisplay()
	UI:symbols()
	UI:loadDescriptions()
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
	--clickTime = love.timer.getTime()
	if love.timer.getTime() > clickTime then
		clickTF = false
	end
	gui.update()
	worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
	localX, localY = love.mouse.getPosition()
	--createMap:assignSquares()
end

function love.mousepressed(x, y, button, istouch)
	worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
	localX, localY = love.mouse.getPosition()
	--createMap:recordMap()
	notUnselected = true
	if UI:checkDoubleClickMap() then
		UI:displayCityPage()
		UI:displayUnitPage()
	end
	mapFunc:mapColour()
	for k = 1,#map do
		createMap:genTilePos(k)
		if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
			unitFunc:move(k)
			if notUnselected then
				unitFunc:select()
			end
		end
	end

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


--dbugPrint = nil
dbugPrint = nil
function debugPrint()
	if dbugPrint then
		lg.setFont(debugFont)
		lg.setColor(0,0,0)
		lg.print(dbugPrint, 45*lg:getWidth()/100, 45*lg:getHeight()/100)
	else
		lg.setFont(debugFont)
		lg.setColor(0,0,0)
		lg.print("", 45*lg:getWidth()/100, 45*lg:getHeight()/100)
	end
end


function displayTurnLog()
	for i = 1,#turnLog do
		lg.setFont(status)
		lg.setColor(50, 50, 50)
		lg.print(turnLog[i][1], lg:getWidth()*0.9, lg:getHeight()-(20*i)-20)
	end
end

function love.draw()
	Camera:attach()
	mapFunc:drawMap()
	unitFunc:drawMovRadius()
	UI:drawUnits()
	--Some old debugging stuff
		--[[lg.print(adjTileOutput[2], 990, 0)
		lg.setColor(50,50,80)
		lg.print(adjTileOutput[3]..' this is num 3', 0, 100)
		lg.print(adjTileOutput[4], 990, 100)]]

	Camera:detach()
	displayTurnLog()
	--mapFunc:drawMapEditor()
	--textDraw:delayDraw(1, 0.05, 475, 30, mainFont)
  --textDraw:delayDraw(2, 0.05, 475, 50, mainFont)
	--lg.print(counter, 0,10)
	UI:drawUI()
	lg.setBackgroundColor(200, 200, 200, 255)
	lg.setFont(font)
	lg.setColor(150, 0, 0)
	fps = tostring(love.timer.getFPS())
	lg.print("Current FPS: "..fps, lg:getWidth()-150, 16)
	--[[if active == true then
		gamma = 'no tile selected'
		for i = 1,#units do
			if units[i].selected == 1 then
				lg.setFont(debugFont)
				gamma = tostring(units[i].location)
			end
		end
	end]]
	--lg.print(gamma or '',0,100)
	--lg.setColor(200, 50, 50)
	--dotheotherthing()
	gui.draw()
	if green then
	lg.print(love.filesystem.getSaveDirectory() or 'god damnit')
	end
	lg.setColor(10,10,10,255)
	lg.print("Alpha 0.0.5", lg:getWidth()-95, (98*lg:getHeight())/100)
	debugPrint()
end
