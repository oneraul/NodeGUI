local Textfield = class("Textfield", {
	width = 100, height = 22,
	text = "",
})

function Textfield:draw()
	love.graphics.setColor(35, 35, 35)
	love.graphics.rectangle("fill", self:getX(), self:getY(), self.width, self.height)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("line", self:getX(), self:getY(), self.width, self.height)
	love.graphics.printf(self.text, self:getX(), self:getY(), self.width, "left")

	-- focus border
	if G_textinput == self then
		love.graphics.setColor(200, 35, 35)
		love.graphics.rectangle("line", self:getX(), self:getY(), self.width, self.height)
	end
end

function Textfield:mouse(x, y, action)
	if action == "released" then
		if x > self:getX() and x < self:getX()+self.width
		and y > self:getY() and y < self:getY()+self.height then
			G_textinput = self
			love.keyboard.setTextInput(true)
			return true
		else return false end
	else return false end
end

function Textfield:getX() return self.field.window.x+80 end
function Textfield:getY() return self.field.window.y+self.field.y end

return Textfield