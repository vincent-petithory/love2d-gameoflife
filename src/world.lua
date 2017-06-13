
function new(w, h)
   local world = {width=w, height=h, cells={}}
   for y = 1, h do
      for x = 1, w do
	 local lives = 0
	 if love.math.random() < 0.5 then lives = 1 end
	 table.insert(world.cells, lives)
      end
   end
   return world
end

function next(world)
   local nextWorld = {width=world.width, height=world.height, cells={}}
   for idx, lives in ipairs(world.cells) do
      local x = (idx-1) % world.width
      local y = ((idx-1) - x) / world.width
      local a = getAliveNeighbors(world, x, y)
      local nlives
      if x == 0 or y == 0 or x == world.width - 1 or y == world.height - 1 then
	 nlives = 0
      else 
	 if lives == 0 then
	    if a == 3 then nlives = 1
	    else nlives = 0 end
	 else
	    if a < 2 then nlives = 0
	    elseif a < 4 then nlives = lives + 1
	    else nlives = 0 end
	 end
      end
      nextWorld.cells[idx] = nlives
   end
   return nextWorld
end

function getAliveNeighbors(world, x, y)
   local points = {
      { x=x - 1, y=y - 1 },
      { x=x, y=y - 1 },
      { x=x + 1, y=y - 1 },
      { x=x - 1, y=y },
      { x=x + 1, y=y },
      { x=x - 1, y=y + 1 },
      { x=x, y=y + 1 },
      { x=x + 1, y=y + 1 },
   }
   local c = 0
   for _, p in ipairs(points) do
      if cellAt(world, p.x, p.y) > 0 then c = c + 1 end
   end
   return c
end

function getCells(world)
   local cells = {}
   for idx, lives in ipairs(world.cells) do
      local x = (idx-1) % world.width
      local y = ((idx-1) - x) / world.width
      table.insert(cells, {x=x, y=y, lives=lives})
   end
   return cells
end

function cellAt(world, x, y)
   if x < 0 then x = world.width - 1
   elseif x >= world.width then x = 0 end
   if y < 0 then y = world.height - 1
   elseif y >= world.height then y = 0 end

   local idx = 1 + y*world.width + x
   local lives = world.cells[idx]
   if not lives then return 0 else return lives end
end

return {
   new=new,
   next=next,
   getCells=getCells,
}
