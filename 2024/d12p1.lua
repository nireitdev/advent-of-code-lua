--- Day 12 Parte 2: Garden Groups ---

--- Del mapa de letras, lo llevo a una lista de letras separados por regiones.
--- Esto permite trabajar mas facil la deteccion de bordes o "perimetros"
--- El borde se detecta si no hay otra letra en los alrededores.
--- Multiplico el total de bordes perimetrales por area.

local filename = "d12.txt"
-- local filename = "test.txt"


local mapa = {}

local grafo = {}

--- Lectura del mapa
local idy = 1
for l in  io.lines(filename) do
    mapa[#mapa+1] = {}
    local idx = 1
    for d in string.gmatch(l,'(.)') do
        table.insert(mapa[#mapa], d)
        if not grafo[d] then grafo[d]={} end
        table.insert(grafo[d], {x = idx, y = idy, region = 0})
        idx=idx+1
    end
    idy=idy+1
end

--- Analisis del grafo para obtener todas las regiones:
local id_reg = 1
local regiones = {}
for key, vals in pairs(grafo) do
    for i=1,#vals do
        if vals[i].region == 0 then 
                --- Aux funcion:
                regiones[id_reg] = {}

                local function change_around(tmp,new_reg)     --- tmp={x,y,region}
                    if tmp.region == 0 then
                        tmp.region = new_reg
                        table.insert(regiones[new_reg],tmp)
                        for m=1,#vals do
                            if (vals[m].y == tmp.y-1) and (vals[m].x == tmp.x) then 
                                change_around(vals[m],new_reg)
                            end
                            if (vals[m].y == tmp.y+1) and (vals[m].x == tmp.x) then 
                                change_around(vals[m],new_reg)
                            end
                            if (vals[m].y == tmp.y) and (vals[m].x == tmp.x-1) then 
                                change_around(vals[m],new_reg)
                            end
                            if (vals[m].y == tmp.y) and (vals[m].x == tmp.x+1) then 
                                change_around(vals[m],new_reg)
                            end
                        end
                    end                    
                end

                change_around(vals[i],id_reg)
                id_reg = id_reg + 1
        end
    end
end

--- debug grafo:
for k,v in pairs(grafo) do          
    print(k)
    for i=1,#v do
        print(v[i].y..","..v[i].x.." reg:"..v[i].region)
    end
end

--- Calculo de areas y perimetros:
local result =0
for key, vals in pairs(regiones) do
    local areas,perimetros = 0,0
    
    for i=1,#vals do

        --- Aux funcion:
        local function sum_perim(tmp)     --- tmp={x,y,region}
            local t_per = 4
                for m=1,#vals do
                    if (vals[m].y == tmp.y-1) and (vals[m].x == tmp.x) then 
                        t_per=t_per-1
                    end
                    if (vals[m].y == tmp.y+1) and (vals[m].x == tmp.x) then 
                        t_per=t_per-1
                    end
                    if (vals[m].y == tmp.y) and (vals[m].x == tmp.x-1)  then 
                        t_per=t_per-1
                    end
                    if (vals[m].y == tmp.y) and (vals[m].x == tmp.x+1)  then 
                        t_per=t_per-1
                    end
                end
            return t_per                 
        end                

     
        perimetros = perimetros + sum_perim(vals[i])      
        areas = areas + 1

    end
    
    print(key.." area:"..areas.." perim:"..perimetros)
    result = result + areas * perimetros
end

print("Solucion Parte 1 = "..result)   -- R: 1467094
