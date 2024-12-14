--- Day 11 Parte 2: Plutonian Pebbles ---

--- La fuerza bruta de la Parte1 tarda dias y consume mucha memoria y CPU
--- Parte 2: se cachea dos cosas: 
---     1 - las operaciones (0->1, split() , *2024)
---     2 - los valores de cada iteracion repetidos => iter 6 = {2024:2, 48:2, 49:1, etc}
--- El agiliza y ahora mucha memoria/cpu en calculos repetidos.

local filename = "d11.txt"
-- local filename = "test.txt"


local stones = {}         
local cached = {}         
for l in  io.lines(filename) do
    for d in string.gmatch(l,'(%d+)') do
        stones[tonumber(d)] = 1        
    end
end

for k,v in pairs(stones) do
    print("k:"..k.." v:"..v)
end

for k=1,75  do
    local next_stones = {}
    for st, count_st in pairs(stones) do

        --- no existe en el cache:
        if not cached[st] then
            local temp = {}
            --- Reglas:
            if st == 0 then
                temp[#temp+1] = 1
            else if string.len(tostring(st)) %2 == 0 then
                    local ss = tostring(st)
                    local st1 = string.sub(ss,1,#ss//2 )
                    local st2 = string.sub(ss,#ss//2+1,#ss)
                    temp[#temp+1] = tonumber(st1)
                    temp[#temp+1] = tonumber(st2)
                else 
                    temp[#temp+1] = st * 2024
                end 
                    
            end
            cached[st] = temp       --- lo agrego al cache
        end

        --- busco en el cache:
        for _,v in ipairs(cached[st]) do
            if next_stones[v] then
                next_stones[v] = next_stones[v] + count_st
            else
                next_stones[v] = count_st       --- cuenta de iteraciones anteriores
            end
        end
    end 
    stones = next_stones
end

local result = 0
--- Resultado ultima iteracion:
for k,v in pairs(stones) do
    print("key: "..k.." rep.count="..v)
    result = result + v
end
print()
print("Solucion Parte 2 = "..result)   -- R: 277444936413293
