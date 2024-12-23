--- Day 14 Part 2: Restroom Redoubt ---

--- Busco la primer vez en donde las posiciones de los robots es unica
--- NO existen dos robots ubicados en el mismo lugar
--- .
local filename = "d14.txt"
-- local filename = "test.txt"

local width, height = 101,103      ---cant filas/columnas (rows/colms)
-- local width, height = 11,7      ---cant filas/columnas (rows/colms)
local max_seconds = 100000000


local function printmapa(robots)
    print()
    os.execute('cls')
    local mapa ={}
    for i=1,height do
        mapa[#mapa+1] = {} 
        for j=1,width do
            mapa[#mapa][j] = ' ' 
        end
    end
    for _, k in ipairs(robots) do
        mapa[k.p.y+1][k.p.x] = 'X'
    end
    for i=1,height do
        print(table.concat(mapa[i]))
    end
end


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
    local set_pos = {}
    local dup = false                               --duplicado
    for i,k in ipairs(robots) do
        local nx = k.p.x + k.v.x
        local ny = k.p.y + k.v.y
        if nx >= width  then nx = nx - width end
        if nx <  0      then nx = width + nx end
        if ny >= height then ny = ny - height end
        if ny < 0       then ny = height +ny end
        k.p =  { x = nx, y = ny }
        if set_pos[ nx + ny * 1000] ~= nil then dup = true end  -- es duplicado?
        set_pos[ nx + ny * 1000] = 1
    end
    secs = secs + 1
    if not dup then 
        printmapa(robots)
        print("Solucion parte 2 Segundos: "..secs)      --- Res: 6876
        os.exit(0)
    end 

    if secs >= max_seconds then stop = true end
end

