--- Day 7: Bridge Repair ---

--- De cada linea obtengo el valor y los numero para obtener de las ecuacioens
--- La cantidad de operaciones por ecuacion es el 2^(cant numeros - 1), Ej: 3 numeros => 2^2 = 4 ecuaciones
--- De cada ecuacion cuyo valor sea igual al indice de la ecuacion => found = true  , 
---     solo me interesa un solo "found" y por tanto hago un "break" para no calcular por demas
--- Sumo todos los valores que haya encontrado la ecuacion que resuelva el problema
--- Utilizo un sistema binario (mask bit) para aplicar cada operacion 0=>"+"  y 1=>"*"

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
        for i = 0,  2^(#value-1)-1 do   -- cantidad iteraciones = 2 ^ (total operaciones - 1), 0-based => -1
            local eval = tonumber(value[1])
            -- local str = " " .. value[1]
            for k=0,#value - 2 do
                if ( i >> k & 1 )==0 then  -- check mask bit 
                    eval = eval + tonumber(value[k+2])
                    -- str = str .. " + "..value[k+2]       -- debug operaciones
                else
                    eval = eval * tonumber(value[k+2])
                    -- str = str .. " * "..value[k+2]       -- debug operaciones
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

print("Solucion Parte 1 = "..result)   -- R: 2664460013123
