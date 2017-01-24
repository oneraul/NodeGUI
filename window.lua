local Window = class("Window", {
	titleHeight = 16,
	x = 100, y = 100,
	width = 200, height = 100,
	title = "Window",
	fields = {}
})

function Window:init(x, y, width, height, title)
	self.x, self.y = x, y
	self.width, self.height = width, height
	self.title = title
	table.insert(windows, self)
end

function Window:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	love.graphics.printf(self.title, self.x, self.y, self.width, "center")
	love.graphics.line(self.x, self.y+self.titleHeight, self.x+self.width, self.y+self.titleHeight)
	
	for k, v in ipairs(self.fields) do v:draw() end
end

function Window:mouse(x, y, action)
	if x > self.x-Bullet.radius and x < self.x+self.width+Bullet.radius
	and y > self.y and y < self.y+self.height then
		if y < self.y+self.titleHeight then
			if action == "clicked" then dragging = self end
		else
			for k, v in ipairs(self.fields) do
				if v:mouse(x, y, action) then break end
			end
		end
		return true
	else
		return false
	end
end

return Window