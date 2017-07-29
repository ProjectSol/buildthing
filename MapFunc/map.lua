mapFunc = {}

function mapFunc:defineColours()
	open = 'open'
	city = 'city'
	rough = 'rough'
	water = 'water'
	types = {city, open, rough, water}
end

function mapFunc:pullMapData()
	--dbugPrint = tostring(love.filesystem.isFused())
	love.filesystem.setIdentity('buildthing/maps')
	--[[mapLoading = table.load(europe)
	local data = { _fileName = "Europa.txt", mapLoading }
	tsuccess = jupiter.save(data)]]

	--table.save(map, "europa") This was used to save the initial map

	local f = love.filesystem.isFile("Europe.txt")
	if f then
		local mapl = jupiter.load("Europe.txt")
		map = mapl[1]
	else
		mapf = table.load("europa")
		print(#mapf)
		if mapf then
			dbugPrint = tostring(#mapf)
		else
			print('niggers')
			dbugPrint = 'niggers'
		end
		local data = { _fileName = "Europe.txt", mapf }
		yes = jupiter.save(data)
		if yes then
			local mapl = jupiter.load("Europe.txt")
			map = mapl[1]
			print('gamma')
			dbugPrint = "Simply the best"
		end
	end
end

function checkInLine(tile1, tile2)
	local a = math.floor((tile1-1)/gridSize)
	local a2 = math.floor((tile2-1)/gridSize)

	if a == a2 then

	elseif tile1 - a*gridSize == tile2 - a2*gridSize then

	end
end

function mapFunc:tileScanTest(tile)
	mapFunc:checkAdjacent(tile)
	for i = 1,#tileOutput do
		local individualTile = tileOutput[i]
		map[individualTile].type = 'rough'
	end
	tileOutput = {}
end

function mapFunc:drawMapEditor()
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
	textDraw:delayDraw(3, 0.095, saveTile.x+(saveButtonH/4), saveTile.y+(saveButtonH/4), mainFont)
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
				elseif typeSwap[i].type == city then
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
			elseif typeSwap[i].type == city then
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

function mapFunc:mapColour()
	for i = 1,#map do
		table.insert(mapC, {r = 10, g = 10, b = 10, a = 10})
		--print('x: '..map[i].x..' y: '..map[i].y..' Type: '..map[i].type)
		if map[i].type == open then
			mapC[i].r = 20
			mapC[i].g = 150
			mapC[i].b = 20
		elseif map[i].type == water then
			mapC[i].r = 20
			mapC[i].g = 100
			mapC[i].b = 150
		elseif map[i].type == rough then
			mapC[i].r = 75
			mapC[i].g = 75
			mapC[i].b = 40
		elseif map[i].type == city then
			mapC[i].r = 65
			mapC[i].g = 65
			mapC[i].b = 65
		end
	end
end


function mapFunc:drawMap()
	for i = 1,#map do
		mapC[i].a = 255
		createMap:genTilePos(i)
		if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) then
			mapC[i].a = 100
		end
		love.graphics.setColor(mapC[i].r, mapC[i].g, mapC[i].b, mapC[i].a)
		love.graphics.rectangle(map[i].mode, drawX, drawY, squareSize, squareSize)
	end
end

function mapFunc:checkAdjacent(tile1)
	adjTileOutput = {}
	local blank = 0
	local b = tile1

	for i = 1,gridSize^2 do
		for q = -1,1 do

			tileOne = b+q
			tileTwo = b-gridSize+q
			tileThree = b+gridSize+q

			bColumn = b%gridSize
			tileOneColumn = tileOne%gridSize
			tileTwoColumn = tileTwo%gridSize
			tileThreeColumn = tileThree%gridSize

			if tileOne > 0 and tileOneColumn == bColumn+q then
				table.insert(adjTileOutput, tileOne)
			end
			if tileTwo > 0 and tileOneColumn == bColumn+q then
				table.insert(adjTileOutput, tileTwo)
			end
			if tileThree > 0 and tileOneColumn == bColumn+q then
				table.insert(adjTileOutput, tileThree)
			end
		end
	end
	adjOutput = {}
	for i = 1,9 do
		table.insert(adjOutput, adjTileOutput[i])
	end
	--return adjTileOutput
end

function mapFunc:cameraMovement(dx, dy)
	if love.mouse.isDown(2) then
		xCamLimit = gridSize*squareSize+gridSize--+love.graphics:getWidth()/2
		yCamLimit = gridSize*squareSize+gridSize
		Camera:move(-dx, -dy)
		if gridSize*squareSize+gridSize >= lg:getWidth() then
			local cx, cy = Camera:position()
			--left
			if cx - dx <= love.graphics:getWidth()/2-41 then
				Camera:lookAt(love.graphics:getWidth()/2-41, cy)
				cx, cy = Camera:position()
			end
			--right
			if cx - dx >= xCamLimit-love.graphics:getWidth()/2+41 then
				Camera:lookAt(xCamLimit-love.graphics:getWidth()/2+41, cy)
				cx, cy = Camera:position()
			end
			--up
			if cy - dy <= love.graphics:getHeight()/2-71 then
				Camera:lookAt(cx, love.graphics:getHeight()/2-71)
				cx, cy = Camera:position()
			end
			--down
			if cy - dy >= yCamLimit-love.graphics:getHeight()/2+40 then
				Camera:lookAt(cx, yCamLimit-love.graphics:getHeight()/2+40)
				cx, cy = Camera:position()
			end

		end

		if gridSize*squareSize+gridSize < lg:getWidth() then
			local centred = lg:getWidth() - (gridSize*squareSize+gridSize)
			local cx, cy = Camera:position()
			Camera:lookAt(lg:getWidth()/2-centred/2, cy)
			local cx,cy = Camera:position()


			if cy - dy <= love.graphics:getHeight()/2-71 then
				Camera:lookAt(cx, love.graphics:getHeight()/2-71)
				cx, cy = Camera:position()
			end
			if cy - dy >= yCamLimit-love.graphics:getHeight()/2+40 then
				Camera:lookAt(cx, yCamLimit-love.graphics:getHeight()/2+40)
				cx, cy = Camera:position()
			end
		end
	end
end

return mapFunc
