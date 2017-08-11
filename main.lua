textDraw = require 'TextDelay/textDraw'
mapFunc = require 'MapFunc/map'
createMap = require 'MapFunc/createMap'
camera = require 'hump/camera'
UI = require 'UI/UI'
require 'SaveTableToFile/SaveTable'
require "UI/_table"
require "UI/gui"
--require "lume/lume"
json = require 'json4lua/json/json'
require "Empire/cityCreation"
require "Empire/unitFunc"
require "Systems/turnTimer"
jupiter = require "SaveTableToFile/Jupiter-master/jupiter"
luaTable = require("SaveTableToFile/LuaTable")
--require 'myButton'
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
	tenthMeasure = love.graphics:getHeight()/10
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
	UI:menuButn()
	currControl = 0
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
	bypass = false
	mapFunc:pullMapData()
	if not bypass then
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
	if bypass then
		dbugPrint = "Map data has been saved, please press escape and relaunch to play"
	end
end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 + w1 > x2 and
		y1 + h1 > y2 and
		x1 < x2 + w2 and
		y1 < y2 + h2
end

function love.mousemoved( x, y, dx, dy, istouch )
	if not bypass then
		mapFunc:cameraMovement(dx, dy)
	end
end

function love.update()
	if not bypass then
		--clickTime = love.timer.getTime()
		if love.timer.getTime() > clickTime then
			clickTF = false
		end
		gui.update()
		worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
		localX, localY = love.mouse.getPosition()
		--createMap:assignSquares()
	end
end

function love.mousepressed(x, y, button, istouch)
	skip = false
	if not bypass then
		worldX, worldY = Camera:worldCoords(love.mouse.getPosition())
		localX, localY = love.mouse.getPosition()
		--createMap:recordMap()
		notUnselected = true
		cityMenuDoClick()
		if UI:checkDoubleClickMap() then
			UI:displayCityPage()
			UI:displayUnitPage()
		end
		if phase == 'movement' then
			for k = 1,#map do
				createMap:genTilePos(k)
				if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
					unitFunc:move(k)
					if notUnselected then
						unitFunc:select()
					end
				end
			end
		end
		if phase == 'fight' then
			print('Yes in fact you are in fight phase')
			for i = 1,#units do
				if units[i].selected then

				else
					unitFunc:select()
				end
			end
			for q = 1,#map do
				createMap:genTilePos(q)
				if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
					for i = 1,#units do
						if q == units[i].location then
							for x = 1,#units do
						    if units[x].selected == 1 then
									turnTimer:addUnitAttackOrder(units[x], units[i])
									if notUnselected then
										unitFunc:select()
									end
									break
								end
							end
						end
					end
				end
			end
		end
		gui.buttonCheck( x, y, button )
	end
	mapFunc:mapColour()
	unitFunc:select()
end

function love.mousereleased(x, y, button, isTouch)
	if not bypass then
		gui.buttonReleased( x, y, button, istouch )
	end
end

function love.wheelmoved(dx, dy)
	if not bypass then
		gui.wheelMoved( dx, dy )
	end
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

function cityMenuDoClick()

	for i = 1,#buttons do
		local menuButtons = buttons[i]
		if checkCollision(menuButtons.x, menuButtons.y, menuButtons.w, menuButtons.h, localX, localY, 1, 1) then

			UI:checkDoubleClickMapFalse()
			if menuButtons.id == 0 then
				print('id is 0')
				dbugPrint='This button does not have a unique id'
			elseif menuButtons.id == 1 then
				print('id is 1')
				turnTimer:runInfantBuild()
			elseif menuButtons.id == 2 then
				print('adfsafd')
				turnTimer:switchPlayerOrDev()
			end
		end
	end
end

function drawCityMenuButtons()
	for i = 1,#buttons do
		local menuButtons = buttons[i]
		--lg.print(tostring(menuButtons.draw),i,i*30)
		if menuButtons.id == 1 and cityPanel3Display then
			buttons[i].draw = true
		elseif menuButtons.id == 1 then
			buttons[i].draw = false
		end
	end
	for i = 1,#buttons do
		local menuButtons = buttons[i]
		if menuButtons.draw == true then
			if checkCollision(menuButtons.x, menuButtons.y, menuButtons.w, menuButtons.h, localX, localY, 1, 1) then
				useCol = {menuButtons.colour[4],menuButtons.colour[5],menuButtons.colour[6]}
				namCol = {menuButtons.nameColour[4],menuButtons.nameColour[5],menuButtons.nameColour[6]}
			else
				useCol = {menuButtons.colour[1],menuButtons.colour[2],menuButtons.colour[3]}
				namCol = {menuButtons.nameColour[1],menuButtons.nameColour[2],menuButtons.nameColour[3]}
			end
			love.graphics.setColor(useCol)
			love.graphics.rectangle(menuButtons.mode, menuButtons.x, menuButtons.y, menuButtons.w, menuButtons.h)
			love.graphics.setFont(status)
			love.graphics.setColor(namCol)
			lg.print(menuButtons.name, menuButtons.x+3, menuButtons.y+menuButtons.h/4+1)
		end
	end
end


textDraw:delayedNewText(line1, 1)
textDraw:delayedNewText(line2, 2)

dbugPrint = nil
function debugPrint()
	if dbugPrint then
		lg.setFont(debugFont)
		lg.setColor(0,0,0)
		if bypass then
			lg.setColor(255,255,255)
			lg.setFont(status)
		end
		local a = status:getWidth( dbugPrint )
		lg.print(dbugPrint, 10, 45*lg:getHeight()/100)
	else
		--doing nothing
	end
end

function displayTurnLog()
	for i = 1,#turnLog do
		lg.setFont(status)
		lg.setColor(50, 50, 50)
		lg.print(turnLog[i][1]..' Turns remaning: '..turnLog[i][4], lg:getWidth()*0.8, lg:getHeight()-(20*i)-45)
	end
end

function love.draw()
	if not bypass then
		Camera:attach()
		mapFunc:drawMap()
		unitFunc:drawMovRadius()
		unitFunc:drawAttackRadius()
		UI:drawUnits()
		Camera:detach()
		displayTurnLog()
		--mapFunc:drawMapEditor()
		UI:drawUI()
		lg.setBackgroundColor(200, 200, 200, 255)
		lg.setFont(font)
		lg.setColor(150, 0, 0)
		fps = tostring(love.timer.getFPS())
		lg.print("Current FPS: "..fps, lg:getWidth()-150, 16)
		gui.draw()
		drawCityMenuButtons()
		lg.setColor(200,200,200,255)
		lg.print("Alpha 0.5", lg:getWidth()-95, (98*lg:getHeight())/100)
	end
	debugPrint()
	love.graphics.setColor(0,0,0)
	--[[if attackOutput then
		for i = 1,#attackOutput do
			love.graphics.print(tostring(attackOutput[i][1]),0,i*30)
		end
		for i = 1,#units do
			love.graphics.print(tostring(units[i].location),50,i*30)
		end
	end]]
end
