function dst2(x1, y1, x2, y2)
	local x, y = x2-x1, y2-y1
	return x*x + y*y
end

function love.load()

  dragging = nil
  newLine = nil
  connections = {}
  windows = {}

  class = require '30log'
  Textfield = require 'textfield'
		Bullet = require 'bullet'
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
	love.graphics.clear(25, 50, 75)
	for k, window in ipairs(windows) do window:draw() end
	
	if newLine ~= nil then
		love.graphics.line(newLine.origin:getX(), newLine.origin:getY(), newLine.x, newLine.y)
	end

	for k, v in ipairs(connections) do 
		local offset1, offset2 = 0, 0
		if v.window1_field_side == "output" then offset1 = v.window1.width end
		if v.window2_field_side == "output" then offset2 = v.window2.width end
		
		local p0 = {x = v.window1.x+offset1, y = v.window1:getFieldY(v.window1_field)}
		local p3 = {x = v.window2.x+offset2, y = v.window2:getFieldY(v.window2_field)}
		local p1, p2 = {x = p0.x+75, y = p0.y}, {x = p3.x-75, y = p3.y}
		local curve = {}
		for t = 0, 1, 0.05 do
			local x = ((1-t)^3)*p0.x + 3*((1-t)^2)*t*p1.x + 3*(1-t)*(t^2)*p2.x + (t^3)*p3.x
			local y = ((1-t)^3)*p0.y + 3*((1-t)^2)*t*p1.y + 3*(1-t)*(t^2)*p2.y + (t^3)*p3.y
			table.insert(curve, x)
			table.insert(curve, y)
		end
		love.graphics.line(curve)
	end
	
	love.graphics.print(text, 10, 10)
end

function love.mousepressed(x, y, button, istouch)
  for k, window in ipairs(windows) do
    if window:clicked(x, y) then break end
  end
end

function love.mousemoved(x, y, dx, dy, istouch)
	if dragging ~= nil then
		dragging.x = dragging.x + dx
		dragging.y = dragging.y + dy
	end
end

function love.mousereleased(x, y, button, istouch)
	--[[
	if dragging == newLine then
		for k, window in ipairs(windows) do
			local dist2 = 25-------windowFieldBulletRadius*windowFieldBulletRadius
			for i, field in ipairs(window.fields) do
				if field.input then
					local bulletX, bulletY = window.x, window:getFieldY(i)
					if dst2(x, y, bulletX, bulletY) < dist2 then
						newLine.window2 = window
						newLine.window2_field = i
						newLine.window2_field_side = "input"
						table.insert(connections, newLine)
						break
					end
				end
				if field.output then
					local bulletX, bulletY = window.x+window.width, window:getFieldY(i)
					if dst2(x, y, bulletX, bulletY) < dist2 then
						newLine.window2 = window
						newLine.window2_field = i
						newLine.window2_field_side = "output"
						table.insert(connections, newLine)
						break
					end
				end
			end
		end
	end
	]]
	
	dragging, newLine = nil, nil
end

text = ""
function love.textinput(t)
    text = text .. t
end