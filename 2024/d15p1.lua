--- Day 15: Restroom Redoubt ---

--- Simplemente se mueven los robotos y despues se calcula los cuadrantres
--- El movimiento de las piezas se realiza en forma recursiva desde el mas lejano hasta el '@'

local filename = "d15.txt"
-- local filename = "test.txt"


local mapa = {}
local movs = {}
local translate={ }
translate['>'] = {x=1, y=0}
translate['<'] = {x=-1, y=0}
translate['^'] = {x=0, y=-1}
translate['v'] = {x=0, y=1}

local function printmapa()
    os.execute('cls') --windows
    -- os.execute('clear') --linux
    print()
    for i=1,#mapa do
        print(table.concat(mapa[i]))
    end
    
end

local function mover(from,dir) --- from = {x, y}  direccion='<' '>' '^' 'v'
    local canmove = false
    local next = from
    local to = { x = from.x + translate[dir].x , y = from.y + translate[dir].y}
    if mapa[to.y] == nil or mapa[to.y][to.x] == nil then return false end
    
    if mapa[to.y][to.x] == "." then canmove = true end
    if mapa[to.y][to.x] == "#" then canmove = false end
    if mapa[to.y][to.x] == "O" then canmove = mover(to, dir) end

    if canmove then 
        mapa[to.y][to.x] = mapa[from.y][from.x]    --- copiar "@" "o" 
        mapa[from.y][from.x] = "."
        next = to
    end
    return canmove, next 
end

local start = {}
for l in  io.lines(filename) do
    local c = string.sub(l,1,1)
    if c =='#' then 
        mapa[#mapa+1] = {}
        for i=1,#l do
            local c = string.sub(l,i,i)
            mapa[#mapa][i] = c
            if c == '@' then start = {x=i, y=#mapa } end
        end
    end 
    if c=='<' or c=='>' or c=="^" or c=='v' then
        movs[#movs+1] = {}
        for i=1,#l do
            local c = string.sub(l,i,i)
            movs[#movs][i] = c
        end
    end
    -- for mapa in  string.gmatch(l,"p=(.*),(.*) v=(.*),(.*)")  do        
end

local res, next = false, start
for i=1,#movs do
    for j=1,#movs[i] do
        res,next = mover(next,movs[i][j])
        -- printmapa()          --debug hermoso mapa
    end
end

local result = 0
for y=1,#mapa do
    for x=1,#mapa[y] do 
        if mapa[y][x] == 'O' then
            result = result + 100 * (y-1) + (x-1)
        end
    end
end

print("\nSolucion Parte 1 = "..result)   -- R: 1568399