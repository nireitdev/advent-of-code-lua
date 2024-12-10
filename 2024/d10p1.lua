--- Day 10 Parte 1: Hoof It ---
--- 
--- Teniendo el "mapa", se inicia por cada "0" hasta llegar a un "9".
--- La funcion "paths" recorre punto a punto. 
--- Si hay bifurcaciones (mismo valor en varios posiciones) hago recursivo
--- Una vez que llego al "9" entonces grabo por **unica vez** el ascenso al mismo "9"
--- En la parte 2 me interesa TODOS los accesos al "9"

local filename = "d10.txt"
-- local filename = "test.txt"



local mapa = {}         --- mapa general
local pos_num0={}       --- posiciones de "0"
local pos_num9={}       --- posiciones de "9"
for l in  io.lines(filename) do
    mapa[#mapa+1] = {}
    for d in string.gmatch(l,'(.)') do
        if d == '.' then
            table.insert(mapa[#mapa], -1 )
        else
            table.insert(mapa[#mapa], tonumber(d) )
        end
        if d=="0" then
            pos_num0[#pos_num0+1] = { y=#mapa, x = #mapa[#mapa], sum = 0, trails = {}}
        end
        if d=="9" then
            pos_num9[#pos_num9+1] = { y=#mapa, x = #mapa[#mapa], sum = 0}
        end
    end
end

local paths = {}
do
    --- busco el siguiente valor en ascenso
    --- si hay dos o mas formas diferntes de ascender hago recursion 
    local function paths(pos,origin0)   --- pos={x,y}
        -- print(mapa[pos.y][pos.x]..": ".."("..pos.y..","..pos.x..")")    --- para debug de cada camino 
        local valor = mapa[pos.y][pos.x] + 1
        if valor == 10 then
            --- Unicos accesos al numero "9":
            if not pos_num0[origin0].trails[pos.y+pos.x*10000] then 
                pos_num0[origin0].trails[pos.y+pos.x*10000] = 1
                pos_num0[origin0].sum = pos_num0[origin0].sum + 1
            end
            return      --fin de esta bifurcacion
        end
        if ( pos.y - 1 >0 )     and (mapa[pos.y-1][pos.x] == valor) then paths( {y=pos.y-1,x=pos.x },origin0) end
        if ( pos.y + 1 <=#mapa) and (mapa[pos.y+1][pos.x] == valor) then paths( {y=pos.y+1,x=pos.x },origin0) end
        if ( pos.x - 1 >0 )     and (mapa[pos.y][pos.x-1] == valor) then paths( {y=pos.y,x=pos.x-1 },origin0) end
        if ( pos.x + 1 <=#mapa[1]) and (mapa[pos.y][pos.x+1] == valor) then paths( {y=pos.y,x=pos.x+1 },origin0) end
        return          --no es un camino valido
    end

    --- Por cada "0" hago el inicio del "paths()"
    for k=1,#pos_num0 do
        -- print("0: ".."("..pos_num0[k].y..","..pos_num0[k].x..")")    ---debug
        local res = paths( {y = pos_num0[k].y, x=pos_num0[k].x}, k)
    end
end

local result = 0
for k=1,#pos_num0 do

    -- print("y:"..pos_num0[k].y.." x:"..pos_num0[k].x.." sum="..pos_num0[k].sum)
    result = result + pos_num0[k].sum    
end

print("Solucion Parte 1 = "..result)   -- R: 688
