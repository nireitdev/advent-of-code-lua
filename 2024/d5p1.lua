--- Day 5 Part 1: Print Queue ---

--- Cargo las tablas "rules" con las reglas y la tabla "prints" con listas de hojas a imprimir
--- luego por cada **par** de hojas las concateno con "|", por ejemplo:  "75" y "47" => "75|47"
--- Entonces recorro todas las reglas buscando la coincidencia con "75|47". 
--- Si todo el orden para imprimir es correcto busco el elemento del medio " math.floor(#prints[i] / 2 ) + 1" 
--- y lo sumo al total.

local filename = "d5.txt"
-- local filename = "test.txt"


local rules = {}
local prints = {}
for l in  io.lines(filename) do
    -- for a,b in string.gmatch(l, "(%d+)|(%d+)") do
    if string.find(l,'|') then
        for w in string.gmatch(l, "%d+|%d+") do
            rules[#rules+1] = w
        end
    end
    if string.find(l,',') then
        prints[#prints+1] = {}
        for w in string.gmatch(l, "(%d+)") do
            prints[#prints][#prints[#prints]+1] = w
        end    
    end
end

--- Procesamiento:
local result = 0

for i=1,#prints do
    local correct = true
    for j=2,#prints[i] do                                                   --- por cada par de hojas
    
        local to_find = prints[i][j-1] .. "|" .. prints[i][j]               --- armo el string a buscar
        local found_rule = false
        for k=1,#rules do
            if to_find==rules[k] then
                found_rule = true                                           --- enctre la regla
            end
        end
        if not found_rule then correct = false end

    end

    if correct then
        -- print(table.unpack(prints[i]))  --debug correct        
        result = result + prints[i][ math.floor(#prints[i] / 2 ) + 1]
    end
    
end

print("Solucion Parte 1 = "..result)   -- R: 5108
