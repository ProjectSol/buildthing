buttonFunc = {}

function buttonFunc:checkMouseOver( x1,y1,w1,h1,x2,y2,w2,h2)
	return  x1 < x2+w2 and
			x2 < x1+w1 and
			y1 < y2+h2 and
			y2 < y1+h1
end
buttons = {}
--Here be-eth the button controls
function buttonFunc:Setup( i, n, m, bx, by, bw, bh, br, bg, bb, ba, tf, TF, rT, gT, bT )
	newButton = { id = i, name = n, mode = m, x = bx, y = by, w = bw, h = bh, r = br, g = bg, b = bb, a = ba, draw = tf, text = TF, rText = rT, gText = gT, bText = bT }
	table.insert( buttons, newButton )
	r = {}
	g = {}
	b = {}
	a = {}
	rT = {}
	gT = {}
	bT = {}
	for i = 1,#buttons do
		local button = buttons[ i ]
		r[i] = button.r
		g[i] = button.g
		b[i] = button.b
		a[i] = button.a
		rT[i] = button.rText
		gT[i] = button.gText
		bT[i] = button.bText
	end
end

function buttonFunc:drawText()
	for i = 1,#buttons do
		local button = buttons[ i ]
		if button.draw and button.text then
			if button.id == 1 then
				love.graphics.setFont(status)
				love.graphics.setColor(button.rText, button.gText, button.bText, 255)
				love.graphics.print(button.name, button.x + (button.w/10), button.y + (button.h/2) - 1)
			else
				love.graphics.setFont(status)
				love.graphics.setColor(button.rText, button.gText, button.bText, 255)
				love.graphics.print(button.name, button.x + (button.w/10), button.y + (button.h/2) - 1)
			end
		end
	end
end
function buttonFunc:draw()
	for i = 1,#buttons do
		local button = buttons[ i ]
		if button.draw then
			love.graphics.setColor(button.r, button.g, button.b, button.a)
			love.graphics.rectangle(button.mode, button.x, button.y, button.w, button.h)
		end
	end
end
function buttonFunc:Colour()
	for i = 1,#buttons do
		local button = buttons[i]
		local mX = love.mouse.getX()
		local mY = love.mouse.getY()
		if self:checkMouseOver(button.x, button.y, button.w, button.h, mX, mY, 1, 1 ) then
			button.r = button.r-50
			button.g = button.g-50
			button.b = button.b-50
			button.a = 255
			button.rText = 255
			button.gText = 255
			button.bText = 255
			print('test')
		else
			button.r = r[i]
			button.g = g[i]
			button.b = b[i]
			button.a = a[i]
			button.rText = rT[i]
			button.gText = gT[i]
			button.bText = bT[i]
		end
	end
end
