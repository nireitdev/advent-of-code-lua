--- Day 3 Part 2: Mull It Over  ---

local filename = "d3.txt"
-- local filename = "test.txt"

local result = 0

local linea = ""
for l in  io.lines(filename) do
    linea = linea .. l          --- hay que unir las lineas primero, pero que hdp!!
end    

local pos = 1               --- siempre inicia en Do
local last_dont = 99999999 

while pos do
    --- Dont's():
    local x = string.find(linea,"don't()", pos,true)
    if x then last_dont = x
            else last_dont = 99999999
    end

    --- Mul()        
    while pos < last_dont do
        local y = string.find(linea,"mul%((%d+),(%d+)%)", pos) 
        if y and y < last_dont then
            local a,b = string.match(linea,"mul%((%d+),(%d+)%)", y)  
            result = result + tonumber(a) * tonumber(b)
            pos = y + 1 
        else 
            break
        end
    end
    --- Do()
    local z = string.find(linea,"do()", pos,true)
    if z then pos = z + 1
            else pos = nil 
    end

end

print("Solucion Parte 2 = "..result)   -- R: 93465710
                                       