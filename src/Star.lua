Star = Class{}

function Star:init()
    self.image = textures['yellowstar']
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = math.random(self.width, VIRTUAL_WIDTH - self.width)
    self.y = 0

    self.dy = 2

    self.remove = false
end

function Star:update(dt)
    self.y = self.y + self.dy + SPEED * dt

    if self.y + self.height  > VIRTUAL_HEIGHT then 
        self.remove = true
    end
	
end

function Star:hit(player)
    if self.x + self.width < player.x or self.x > player.x + player.width then
        return false
    elseif self.y + self.height < player.y or self.y > player.y + player.height then
        return false
    else
        return true
    end
end

function Star:render()
    love.graphics.draw(self.image, self.x, self.y)
end