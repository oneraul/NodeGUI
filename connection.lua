local Connection = class("Connection")

function Connection:init(output, input)
	self.bullet_output = output
	self.bullet_input = input
	table.insert(G_elements, self)
end

function Connection:calculateCurve()
	local control_point_offsetX = 75
	local step = 0.05
	
	local p0 = {x = self.bullet_output:getX(), y = self.bullet_output:getY()}
	local p3 = {x = self.bullet_input:getX(),  y = self.bullet_input:getY()}
	local p1, p2 = {x = p0.x+control_point_offsetX, y = p0.y}, {x = p3.x-control_point_offsetX, y = p3.y}
	local curve = {}
	local bounds = {x = p0.x, y = p0.y, width = p3.x-p0.x, height = p3.y-p0.y}

	for t = 0, 1+step, step do
		local x = ((1-t)^3)*p0.x + 3*((1-t)^2)*t*p1.x + 3*(1-t)*(t^2)*p2.x + (t^3)*p3.x
		local y = ((1-t)^3)*p0.y + 3*((1-t)^2)*t*p1.y + 3*(1-t)*(t^2)*p2.y + (t^3)*p3.y
		table.insert(curve, x)
		table.insert(curve, y)
	end
	return curve, bounds
end

function Connection:draw()
	if G_selected == self then
		love.graphics.setColor(200, 0, 0)
	else love.graphics.setColor(255, 255, 255) end
	local curve = self:calculateCurve()
	love.graphics.line(curve)
end

function Connection:mouse(x, y, action)
	if action == "clicked" then
		local curve, bounds = self:calculateCurve()

		-- brad test: AABB
		if x > bounds.x and x < bounds.x+bounds.width
		and y > bounds.y and y < bounds.y+bounds.height then
			-- TODO narrow test
			G_selected = self
			return true
		else return false end
	else return false end
end

return Connection