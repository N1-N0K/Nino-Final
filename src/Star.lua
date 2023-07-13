Star = Class{}

function Star:init()
    self.image = textures['yellowstar']
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = math.random(self.width, VIRTUAL_WIDTH - self.width)
    self.y = 0

    self.dy = 3

    self.removed = false
    self.timer = 0

end

function Star:update(dt)
    self.dy = self.dy + SPEED * dt
    self.y = self.y + self.dy
end

function Star:render()
    if not self.remove then
        love.graphics.draw(self.image, self.x, self.y)
    end
end

function Star:hit(player)
    if self.y + self.height >= player.y - player.height and 
     self.x + self.width >= player.x - player.width then
     self.hit = true
     self.removed = true
    end

    self.removed = true
end