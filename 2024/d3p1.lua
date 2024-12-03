--- Day 3 Part 1: Mull It Over  ---

local filename = "d3.txt"
-- local filename = "test.txt"

local result = 0
for l in  io.lines(filename) do
    for a,b in string.gmatch(l, "mul%((%d+),(%d+)%)") do
        result = result + tonumber(a) * tonumber(b)
    end
end

print("Solucion Parte 1 = "..result)   -- R: 166630675
