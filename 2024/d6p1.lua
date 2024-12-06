--- Day 6: Guard Gallivant ---

--- Solo recorro en las cuatros sentidos el mapa
--- 
--- las funciones de recorrido son simetricas asi que seguro se pueden
--- optimizar
--- 
--- 
local filename = "d6.txt"
-- local filename = "test.txt"

Mapa = {}
Pos = {x = 0, y = 0} --- siempre "facing north"

function GoTop()
    if Pos then
       for y = Pos.y, 0, -1 do
            if y == 0 then
                Pos = nil
                break
            end
            if  Mapa[y][Pos.x] ~= '#' then
                Mapa[y][Pos.x] = 'X'                
                Pos.y = y
            else
                break
            end
       end 
    end
end

function GoRight()
    if Pos then
       for x = Pos.x, 9999999 do
            if x > #Mapa[1] then
                Pos = nil
                break
            end
            if  Mapa[Pos.y][x] ~= '#' then
                Mapa[Pos.y][x] = 'X'                
                Pos.x = x
            else
                break                
            end
       end 
    end
end


function GoBott()
    if Pos then
       for y = Pos.y, 9999999 do
            if y > #Mapa  then
                Pos = nil
                break
            end
            if  Mapa[y][Pos.x] ~= '#' then
                Mapa[y][Pos.x] = 'X'                
                Pos.y = y
            else
                break                
            end
       end 
    end
end

function GoLeft()
    if Pos then
       for x = Pos.x, 0, -1 do
            if x == 0 then
                Pos = nil
                break
            end
            if  Mapa[Pos.y][x] ~= '#' then
                Mapa[Pos.y][x] = 'X'                
                Pos.x = x
            else
                break                
            end
       end 
    end
end



function PrintMapa() 
    print()
    for i=1,#Mapa do
        print(table.concat(Mapa[i]))
    end

end

local start = { x= 0, y=0}
for l in  io.lines(filename) do
    Mapa[#Mapa+1] = {}
    for w in string.gmatch(l, "%g") do
        Mapa[#Mapa][#Mapa[#Mapa]+1] = w
        if w=='^' then
            start.x = #Mapa[#Mapa]
            start.y = #Mapa
        end
    end
    
end

--- Procesamiento:
Pos.x, Pos.y = start.x,start.y

while Pos do
    GoTop()
    GoRight()
    GoBott()
    GoLeft()
end
PrintMapa()

local result = 0
for i=1,#Mapa do
    for j=1,#Mapa[i] do
        if Mapa[i][j] == 'X' then 
            result = result + 1
        end
    end
end

print("Solucion Parte 1 = "..result)   -- R: 5453
