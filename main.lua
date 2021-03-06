function dst2(x1, y1, x2, y2)
	local x, y = x2-x1, y2-y1
	return x*x + y*y
end

function removeValueFromTable(_table, value)
	for i = 1, #_table do
		if _table[i] == value then table.remove(_table, i) break end
	end
end

function love.load()
	love.keyboard.setKeyRepeat(true)
	love.graphics.setBackgroundColor(25, 50, 75)

	G_dragging = nil
	G_selected = nil
	G_newLine = nil
	G_textinput = nil
	G_elements = {}
	G_cam = {x = 0, y = 0, zoom = 1}

	utf8 = require 'utf8'
	class = require '30log'
	Checkbox = require 'checkbox'
	Textfield = require 'textfield'
	Bullet = require 'bullet'
	Connection = require 'connection'
	Field = require 'field'
	Window = require 'window'
	
	---------------------------------------

	local win3 = Window(400, 300, 200, 200)
	Field(win3, "Coso", nil, true, true)
	Field(win3, "Mohoso", nil, false, true)
	Field(win3, "Para todos")
	Field(win3, "Check", Checkbox())

	local win4 = Window(100, 100)
	Field(win4, "Test", nil, true, true)
	Field(win4, "Text", Textfield(), false, false)
	
end

function love.draw()
	-- set cam
	love.graphics.origin()
	love.graphics.translate(G_cam.x, G_cam.y)
	love.graphics.scale(G_cam.zoom)

	for k, element in ipairs(G_elements) do element:draw() end
	
	if G_newLine ~= nil then
		love.graphics.line(G_newLine.origin:getX(), G_newLine.origin:getY(), G_newLine.x, G_newLine.y)
	end
end

function love.mousepressed(x, y, button, istouch)
	x, y = (x-G_cam.x)/G_cam.zoom, (y-G_cam.y)/G_cam.zoom

	G_selected, G_textinput = nil, nil
	love.keyboard.setTextInput(false)

	if love.keyboard.isDown("space") then
		G_dragging = G_cam
	else
		for k, element in ipairs(G_elements) do
			if element:mouse(x, y, "clicked") then break end
		end
	end
end

function love.mousemoved(x, y, dx, dy, istouch)
	dx, dy = dx/G_cam.zoom, dy/G_cam.zoom

	if G_dragging ~= nil then
		G_dragging.x = G_dragging.x + dx
		G_dragging.y = G_dragging.y + dy
	end
end

function love.mousereleased(x, y, button, istouch)
	x, y = (x-G_cam.x)/G_cam.zoom, (y-G_cam.y)/G_cam.zoom

	for k, element in ipairs(G_elements) do
		if element:mouse(x, y, "released") then break end
	end
	
	G_dragging, G_newLine = nil, nil
end

function love.textinput(t)
	if G_textinput ~= nil then G_textinput.text = G_textinput.text .. t end
end

function love.keypressed(key)
 if key == "backspace" then
		if G_textinput ~= nil then
			-- get the byte offset to the last UTF-8 character in the string.
			local byteoffset = utf8.offset(G_textinput.text, -1)
			if byteoffset then
				-- remove the last UTF-8 character.
				-- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
				G_textinput.text = string.sub(G_textinput.text, 1, byteoffset - 1)
			end
		end
	elseif key == "delete" then
		if G_selected ~= nil then
			G_selected:remove()
			removeValueFromTable(G_elements, G_selected)
		end
	end
end

function love.wheelmoved(dx, dy)
	G_cam.zoom = G_cam.zoom + dy * 0.01
end