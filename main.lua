function dst2(x1, y1, x2, y2)
	local x, y = x2-x1, y2-y1
	return x*x + y*y
end

function love.load()
	love.graphics.setBackgroundColor(25, 50, 75)

	dragging = nil
	newLine = nil
	connections = {}
	windows = {}

	class = require '30log'
	Textfield = require 'textfield'
	Bullet = require 'bullet'
	Connection = require 'connection'
	Field = require 'field'
	Window = require 'window'

	local win3 = Window(400, 300)
	Field(win3, "Coso", true, true)
	Field(win3, "Mohoso", false, true)
	Field(win3, "Para todos")

	local win4 = Window(100, 100)
	Field(win4, "Test", true, true)
end

function love.draw()
	for k, window in ipairs(windows) do window:draw() end
	for k, connection in ipairs(connections) do connection:draw() end
	
	if newLine ~= nil then
		love.graphics.line(newLine.origin:getX(), newLine.origin:getY(), newLine.x, newLine.y)
	end
	
	love.graphics.print(text, 10, 10)
end

function love.mousepressed(x, y, button, istouch)
	for k, window in ipairs(windows) do
		if window:mouse(x, y, "clicked") then break end
	end
end

function love.mousemoved(x, y, dx, dy, istouch)
	if dragging ~= nil then
		dragging.x = dragging.x + dx
		dragging.y = dragging.y + dy
	end
end

function love.mousereleased(x, y, button, istouch)	
	for k, window in ipairs(windows) do
		if window:mouse(x, y, "released") then break end
	end
	
	dragging, newLine = nil, nil
end

text = ""
function love.textinput(t)
    text = text .. t
end