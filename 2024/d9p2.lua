--- Day 9 Part 2: Disk Fragmenter ---

--- Uso doble vector: uno para los "free" y otro para los datos
--- y hago swapping entre los dos.
--- En este caso MUEVO TODO EL BLOQUE. 

--- Esta version es mas lenta que la version "d9p2-v2.lua" pero mas visual/grafica del movimiento

--- 
local filename = "d9.txt"
-- local filename = "test.txt"

local MARK_FREE = '.'

local diskmap = {}
local expanddisk = {}

local idx = 0
for l in  io.lines(filename) do
    local is_freespace = false
    for s in string.gmatch(l,"%d") do
        local block = MARK_FREE
        if not is_freespace then 
            block = idx
            idx = idx + 1
        end

        for i=1,s do 
            expanddisk[#expanddisk+1] = block
        end

        is_freespace = not is_freespace
    end
end

--- Mover bloques (defrag)
local ptr_block = #expanddisk
local stop = false
for k=idx, 0, -1 do
    -- print(table.concat(expanddisk,','))         --debug
    
    --- busco el ultimo bloque a mover:
    while expanddisk[ptr_block] == MARK_FREE do
        ptr_block = ptr_block - 1
    end
    local idx = expanddisk[ptr_block]
    --- tamaño total:
    local count_blq = 0
    while expanddisk[ptr_block] == idx do
        count_blq = count_blq + 1
        ptr_block = ptr_block - 1
        if ptr_block == 0 then
            break
        end
    end


    ---busco primer free que contenga el tamaño count_blq
    local stop_free = false
    local ptr_free = 0
    while not stop_free do

        while expanddisk[ptr_free] ~= MARK_FREE do
            ptr_free = ptr_free + 1
            if ptr_free == #expanddisk then
                stop_free = true
                break
            end
        end
        --- tamaño total free:
        local count_free = 0 
        while (not stop_free) and (expanddisk[ptr_free + count_free] == MARK_FREE) do
            count_free = count_free + 1
            if ptr_free + count_free == #expanddisk then
                stop_free = true
            end            
        end

        --- La ubicacion del free-space debe ser menor al del bloque a mover:
        if ptr_free > ptr_block then
            stop_free = true
        else
            if count_free >= count_blq then
                for i=1,count_blq do
                    expanddisk[ptr_free] = idx
                    expanddisk[(ptr_block + 1) + count_blq - i ] = MARK_FREE
                    ptr_free = ptr_free + 1
                end
                stop_free = true
            else
                ptr_free = ptr_free + 1
            end
        end
    end

end

local result = 0
for i=0,#expanddisk-1 do
    if expanddisk[i+1] ~= MARK_FREE then
        result = result + i * expanddisk[i+1]
    end
end
print("Solucion Parte 2 = "..result)   -- R: 6423258376982
