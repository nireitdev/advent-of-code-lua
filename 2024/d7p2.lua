--- Day 7 Parte 2: Bridge Repair ---

--- De cada linea obtengo el valor y los numero para obtener de las ecuacioens
--- La cantidad de operaciones por ecuacion es el 2^(cant numeros - 1), Ej: 3 numeros => 2^2 = 4 ecuaciones
--- De cada ecuacion cuyo valor sea igual al indice de la ecuacion => found = true  , 
---     solo me interesa un solo "found" y por tanto hago un "break" para no calcular más
--- Sumo todos los valores que haya encontrado la ecuacion que resuelva el problema
--- 
--- En este caso utilizo un sistema "ternario" para almacenar cada cambio de estado
--- 0=>'+'   1=> '*'  2=> '||'  3=> overflow y sumo "1" al siguiente "bit"

local filename = "d7.txt"
-- local filename = "test.txt"

local result = 0
for l in  io.lines(filename) do
    local index, opers = string.match(l,"(%d+): (.+)")
    if index then 
        local value = {} 
        for op in string.gmatch(opers, "%d+") do
            table.insert(value,op)
        end
        -- print(index.."=>"..table.concat(value,','))
        
        --- Procesamiento por cada ecuacion:
        local found = false
        local states = {}
        for j = 1,#value-1 do
            states[j] = 0
        end
        for i = 0,  3^(#value-1)-1 do                       -- cantidad iteraciones = 3 ^ (total operaciones - 1), 0-based => -1
            local eval = tonumber(value[1])
            -- local str = " " .. value[1]

            for k=1,#value-1 do
                if states[k] == 3 then                      -- overflow en sistema 3-ternario
                    states[k] = 0 
                    if states[k+1] then 
                        states[k+1] = states[k+1] + 1
                    end
                end

                if states[k] == 0 then
                    eval = eval + tonumber(value[k+1])
                    -- str = str .. " + "..value[k+1]       -- debug operaciones
                end
                if states[k] == 1 then
                    eval = eval * tonumber(value[k+1])
                    -- str = str .. " * "..value[k+1]       -- debug operaciones
                end
                if states[k] == 2 then
                    eval = tonumber( tostring(eval) .. tostring(value[k+1]))
                    -- str = str..'|'..value[k+1]           -- debug operaciones
                end

                states[k] = states[k] + 1
                if states[k] == 3 then                      -- overflow en sistema 3-ternario
                    states[k] = 0 
                    if states[k+1] then 
                        states[k+1] = states[k+1] + 1
                    end
                end
    
            end
            -- print(str)                                   -- debug operaciones
            if tonumber(index) == eval then 
                found = true 
                break  -- quit 
            end
        end 
        if found then result = result + tonumber(index) end
    end 
end

print("Solucion Parte 2 = "..result)   -- R: 426214131924213
