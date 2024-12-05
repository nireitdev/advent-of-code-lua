--- Day 5 Part 2: Print Queue ---

--- Cargo las tablas "rules" con las reglas y la tabla "prints" con listas de hojas a imprimir
--- luego por cada **par** de hojas las concateno con "|", por ejemplo:  "75" y "47" => "75|47"
--- Entonces recorro todas las reglas buscando la coincidencia con "75|47". 

--- Si no encuentro la regla: hago un "swap" de elementos y vuelvo a escanear, hasta que todas las hojas sean correctas.

--- Si todo el orden es correcto busco el elemento del medio " math.floor(#prints[i] / 2 ) + 1" 
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
    local incorrectly_ordered = false

    --- por cada cambio reset:
    local retry = true
    while retry do   
        -- print(table.concat(prints[i],','))       --debug movimiento de incorrectos
        for j=2,#prints[i] do                       -- por cada par de hojas
            local found_rule = false            
            local to_find = prints[i][j-1] .. "|" .. prints[i][j]

            for k=1,#rules do                       -- busco la regla
                if to_find==rules[k] then
                    found_rule = true
                    retry = false
                end
            end

            if not found_rule then                  -- no encontre la regla
                local temp = prints[i][j]
                prints[i][j] = prints[i][j-1]
                prints[i][j-1] = temp
                incorrectly_ordered = true          -- detecto los incorrectos
                retry = true                        -- re-escaneo desde el inicio
                break            
            end
        end
         
    end

    if incorrectly_ordered then
        result = result + prints[i][ math.floor(#prints[i] / 2 ) + 1]
    end
    
end

print("Solucion Parte 2 = "..result)   -- R: 7380  
