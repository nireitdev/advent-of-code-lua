--- Day 2 Part 1: Red-Nosed Reports ---

local filename = "d2.txt"
-- local filename = "test.txt"

-- Funciones
function IsSafe(levels) 
    local safe = true
    local last = math.mininteger
    local step = 0

    for i=1,#levels do
        local num = levels[i]

        if not( last == math.mininteger ) then
            local diff = num - last
            local delta = diff / math.abs(diff)
            if step == 0 then       -- primer diferencia
                step = delta
            end

            if not (delta == step) then
                safe = false
            end
            if math.abs(diff)>3 then
                safe = false
            end

        end

        last = num
    end
    
    return safe
end


--- Procesamiento
--- 
local result = 0

for l in  io.lines(filename) do
    
    local levels = {}
    for w in string.gmatch(l, "%d+") do
        levels[#levels+1]= tonumber(w)
    end

    if IsSafe(levels)  then
        result = result + 1 
    end
end

print("Solucion Parte 1 SAFE= "..result)   -- R: 356



