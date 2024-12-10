--- Day 9 Part 2: Disk Fragmenter ---

--- En este caso guardo en dos listas separadas los "free-space" y los bloques con datos
--- Por cada "free" o "block" guardo el indice, posicion actual y tamaño
--- El procesamiento consiste en iterar por cada "block" desde el ultimo bloqeu en la tabla
--- y ver si encuentro algun espacio lo suficientemnete grande. Si es asi, cambio posiciones 
--- cambio el tamaño del espacio.

--- Esta version es mas rapida que la version "d9p2.lua".

--- 
local filename = "d9.txt"
-- local filename = "test.txt"

local MARK_FREE = '.'

local diskmap = {}
local expanddisk = {}

local k = 0
local st_pos = 0
local blocks,free = {},{}
for l in  io.lines(filename) do
    local is_freespace = false
    for d in string.gmatch(l,"(%d)") do
        local size = tonumber(d)
        if is_freespace then
                free[#free+1] = { idx = k , size = size, pos = st_pos }
        else
            blocks[#blocks+1] = { idx = k, size = size, pos = st_pos}        
            k = k + 1
        end
        st_pos = st_pos + size
        is_freespace = not is_freespace
    end
end


--- Mover bloques (defrag):
for idx_blk = #blocks , 1 , -1 do
    for idx_free = 1,#free do
        --- La ubicacion del free-space debe ser menor al del bloque a mover:
        if free[idx_free].pos < blocks[idx_blk].pos then
            --- el tamaño free-space debe ser >= al del bloque a mover
            if free[idx_free].size >= blocks[idx_blk].size then
                blocks[idx_blk].pos = free[idx_free].pos
                free[idx_free].pos = free[idx_free].pos + blocks[idx_blk].size
                free[idx_free].size = free[idx_free].size - blocks[idx_blk].size
                break   --- encontrado y movido!
            end
        end
    end
end

--- Calculo total
local result = 0
for i=1,#blocks do 
    local sum = 0
    for k=0,blocks[i].size-1 do
        result = result + blocks[i].idx *  ( blocks[i].pos + k)
    end
end

print("Solucion Parte 2 = "..result)   -- R: 64232583769826423258376982

