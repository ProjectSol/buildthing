
--[[--
 ▄▀▀█▄▄   ▄▀▀█▄▄▄▄  ▄▀▀▀▀▄  ▄▀▀▄ ▀▀▄  ▄▀▀▄ ▀▄  ▄▀▄▄▄▄
█ ▄▀   █ ▐  ▄▀   ▐ █ █   ▐ █   ▀▄ ▄▀ █  █ █ █ █ █    ▌
▐ █    █   █▄▄▄▄▄     ▀▄   ▐     █   ▐  █  ▀█ ▐ █
  █    █   █    ▌  ▀▄   █        █     █   █    █
 ▄▀▄▄▄▄▀  ▄▀▄▄▄▄    █▀▀▀       ▄▀    ▄▀   █    ▄▀▄▄▄▄▀
█     ▐   █    ▐    ▐          █     █    ▐   █     ▐
▐         ▐                    ▐     ▐        ▐
--]]--

local lg = love.graphics
local lm = love.mouse
local PANEL = {}

function PANEL:initialize()
	self.columnWidth = 25
	self.rowHeight = 25
	self.gridObjects = {}
	self.xgap = 5
	self.ygap = 5
end

function PANEL:setColumnWidth( n )
	self.columnWidth = n
	self:arrangeGrid()
end

function PANEL:getColumnWidth()
	return self.columnWidth
end

function PANEL:setRowHeight( n )
	self.rowHeight = n
	self:arrangeGrid()
end

function PANEL:getRowHeight()
	return self.rowHeight
end

function PANEL:setXGap( gap )
	self.xgap = gap
	self:arrangeGrid()
end

function PANEL:getXGap()
	return self.xgap
end

function PANEL:setYGap( gap )
	self.ygap = gap
	self:arrangeGrid()
end

function PANEL:getYGap()
	return self.ygap
end

function PANEL:setGap( x, y )
	self.xgap = x; self.ygap = y
	self:arrangeGrid()
end

function PANEL:getGap()
	return self.xgap, self.ygap
end

function PANEL:arrangeGrid()

	local rowH = self:getRowHeight()
	local colW = self:getColumnWidth()

	local gridObjects = self:getGridObjects()

	local cols = math.ceil( self:getWidth()/colW )
	local rows = math.ceil( #gridObjects/cols )

	local count = 0
	for r = 1,rows do
		for c = 1,cols do
			if count >= #gridObjects then
				break
			end

			local k = (r-1)*cols + c

			local xgap = self:getXGap()
			local ygap = self:getYGap()

			local w,h = gridObjects[ k ]:getSize()

			local x = (colW + xgap)*( c - 1 ) + ( colW - w )/2
			local y = (rowH + ygap)*( r - 1 ) + ( rowH - h )/2 

			gridObjects[ k ]:setPos( x, y )

			count = count + 1
		end
	end

end

function PANEL:getGridObjects()
	return self.gridObjects
end

function PANEL:add( panel )
	panel:setParent( self )
	table.insert( self.gridObjects, panel )
	self:arrangeGrid()
end

function PANEL:clearGrid()
	lume.each( self:getGridObjects(), "remove" )
	self.gridObjects = {}
end 

function PANEL:onSizeChanged()
	self:arrangeGrid()
end

function PANEL:onChildAdded( panel )
end

function PANEL:onChildRemoved( panel )
	--lume.remove( self.gridObjects, panel )
end

function PANEL:paint( w, h )
	lg.setColor( 120, 120, 120, 255 )
	lg.rectangle( "fill", 0, 0, w, h )
	-- local rowH = self:getRowHeight()
	-- local colW = self:getColumnWidth()

	-- local rows = math.ceil( (self:getHeight()/rowH) )
	-- local cols = math.ceil( (self:getWidth()/colW) )

	-- local gridObjects = self:getGridObjects()
	-- local count = 0
	-- for r = 1,rows do
	-- 	for c = 1,cols do
	-- 		if count >= #gridObjects then
	-- 			break
	-- 		end

	-- 		local k = (r-1)*rows + c

	-- 		local xgap = self:getXGap()
	-- 		local ygap = self:getYGap()

	-- 		local x = (colW + xgap)*( c - 1 )
	-- 		local y = (rowH + ygap)*( r - 1 )

	-- 		lg.setColor( 255, 255, 255, 255 )
	-- 		lg.rectangle( "fill", x, y, colW, rowH )

	-- 		print( "owo")

	-- 		count = count + 1
	-- 	end
	-- end
end

gui.register( "grid", PANEL, "panel" )
