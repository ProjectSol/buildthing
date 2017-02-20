dbStuff = {}

function dbStuff:recordMap()
	if saveTile then
		if checkCollision(saveTile.x, saveTile.y, saveButtonW, saveButtonH, localX, localY, 1, 1) then
			transfer = {}
			test = true
		  for i=1,gridSize do
				for g=1,gridSize do
					table.insert(transfer, json.encode(map[g+(gridSize*i-gridSize)]))
				end
				local a = json.encode(transfer)
				print(a)
		    hDB:exec(string.format("INSERT INTO tiles VALUES('%s');", a))
				--print(hDB:errmsg())
				transfer = {}
			end
		end
	end
end


function dothething()
	return hDB:nrows("SELECT data FROM tiles;")
end

function dothesecondthing()
	for tiles in dothething() do
		Tid = tiles.id
		Tdata = tiles.data
		data = json.encode(Tdata)
		print("thank: "..Tid)
	end
end

function dothethirdthing()
	return hDB:exec("SELECT test3.data FROM tiles;")
end

function dbStuff:pullMapData()
		map = {}
		for inf in dothethirdthing() do
			local f = inf
			print(json.encode(f))
			table.insert(mapSetup, f)
			--print(mapSetup.x)
		end
	for i = 1,#mapSetup do
		--print('yes')
		local x = mapSetup[i]
		table.insert(map, x)
		--print(json.encode(map[i]))
		--print(map[i].id..' '..map[i].x..' '..map[i].y..' '..map[i].type)
	end
end

function showrow(udata,cols,values,names)
   assert(udata=='test_udata')
   print('exec:')
   for i=1,cols do print('',names[i],values[i]) end
   return 0
 end

function dbStuff:test1()
  local hDB = sqlite3.open("test1.db")
  if hDB then
    local sQuery = "CREATE TABLE test1 (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT);"
    hDB:exec(sQuery)
    hDB:close()
    sql=[=[
         CREATE TABLE numbers(num1,num2,str);
         INSERT INTO numbers VALUES(1,11,"ABC");
         INSERT INTO numbers VALUES(2,22,"DEF");
         INSERT INTO numbers VALUES(3,33,"UVW");
         INSERT INTO numbers VALUES(4,44,"XYZ");
         SELECT * FROM numbers;
       ]=]
       hDB:exec(sql,showrow,'test_udata')
    love.event.quit()
  end
end

function dbStuff:test2()
  counter = 0
  map = sqlite3.open("test2.db");
	for i=1,(gridSize)^2 do
		type = 'open'
		local a = math.floor((i-1)/gridSize)
		local c = math.floor(i-(a*gridSize))
		local drawY = squareSize*a + startY + (1*a)
		local drawX = (i - (gridSize*a) - 1)*squareSize + startX + (1*c)
		local row = math.ceil(i/gridSize)
		local column = i-(40*(row-1))

		local tile = {mode = 'fill', x = drawX, y = drawY, type = type, r = nil, g = nil, b = nil, a = 255, row = row, column = column}
    local sql1 = "CREATE TABLE tiles(mode,x,y,type,r,g,b,a,row,column);"
    local sql2 = "INSERT INTO tiles VALUES('tile.mode', 'tile.x', 'tile.y', 'tile.type', 'tile.r', 'tile.g', 'tile.b', 'tile.a', 'tile.row', 'tile.column');"
    map:exec(sql1)
    map:exec(sql2)
    counter = counter+1
	end
  map:close()
end

--[[function dbStuff:test3()
  hDB = sqlite3.open("test3.db")
  for i=1,(gridSize)^2 do
    local type = open
    local tile = {id = i, mode = 'fill', type = type}
    table.insert(map, tile)
  end
  local sql1 = "CREATE TABLE tiles(id PRIMARY KEY,mode,x,y,type,r,g,b,a,row,column);"
  hDB:exec(sql1)

  for i=1,#map do
    hDB:exec(string.format("INSERT INTO tiles VALUES(%d, '%s', %d, %d, '%s', %d, %d, %d, %d, %d, %d);",
    map[i].id, map[i].mode, map[i].x, map[i].y, map[i].type, map[i].r, map[i].g, map[i].b, map[i].a, map[i].row, map[i].column))
  end
end]]

--[[local a = math.floor((i-1)/gridSize)
local c = math.floor(i-(a*gridSize))
local drawY = squareSize*a + startY + (1*a)
local drawX = (i - (gridSize*a) - 1)*squareSize + startX + (1*c)
local row = math.ceil(i/gridSize)
local column = i-(40*(row-1))]]

return dbStuff
