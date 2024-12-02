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
    
    local safe = IsSafe(levels)
    if not safe then
        -- voy probando borrar uno a uno cada elemento y 
        -- pruebo si es "safe"
        for i=1,#levels do
            local level_retry = {}
            for k=1,#levels do
                if not (k == i) then
                    level_retry[#level_retry+1] = levels[k]
                end
            end
            safe = IsSafe(level_retry)
            if safe then                
                break
            end
        end
    end

    if safe  then
        result = result + 1 
    end
end

print("Solucion Parte 2 Total SAFE= "..result)   -- R: 413



