--- Day 13 Part2  : Claw Contraption ---

--- Sistema de ecuaciones de 2 incogitas:
---     ax*A + bx * B = prcx
---     ay*A + by * B = prcy
---     ax*A = prcx - bx * B = prcx - bx*( (prcy-ay*A)/by )
---     ax*A = prcx - bx * prcy / by + bx * ay*A/by
---     ax * A - bx * ay * A / by = prcx - bx*prcy/by
---     A * ( ax - bx * ay / by) = prcx - bx*prcy/by
---     A = ( prcx - bx * prcy / by ) / (ax - bx * ay / by)
---     A = ( prcx * by - prcy * bx) / (ax * by - bx*ay)
--- 
---     B = ( prcx - ax * A ) / bx
---     B = (ax * prcy - ay*prcx) / (ax*by - ay*bx)
--- 
--- Importante: las soluciones tienen que ser numero enteros porque lo dice el problema, 
---         es decir flotantes sin decimales. Ej: 80.0  y NO 80.1123
local filename = "d13.txt"
-- local filename = "test.txt"


local machines = {}
local cost = {A=3, B=1}
local big =  10000000000000

local count = 1
for l in  io.lines(filename) do
        if machines[count] == nil then
            machines[count] = {}
        end

        local btn,tx,ty = string.match(l,"Button (.): X(.+), Y(.+)")         
        if btn and tx and ty then 
            machines[count][btn] = {x=tonumber(tx), y=tonumber(ty)}
        end
        local prcX,prcY = string.match(l,"Prize: X=(.+), Y=(.+)") 
        if prcX and prcY then 
            machines[count].price = {x=big + tonumber(prcX), y=big + tonumber(prcY)}
            count = count + 1
        end        
end

local result = 0
for i=1,#machines do
    local mach = machines[i]
    if mach.A ~= nil and mach.B ~=nil then
        local ax,ay = mach.A.x,mach.A.y
        local bx,by = mach.B.x,mach.B.y
        local prcx,prcy = mach.price.x, mach.price.y

        local A = ( prcx * by - prcy * bx) / (ax * by - bx*ay)
        local B = (ax * prcy - ay*prcx) / (ax*by - ay*bx)
        
        if (  A == math.floor(A) ) and (  B == math.floor(B))   then
            print("Machine "..i..": count A:"..A .." count B:"..B)      --debug
            result = result + math.floor(A) * cost.A + math.floor(B)*cost.B            
        else
            -- print("Machine "..i.." sin soluciones")            
        end
        
    end
end


print("Solucion Parte 2 = "..result)   -- R: 104015411578548