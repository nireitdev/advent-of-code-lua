--- Day 15 Parte2: Restroom Redoubt ---

--- Se mueven los robotos y despues se calcula los cuadrantres
--- Si el desplazamiento es "<" o ">" se reduce a un caso simple (parte1) de movimiento
--- Pero si es "^" o "v" se complica: hago recursivo la buscqueda de los "[]"
--- e intento moverlos, si algun movimiento falla "canmove=false" entonces hago
--- un "undo" y anulo todos los movimientos hechos.
--- La tabla "undo" contiene el backup del mapa.
--- Se puede sacar los comentarios de la linea 120 para ver la animacion

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
    local canmove,test_left, test_right = false, false,false
    local next = from
    local to = { x = from.x + translate[dir].x , y = from.y + translate[dir].y}
    if mapa[to.y] == nil or mapa[to.y][to.x] == nil then return false end
    
    if mapa[to.y][to.x] == "#" then return false end
    if mapa[to.y][to.x] == "." then 
        canmove = true 
    else
        if dir=="^" or dir=="v" then
            if mapa[to.y][to.x] == "]" then
                local new_to = { x=to.x-1,y = to.y} 
                test_left = mover( new_to,dir)            
                test_right = mover(to,dir) 
                canmove = test_left and test_right
            end
            if mapa[to.y][to.x] == "[" then
                local new_to = { x=to.x+1,y = to.y} 
                test_left = mover(to,dir) 
                test_right = mover( new_to,dir)            
                canmove = test_left and test_right
            end
        else
                canmove = mover(to, dir) 
        end
    end

    if canmove then
        mapa[to.y][to.x] = mapa[from.y][from.x]    --- copiar "@" "[" "]" 
        mapa[from.y][from.x] = "."
        next = to
    end
    -- printmapa() 
    return canmove, next 
end

local start = {}
for l in  io.lines(filename) do
    local c = string.sub(l,1,1)
    if c =='#' then 
        mapa[#mapa+1] = {}
        for i=1,#l do
            local c = string.sub(l,i,i)
            if c=='O' then
                table.insert(mapa[#mapa] , "[" )    --"[]"
                table.insert(mapa[#mapa] , "]" )
            end
            if c == '@' then 
                table.insert(mapa[#mapa] , c )      -- "@."
                start = {x=#mapa[#mapa], y=#mapa }
                table.insert(mapa[#mapa] , "." )
            end
            if c=="#" or c=="."  then
                table.insert(mapa[#mapa] , c )      -- "##" ".."
                table.insert(mapa[#mapa] , c )
            end
        end
    end 
    if c=='<' or c=='>' or c=="^" or c=='v' then
        movs[#movs+1] = {}
        for i=1,#l do
            local c = string.sub(l,i,i)
            movs[#movs][i] = c
        end
    end
end


local res, next = false, start
for i=1,#movs do
    for j=1,#movs[i] do

        local undo = {}     ---undo: backup "mapa"
        for i=1,#mapa do    --- deep copy
            undo[i] = {}
            for j=1,#mapa[i] do
                undo[i][j]=mapa[i][j]
            end
        end

        res,next = mover(start,movs[i][j])
        if res == false then
            mapa = undo     --- no se puede mover => restauro "undo"
        else
            start = next
        end
        -- printmapa()          --debug animacion del map
    end
end

local result = 0
for y=1,#mapa do
    for x=1,#mapa[y] do 
        if mapa[y][x] == '[' then
            result = result + 100 * (y-1) + (x-1)
        end
    end
end

print("\nSolucion Parte 2 = "..result)   -- R: 1575877