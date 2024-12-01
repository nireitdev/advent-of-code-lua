--- Day 1 Part 2: Historian Hysteria ---

local filename = "d1p1.txt"
--local filename = "test.txt"

local izq = {}
local der = {}
for l in  io.lines(filename) do
    local i, d = string.match(l,"(.+) (.+)")
    i = tonumber(i)
    d = tonumber(d)
    table.insert(izq, i )
    -- creo un "set" o "hashset"
    if not der[d] then
        der[d] = 0
    end
    der[d] = der[d] + 1

end

table.sort(izq) -- no es necesario
--table.sort(der)

local dist=0
for i=1,#izq do
    local number = izq[i]    
    local mult = 0
    if der[number] then
        mult = der[number]
    end

    --print(number .. " : " .. mult .. " veces")
    dist = dist + math.abs(izq[i] * mult)

end

print("Solucion Total Distancia= "..dist)   -- R: 21790168