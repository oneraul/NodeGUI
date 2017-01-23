local Window = class("Window", {
	x = 100, y = 100,
	width = 200, height = 100,
	title = "Window",
	fields = {}
})

local titleHeight = 16
local windowMarginX = 15
local windowFieldHeight = 22
local windowFieldBulletRadius = 5

function Window:init(x, y, width, height)
	self.x, self.y = x, y
	self.width, self.height = width, height
	table.insert(windows, self)
end

function Window:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	love.graphics.printf(self.title, self.x, self.y, self.width, "center")
	love.graphics.line(self.x, self.y+titleHeight, self.x+self.width, self.y+titleHeight)
	
	for k, v in ipairs(self.fields) do
		--love.graphics.printf(v.name, self.x+windowMarginX, self.y+titleHeight+windowFieldHeight*k, self.width-windowMarginX*2, "left")
		--if v.input then love.graphics.circle("line", self.x, self.y+titleHeight+windowFieldHeight/2+windowFieldHeight*k, windowFieldBulletRadius) end
		--if v.output then love.graphics.circle("line", self.x+self.width, self.y+titleHeight+windowFieldHeight/2+windowFieldHeight*k, windowFieldBulletRadius) end

		v:draw()
	end
end
	
function Window:getFieldY(i)
	return self.y+titleHeight+windowFieldHeight/2+windowFieldHeight*i
end

function Window:clicked(x, y)
	if x > self.x and x < self.x+self.width
	and y > self.y and y < self.y+self.height then
		if y < self.y+titleHeight then
			dragging = self
		else
			for k, v in ipairs(self.fields) do
				if v:clicked(x, y) then break end
			end
		end
		return true
	else
		return false
	end
end

return Window