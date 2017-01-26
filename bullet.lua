local Bullet = class("Bullet", {
	x = 0, y = 0
})

Bullet.radius = 6

function Bullet:init(field, isOutput)
	self.field = field
	self.isOutput = isOutput
	if isOutput then self.x = field.window.width end
	self.y = field.height/2
end

function Bullet:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle("line", self:getX(), self:getY(), Bullet.radius)
end

function Bullet:mouse(x, y, action)
	if dst2(x, y, self:getX(), self:getY()) < Bullet.radius^2 then
		if action == "clicked" then
			G_newLine = {origin = self, x = (love.mouse.getX()-G_cam.x)/G_cam.zoom, y = (love.mouse.getY()-G_cam.y)/G_cam.zoom}
			G_dragging = G_newLine
		elseif action == "released" then
			if G_newLine ~= nil and G_newLine.origin.isOutput ~= self.isOutput then
				local output, input
				if self.isOutput then output, input = self, G_newLine.origin else output, input = G_newLine.origin, self end
				Connection:new(output, input)
			end
		end
		return true
	else return false end
end

function Bullet:getX() return self.field.window.x + self.x end
function Bullet:getY() return self.field.window.y + self.field.y + self.y end

return Bullet