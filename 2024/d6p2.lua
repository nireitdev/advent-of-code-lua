--- Day 6 Parte 2: Guard Gallivant ---

--- Fuerza bruto: simulo un blocker pixel a pixel.
--- No detecto loops, solo cuento cuantas veces itera dentro del
--- mapa y supongo que es un "loop". Cant iteraciones  = 200

--- las funciones de recorrido son simetricas asi que seguro se pueden
--- optimizar

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
local result = 0

for i=1,#Mapa do
    for j=1,#Mapa[i] do
        
        if  (Mapa[i][j] ~= '#') and (Mapa[i][j] ~= '^') then
            
            Mapa[i][j] = '#'  --- nuevo blocker
            -- PrintMapa()
            
            Pos = { x = start.x, y = start.y }
            
            local loop = 1
            while Pos do
                GoTop()
                GoRight()
                GoBott()
                GoLeft()
                loop=loop + 1
                if loop>200 then   --- 200 "magic number" para suponer loop
                    Pos = nil
                    result = result + 1
                end
            end
            Mapa[i][j] = '.'  --- reset  blocker
        end
                
    end
end

print("Solucion Parte 2 = "..result)   -- R: 2188
