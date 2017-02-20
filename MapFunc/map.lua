map = {}
mapC = {}
gridSize = 10
startX, startY = 0,0
squareSize = 13
saveButtonH = squareSize*2
saveButtonW = squareSize*7
currType = 'test'
zoom = 1
xShift = 0
yShift = 0
map = {}
mapSetup = {}
tileOutput = {}
r = {}
g = {}
b = {}

function map:defineColours()
	open = 'open'
	test = 'test'
	rough = 'rough'
	water = 'water'
	types = {test, open, rough, water}
end

function checkInLine(tile1, tile2)
	local a = math.floor((tile1-1)/gridSize)
	local a2 = math.floor((tile2-1)/gridSize)

	if a == a2 then

	elseif tile1 - a*gridSize == tile2 - a2*gridSize then

	end
end

function map:tileScanTest(tile)
	map:checkAdjacent(tile)
	for i = 1,#tileOutput do
		local individualTile = tileOutput[i]
		map[individualTile].type = 'rough'
	end
	tileOutput = {}
end

function map:drawMapEditor()
	if checkCollision(saveTile.x, saveTile.y, saveButtonW, saveButtonH, localX, localY, 1, 1) then
		saveTile.r = 150
		saveTile.g = 150
		saveTile.b = 255
		saveTile.a = 200
	else
		saveTile.r = 150
		saveTile.g = 150
		saveTile.b = 255
		saveTile.a = 255
	end
	love.graphics.setColor(saveTile.r, saveTile.g, saveTile.b, saveTile.a)
	love.graphics.rectangle(saveTile.mode, saveTile.x, saveTile.y, saveButtonW, saveButtonH)
	textDraw:delayDraw(3, 0.05, saveTile.x+(saveButtonH/4), saveTile.y+(saveButtonH/4), mainFont)
	for i = 1,#typeSwap do

		if checkCollision(typeSwap[i].x, typeSwap[i].y, squareSize, squareSize, localX, localY, 1, 1) then
				typeSwap[i].a = 200
				if typeSwap[i].type == open then
					typeSwap[i].r = 10
					typeSwap[i].g = 200
					typeSwap[i].b = 10
				elseif typeSwap[i].type == water then
					typeSwap[i].r = 10
					typeSwap[i].g = 10
					typeSwap[i].b = 200
				elseif typeSwap[i].type == rough then
					typeSwap[i].r = 100
					typeSwap[i].g = 100
					typeSwap[i].b = 50
				elseif typeSwap[i].type == test then
					typeSwap[i].r = 100
					typeSwap[i].g = 100
					typeSwap[i].b = 100
				end
			elseif typeSwap[i].type == open then
				typeSwap[i].r = 10
				typeSwap[i].g = 200
				typeSwap[i].b = 10
				typeSwap[i].a = 255
			elseif typeSwap[i].type == water then
				typeSwap[i].r = 10
				typeSwap[i].g = 10
				typeSwap[i].b = 200
				typeSwap[i].a = 255
			elseif typeSwap[i].type == rough then
				typeSwap[i].r = 100
				typeSwap[i].g = 100
				typeSwap[i].b = 50
				typeSwap[i].a = 255
			elseif typeSwap[i].type == test then
				typeSwap[i].r = 100
				typeSwap[i].g = 100
				typeSwap[i].b = 100
				typeSwap[i].a = 255
			elseif typeSwap[i].type == save then
				typeSwap[i].r = 100
				typeSwap[i].g = 100
				typeSwap[i].b = 100
				typeSwap[i].a = 255
			end

		love.graphics.setColor(typeSwap[i].r, typeSwap[i].g, typeSwap[i].b, typeSwap[i].a)
		love.graphics.rectangle(typeSwap[i].mode, typeSwap[i].x, typeSwap[i].y, squareSize, squareSize)
	end
end

function map:drawMap()
	for i = 1,#map do
		mapC[i] = {r = 10, g = 10, b = 10, a = 10}
		createMap:genTilePos(i)
		if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
			mapC[i].a = 200
			--print('x: '..map[i].x..' y: '..map[i].y..' Type: '..map[i].type)
			if map[i].type == "open" then
				mapC[i].r = 10
				mapC[i].g = 200
				mapC[i].b = 10
			elseif map[i].type == "water" then
				mapC[i].r = 10
				mapC[i].g = 10
				mapC[i].b = 200
			elseif map[i].type == "rough" then
				mapC[i].r = 100
				mapC[i].g = 100
				mapC[i].b = 50
			elseif map[i].type == "test" then
				mapC[i].r = 100
				mapC[i].g = 100
				mapC[i].b = 100
			end
		elseif map[i].type == "open" then
			mapC[i].r = 10
			mapC[i].g = 200
			mapC[i].b = 10
			mapC[i].a = 255
		elseif map[i].type == "water" then
			mapC[i].r = 10
			mapC[i].g = 10
			mapC[i].b = 200
			mapC[i].a = 255
		elseif map[i].type == "rough" then
			mapC[i].r = 100
			mapC[i].g = 100
			mapC[i].b = 50
			mapC[i].a = 255
		elseif map[i].type == "test" then
			mapC[i].r = 100
			mapC[i].g = 100
			mapC[i].b = 100
			mapC[i].a = 255
		end

		love.graphics.setColor(mapC[i].r, mapC[i].g, mapC[i].b, mapC[i].a)
		love.graphics.rectangle(map[i].mode, drawX, drawY, squareSize, squareSize)
	end
end

function map:checkAdjacent(tile1)
	tileOutput = {}
	local blank = 0
	local b = tile1

	for i = 1,gridSize^2 do

		for q = -1,1 do

			tileOne = b+q
			tileTwo = b-gridSize+q
			tileThree = b+gridSize+q
			--print('tileOne: '..tileOne..' tileTwo: '..tileTwo..' tileThree: '..tileThree)
			--print(map[b].row)
			--print(map[b].column)
			if tileOne > 0 and map[tileOne].column == map[b].column+q then
				table.insert(tileOutput, tileOne)
			end
			if tileTwo > 0 and map[tileOne].column == map[b].column+q then
				table.insert(tileOutput, tileTwo)
			end
			if tileThree > 0 and map[tileOne].column == map[b].column+q then
				table.insert(tileOutput, tileThree)
			end
		end
	end
end

return map