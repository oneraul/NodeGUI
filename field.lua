local Field = class("Field", {
 y = 0, height = 22
})

local marginX, marginY = 15, 5

function Field:init(window, name, component, input, output)
	self.name = name
	self.window = window
	
	self.y = window.titleHeight
	for k, v in ipairs(window.fields) do
		self.y = self.y + v.height
	end

	table.insert(window.fields, self)

	if component ~= nil then
		self.component = component
		if component.height > self.height then self.height = component.height end

		component.field = self
	end

	if input then self.input = Bullet(self, false) end
	if output then self.output = Bullet(self, true) end
end

function Field:draw()
	love.graphics.setColor(180, 180, 180)
	love.graphics.line(self.window.x, self.window.y+self.y, self.window.x+self.window.width, self.window.y+self.y)
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf(self.name, self.window.x+marginX, self.window.y+self.y+marginY, 80, "left")
	if self.component ~= nil then self.component:draw() end
	if self.input ~= nil then self.input:draw() end
	if self.output ~= nil then self.output:draw() end
end

function Field:mouse(x, y, action)
	--TODO return true

	if self.component ~= nil then self.component:mouse(x, y, action) end
	if self.input ~= nil then self.input:mouse(x, y, action) end
	if self.output ~= nil then self.output:mouse(x, y, action) end

	return false
end

return Field