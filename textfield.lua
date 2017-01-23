local Textfield = class("Textfield", {
	x = 0, y = 0,
	width = 100, height = 16,
	text = "",
})

function Textfield:draw()
	love.graphics.setColor(50, 50, 50)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	love.graphics.printf(self.text, self.x, self.y, self.width, "left")
end

return Textfield