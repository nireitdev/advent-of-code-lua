--- Day 14: Restroom Redoubt ---

--- Simplemente se mueven los robotos y despues se calcula los cuadrantres

local filename = "d14.txt"
-- local filename = "test.txt"

local width, height = 101,103      ---cant filas/columnas (rows/colms)
-- local width, height = 11,7      ---cant filas/columnas (rows/colms)
local max_seconds = 100

local robots = {}
for l in  io.lines(filename) do
        for px,py,vx,vy in  string.gmatch(l,"p=(.*),(.*) v=(.*),(.*)")  do        
            robots[#robots+1] = { p = { x= tonumber(px), y= tonumber(py)}, 
                                    v={ x= tonumber(vx), y= tonumber(vy)}}
        end
end

local secs = 0
local stop = false
while not stop do
    for i,k in ipairs(robots) do
        local nx = k.p.x + k.v.x
        local ny = k.p.y + k.v.y
        if nx >= width  then nx = nx - width end
        if nx <  0      then nx = width + nx end
        if ny >= height then ny = ny - height end
        if ny < 0       then ny = height +ny end
        k.p =  { x = nx, y = ny }
    end
    secs = secs + 1
    if secs >= max_seconds then stop = true end
end

local result = 1
local midx, midy = width//2, height//2
for m=0,1 do
    for n=0,1 do
        local c = 0
        for _, k in ipairs(robots) do
            if k.p.x >= (midx+1) * m and
                k.p.x < midx * (m+1) + m and
                k.p.y >= (midy+1) * n and
                k.p.y < midy * (n+1) + n then
                 c = c + 1    
                end 
        end
        print("quad "..m..","..n.." cant= "..c)
        result = result * c
    end
end

print("Solucion Parte 1 = "..result)   -- R: 216027840