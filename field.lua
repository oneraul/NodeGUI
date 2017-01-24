local Field = class("Field", {
 y = 0, height = 22
})

local marginX, marginY = 15, 5

function Field:init(window, name, input, output)
	self.name = name
	self.window = window
	
	self.y = window.titleHeight
	for k, v in ipairs(window.fields) do
		self.y = self.y + v.height
	end

	table.insert(window.fields, self)

	if input then self.input = Bullet(self, false) end
	if output then self.output = Bullet(self, true) end
end

function Field:draw()
	love.graphics.setColor(180, 180, 180)
	love.graphics.line(self.window.x, self.window.y+self.y, self.window.x+self.window.width, self.window.y+self.y)
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf(self.name, self.window.x+marginX, self.window.y+self.y+marginY, 100, "left")
	if self.input ~= nil then self.input:draw() end
	if self.output ~= nil then self.output:draw() end
end

function Field:mouse(x, y, action)
	--TODO return true

	if self.input ~= nil then self.input:mouse(x, y, action) end
	if self.output ~= nil then self.output:mouse(x, y, action) end

	return false
end

return Field