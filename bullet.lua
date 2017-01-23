local Bullet = class("Bullet", {
	x = 0, y = 0
})

local radius = 6

function Bullet:init(field, output)
	self.field = field
	self.output = output
	if output then self.x = field.window.width end
	self.y = field.height/2
end

function Bullet:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle("line", self.field.window.x+self.x, self.field.window.y+self.field.y+self.y, radius)
end

function Bullet:clicked(x, y)
	if dst2(x, y, self.field.window.x+self.x, self.field.window.y+self.field.y+self.y) < radius*radius then
		newLine = {origin = self, x = love.mouse.getX(), y = love.mouse.getY()}
		dragging = newLine
		return true
	else return false end
end

return Bullet