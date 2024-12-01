--- Day 1 Part 1: Historian Hysteria ---

local filename = "d1p1.txt"
--local filename = "test.txt"


local izq = {}
local der = {}
for l in  io.lines(filename) do
    local i, d = string.match(l,"(.+) (.+)")
    table.insert(izq,i)
    table.insert(der,d)
end

table.sort(izq)
table.sort(der)

local dist=0
for i=1,#izq do
    dist = dist + math.abs(izq[i]-der[i])
end

print("Solucion Total Distancia= "..dist)   -- R: 1151792