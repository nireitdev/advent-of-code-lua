--- Day 9: Disk Fragmenter ---
--- Uso doble vector: uno para los "free" y otro para los datos
--- y hago swapping entre los dos.

--- 
local filename = "d9.txt"
-- local filename = "test.txt"

local MARK_FREE = '.'

local diskmap = {}
local expanddisk = {}

for l in  io.lines(filename) do
    local idx = 0
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
local ptr_free,ptr_block = 0, #expanddisk
local stop = false
while not stop do 
    -- print(table.concat(expanddisk,","))         --debug

    ---busco primer free
    while (not stop) and (expanddisk[ptr_free] ~= MARK_FREE) do
        ptr_free = ptr_free + 1
    end

    ---busco ultimo block 
    while (not stop) and (expanddisk[ptr_block] == MARK_FREE) do
        ptr_block = ptr_block - 1
    end

    --- condicion de parada:
    if ptr_free > ptr_block then
        stop = true
    end

    if not stop then
        expanddisk[ptr_free] = expanddisk[ptr_block]
        expanddisk[ptr_block] = MARK_FREE
    end

end

local result = 0
for i=0,#expanddisk-1 do
    if expanddisk[i+1] ~= MARK_FREE then
        result = result + i * expanddisk[i+1]
    end
end
print("Solucion Parte 1 = "..result)   -- R: 6386640365805
