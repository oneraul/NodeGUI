local Connection = class("Connection")

function Connection:init(output, input)
	self.bullet_output = output
	self.bullet_input = input
	table.insert(G_connections, self)
end

function Connection:draw()

	local control_point_offsetX = 75
	local step = 0.05
	
	local p0 = {x = self.bullet_output:getX(), y = self.bullet_output:getY()}
	local p3 = {x = self.bullet_input:getX(),  y = self.bullet_input:getY()}
	local p1, p2 = {x = p0.x+control_point_offsetX, y = p0.y}, {x = p3.x-control_point_offsetX, y = p3.y}
	local curve = {}
	for t = 0, 1+step, step do
		local x = ((1-t)^3)*p0.x + 3*((1-t)^2)*t*p1.x + 3*(1-t)*(t^2)*p2.x + (t^3)*p3.x
		local y = ((1-t)^3)*p0.y + 3*((1-t)^2)*t*p1.y + 3*(1-t)*(t^2)*p2.y + (t^3)*p3.y
		table.insert(curve, x)
		table.insert(curve, y)
	end
	
	love.graphics.setColor(255, 255, 255)
	love.graphics.line(curve)
end

return Connection