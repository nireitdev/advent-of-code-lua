--- Day 3 Part 1: Mull It Over  ---

local filename = "d4.txt"
-- local filename = "test.txt"


--- Funciones

--- Aplica un kernel a un puzzle
function Procesamiento(kernels, puzzle)
    local count = 0

    for k=1,#kernels do             -- por cada kernel
        local krn_h, krn_w = #kernels[k], #kernels[k][1]
        local pzl_h, pzl_w = #puzzle, #puzzle[1]
        for i=1, pzl_h do           
            for j=1, pzl_w do
                local found = true
                for x=1, krn_w do
                    for y=1, krn_h do
                        if not (kernels[k][y][x] == ".") then
                            if ( j+y-1 <= pzl_h ) and ( i+x-1 <= pzl_w ) then
                                if not (puzzle[j+y-1][i+x-1] == kernels[k][y][x]) then
                                    found = false
                                end
                            else
                                found = false
                            end
                        end
                        if not found then break end
                    end
                    if not found then break end
                end
                if found then
                    --- print("pos[y][x] = "..j..","..i)  --- debug pos
                    count = count + 1
                end
            end
        end
    end

    return count
end

--- Resolucion
local puzzle = {}
for l in  io.lines(filename) do
    puzzle[#puzzle+1]={}
    for ch in string.gmatch(l, "%a") do
        puzzle[#puzzle][#puzzle[#puzzle]+1] = ch
    end
end

local kernels = { 
                 { {'M', '.','S'} , {'.', 'A','.'}, {'M', '.','S'} , } ,
                 { {'S', '.','M'} , {'.', 'A','.'}, {'S', '.','M'} , } ,
                 { {'S', '.','S'} , {'.', 'A','.'}, {'M', '.','M'} , } ,
                 { {'M', '.','M'} , {'.', 'A','.'}, {'S', '.','S'}   }
}

local result =  Procesamiento(kernels, puzzle)

print("Solucion XMAS Parte 1 = "..result)   -- R: 1871
