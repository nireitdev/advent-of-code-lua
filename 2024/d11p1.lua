--- Day 11 Parte 1: Plutonian Pebbles ---

--- Simple fuerza bruta.
--- Que seguramente NO va a funcionar en la parte 2!!

local filename = "d11.txt"
-- local filename = "test.txt"


local stones = {}         
for l in  io.lines(filename) do
    for d in string.gmatch(l,'(%d+)') do
        stones[#stones+1] = tonumber(d)
    end
end

for k=1,25 do
    print("iter= ",k, " size=",#stones)
    local i = 1
    while i <= #stones do
        local st = stones[i]
        --- Reglas:
        if st == 0 then
            stones[i] = 1
        else if string.len(tostring(st)) %2 == 0 then
            local ss = tostring(st)
            local st1 = string.sub(ss,1,#ss//2 )
            local st2 = string.sub(ss,#ss//2+1,#ss)
            stones[i] = tonumber(st1)
            table.insert(stones,i+1,tonumber(st2))
            i=i+1
        else 
            stones[i] = st * 2024
        end
        
    end 
    i = i + 1
end
-- print(table.concat(stones,","))
end

local result = 0
result = #stones

print("Solucion Parte 1 = "..result)   -- R: 233875
