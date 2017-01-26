local Checkbox = class("Checkbox", {
	width = 12, height = 12
})

function Checkbox:init(active) 
	self.active = active or false
end

function Checkbox:draw() 
	love.graphics.setColor(35, 35, 35)
	love.graphics.rectangle("fill", self:getX(), self:getY(), self.width, self.height)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("line", self:getX(), self:getY(), self.width, self.height)
	
	if self.active then
		love.graphics.line(self:getX(), self:getY()+self.height/3, 
							self:getX()+self.width/2, self:getY()+self.height,
							self:getX()+self.width, self:getY())
	end
end

function Checkbox:mouse(x, y, action) 
	if action == "released" then
		if x > self:getX() and x < self:getX()+self.width
		and y > self:getY() and y < self:getY()+self.height then
			self.active = not self.active
			return true
			
		else return false end
	else return false end
end

function Checkbox:getX() return self.field.window.x+80 end
function Checkbox:getY() return self.field.window.y+self.field.y+(self.field.height-self.height)/2 end

return Checkbox