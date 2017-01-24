local Bullet = class("Bullet", {
	x = 0, y = 0
})

Bullet.radius = 6

function Bullet:init(field, output)
	self.field = field
	self.output = output
	if output then self.x = field.window.width end
	self.y = field.height/2
end

function Bullet:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle("line", self:getX(), self:getY(), Bullet.radius)
end

function Bullet:mouse(x, y, action)
	if dst2(x, y, self:getX(), self:getY()) < Bullet.radius^2 then
		if action == "clicked" then
			newLine = {origin = self, x = love.mouse.getX(), y = love.mouse.getY()}
			dragging = newLine
		elseif action == "released" then
			local output, input
			if self.output then output, input = self, newLine.origin else output, input = newLine.origin, self end
			Connection:new(output, input)
		end
		return true
	else return false end
end

function Bullet:getX() return self.field.window.x + self.x end
function Bullet:getY() return self.field.window.y + self.field.y + self.y end

return Bullet