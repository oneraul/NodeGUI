local Field = class("Field")

function Field:init(window, name, input, output)
	self.name = name
	self.window = window
	self.index = #window.fields+1
	table.insert(window.fields, self)

	if input then self.input = {} end
	if output then self.output = {} end
end

function Field:draw()
	local y = self.window:getFieldY(self.index)

	love.graphics.setColor(255, 255, 255)
	love.graphics.printf(self.name, self.window.x, y, 100, "left")
	if self.input ~= nil then love.graphics.circle("line", self.window.x, y, 5) end
	if self.output ~= nil then love.graphics.circle("line", self.window.x+self.window.width, y, 5) end
end

function Field:clicked(x, y)
	-- TODO check input/output

	return false
end

return Field