createMap = {}

function createMap:loadGrid()
		love.graphics.setColor(255,255,255,255)
		for i=1,(gridSize)^2 do
			local type = open

			local tile = {id = i, mode = 'fill', type = type, city = nil}
			table.insert(map, tile)
		end
	end

	function createMap:genTilePos(i)
		local a = math.floor((map[i].id-1)/gridSize)
		local c = math.floor(map[i].id-(a*gridSize))
		drawY = squareSize*a + startY + (1*a)
		drawX = (map[i].id - (gridSize*a) - 1)*squareSize + startX + (1*c)
	end

function createMap:loadMapEditor()
	typeSwap = {}
	mapEditor = true
	local typeGridSize = 1
	for i=1,(#types) do
		local a = math.floor((i-1)/typeGridSize)
		local drawY = squareSize*a + (1*a)
		local drawX = love.graphics:getWidth()-(squareSize*8)
		local tile = {mode = 'fill', x = drawX, y = drawY, type = types[i], num = i}
		table.insert(typeSwap, tile)
	end
	local i = #typeSwap+1
	local a = math.floor((i-1)/typeGridSize)
	local drawY = squareSize*a + (1*a)-(squareSize/2)
	local drawX = love.graphics:getWidth()-(squareSize*10)-(squareSize/4)
	saveTile = {mode = 'fill', x = drawX-squareSize, y = drawY+squareSize, type = save}
	local saveButton = 'Save Map'
	textDraw:delayedNewText(saveButton, 3)
end

function createMap:generateWater(tile)
	mapFunctions:checkAdjacent(tile)
	if #tileOutput ~= 0 then
		for i = 1,#tileOutput do
			local rand = love.math.random(1,#tileOutput)
			local individualTile = tileOutput[rand]
			map[individualTile].type = 'water'
		end
		tileOutput = {}
	end
end

function createMap:assignSquares()
	local down = love.mouse.isDown(1)
	if mapEditor then
		if currType ~= 'save' then
		  for i = 1,#map do
				createMap:genTilePos(i)
		    if checkCollision(drawX, drawY, squareSize, squareSize, worldX, worldY, 1, 1) and down then
					map[i].type = currType
		    end
		  end
		end
		for i = 1,#typeSwap do
			if checkCollision(typeSwap[i].x, typeSwap[i].y, squareSize, squareSize, localX, localY, 1, 1) and down then
				currType = typeSwap[i].type
			end
		end
	end
end

function createMap:recordMap()
	--if saveTile then
		--if checkCollision(saveTile.x, saveTile.y, saveButtonW, saveButtonH, localX, localY, 1, 1) then
			table.save(map, currMap)
			print('It\'s commented out')
		--end
	--end
end

return createMap
