--- Day 8 Part2: Resonant Collinearity ---

--- Cargo el mapa de "antenas" y luego creo un listado de antenas agrupadas por el nombre 
--- Calculo la distancia "geometrica" en el eje "x" y eje "y" => dX=x2-x1  dY=y2-y1
--- Luego aplico las diff X/Y haciendo la resta con el primer punto (mas al Norte) 
--- y la suma con el segundo punto (mas al Sur).
--- 
--- En la Parte 2 simplemente sigo duplicando los anti-nodos hacia el Norte y hacia el Sur
--- hasta que salga del mapa. Imporntate: cada Antena tambien es un anti-nodo => incluir en el total
--- 
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
function AntiNodo(mapa, pos_antena, diff, direction)            --- Direction = "N" o "S"
local out_map = false
    local lastp = { x = pos_antena.x , y = pos_antena.y}
    mapa[lastp.y][lastp.x] = '#'                    --- cada antena tambien es un antinodo
while not out_map do                                --- mientras no salga del mapa:
        local newx = lastp.x - diff.x
        local newy = lastp.y - diff.y
        if direction == "S" then
            newx = lastp.x + diff.x
            newy = lastp.y + diff.y            
        end
        if mapa[newy] then
            if mapa[newy][newx] then
                mapa[newy][newx] = '#'
                lastp = {x = newx, y=newy}
            else
                out_map = true
            end
        else
            out_map = true
        end
    end
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
            AntiNodo(mapa,antenas[ant][m],diff,'N')
            
            --- 2do anti-nodo
            AntiNodo(mapa,antenas[ant][n],diff,'S')
            
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

print("Solucion Parte 2 = "..result)   -- R: 1359
