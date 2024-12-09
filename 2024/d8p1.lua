--- Day 8 Part 1: Resonant Collinearity ---

--- Cargo el mapa de "antenas" y luego creo un listado de antenas agrupadas por el nombre 
--- Calculo la distancia "geometrica" en el eje "x" y eje "y" => dX=x2-x1  dY=y2-y1
--- Luego aplico las diff X/Y haciendo la resta con el primer punto (mas al Norte) 
--- y la suma con el segundo punto (mas al Sur)
--- Cuento cuantos antinodos "#" DENTRO del mapa se crearon.

local filename = "d8.txt"
-- local filename = "test.txt"

--- Funciones
--- 
function Distancia(pos1,pos2)  --- pos = {x,y}
    local dx,dy = 0,0           --- diff (deltas) distancia
    dx = pos2.x - pos1.x 
    dy = pos2.y - pos1.y 
    return {x=dx, y=dy}
end

function PrintMapa(mapa)
    -- os.execute('clear')    --- linux
    os.execute('cls')    --- windows
    for i=1,#mapa do
        print(table.concat(mapa[i]))
    end
end

local mapa = {}

for l in  io.lines(filename) do
    mapa[#mapa+1] = {}
    for w in string.gmatch(l, ".") do
        table.insert(mapa[#mapa], w)
    end
end
PrintMapa(mapa)

--- busco las antenas:
local antenas = {}
for i=1,#mapa do                        --- eje y
    for j=1,#mapa[i] do                 --- eje x
        local ant = mapa[i][j]
        if  ant ~= '.' then
            if not antenas[ant] then
                antenas[ant] = {}
            end
            table.insert(antenas[ant], {y = i, x = j})
        end
    end
end

--- detecto anti-nodos:
for ant, pos in pairs(antenas) do
    print("Antena: "..ant)
    for m=1,#pos-1 do
        for n=m+1, #pos do
            local diff = Distancia(antenas[ant][m],antenas[ant][n])
            
            --- 1er anti-nodo
            local newx = antenas[ant][m].x - diff.x
            local newy = antenas[ant][m].y - diff.y
            if mapa[newy] then
                if mapa[newy][newx] then
                    mapa[newy][newx] = '#'
                end
            else
                --- esta fuera del mapa
            end

            --- 2do anti-nodo
            local newx = antenas[ant][n].x + diff.x
            local newy = antenas[ant][n].y + diff.y
            if mapa[newy] then
                if mapa[newy][newx] then
                    mapa[newy][newx] = '#'
                end
            else
                --- esta fuera del mapa
            end

            PrintMapa(mapa)                 --- debug
        end
    end
end
local result = 0
for i=1,#mapa do
    for j=1, #mapa[i] do
        if mapa[i][j] == '#' then
            result = result +1 
        end
    end
end

print("Solucion Parte 1 = "..result)   -- R: 426
