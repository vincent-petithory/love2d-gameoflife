World = require("world")

-- Config
function love.load()
   drawWidth, drawHeight, _ = love.window.getMode()
   world = World.next(World.new(128, 128))
end

-- Resize
function love.resize(w, h)
   drawWidth, drawHeight = w, h
end

-- Update state
function love.update(dt)
   world = World.next(world)
end

-- Draw state on screen
function love.draw()
   love.graphics.setColor(255, 255, 255)
   love.graphics.rectangle("fill", 0, 0, drawWidth, drawHeight)
   drawWorld(world, 0, 0, drawWidth, drawHeight)
end

function drawWorld(world, x, y, width, height)
   cellWidth, cellHeight = width/world.width, height/world.height
   love.graphics.setColor(118, 93, 147)
   love.graphics.rectangle("line", x, y, width, height)
   for _, cell in ipairs(World.getCells(world)) do
      if cell.lives > 0 then
	 love.graphics.rectangle("fill", x+cell.x*cellWidth, y+cell.y*cellHeight, cellWidth, cellHeight)
      end
   end
end
