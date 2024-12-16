--- Day 12 Parte 1: Garden Groups ---

--- Del mapa de letras, lo llevo a una lista de letras separados por regiones.
--- Esto permite trabajar mas facil la deteccion de bordes o "perimetros"
--- Genero un mapa con los bordes (horizontales y verticales), teniendo en cuanta 
--- la orientacion "facing" de lado que miran. Es importante para diferenciar los huecos internos de las regiones.
--- Si miran hacia arriba o para adentro entonces: "-1", en caso contrario entonces "1"
--- Utilizando el mapa de bordes detecto las lineas que son continuas y que tengan la misma orientacion
--- Multiplico el total de bordes perimetrales por area.


local filename = "d12.txt"
-- local filename = "test.txt"



local grafo = {}
--- Lectura del mapa
local idy = 1
for l in  io.lines(filename) do
    local idx = 1
    for d in string.gmatch(l,'(.)') do
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

-- --- debug grafo:
-- for k,v in pairs(grafo) do          
--     print(k)
--     for i=1,#v do
--         print(v[i].y..","..v[i].x.." reg:"..v[i].region)
--     end
-- end

--- 
local result =0
for key, vals in pairs(regiones) do
    local map_horz, map_vert = {},{}
        
    for i=1,#vals do
        
        --- Aux funcion: encuentra los bordes o "sides" Hor y Ver
        local function detect_sides(tmp)     --- tmp={x,y}
            local n,s,e,o = false,false,false,false
            for m=1,#vals do
                    if (vals[m].y == tmp.y-1) and (vals[m].x == tmp.x) then n=true end
                    if (vals[m].y == tmp.y+1) and (vals[m].x == tmp.x) then s=true end 
                    if (vals[m].y == tmp.y) and (vals[m].x == tmp.x-1) then e=true end
                    if (vals[m].y == tmp.y) and (vals[m].x == tmp.x+1) then o=true end
            end                
            if not n then table.insert(map_horz, { x=tmp.x, y=tmp.y * -1 }) end     --- -1 facing N
            if not s then table.insert(map_horz, { x=tmp.x, y=tmp.y *  1 }) end     ---  1 facing S
            if not e then table.insert(map_vert, { x=tmp.x * -1, y=tmp.y }) end     --- -1 facing E
            if not o then table.insert(map_vert, { x=tmp.x *  1, y=tmp.y }) end     ---  1 facing O
            
        end

        detect_sides(vals[i])
    end

    -- --- Debug
    -- print("Reg: "..key)
    -- for k,v in ipairs(map_horz) do
    --     print("hor:"..v.y..","..v.x)
    -- end
    -- for k,v in ipairs(map_vert) do
    --     print("ver:"..v.y..","..v.x)
    -- end

    local perim_horz=0
    local perim_vert=0
    do
        local function recorrer_hrz(tmp)        ---tmp={x,y}
            for k,v in ipairs(map_horz) do
                if (v.x == tmp.x) and (v.y == tmp.y) then
                    table.remove(map_horz,k)  
                    -- print("dh:"..v.y..","..v.x)      --debug
                    recorrer_hrz({x=tmp.x-1, y=tmp.y})
                    recorrer_hrz({x=tmp.x+1, y=tmp.y})
                    break
                end
            end
        end
        local function recorrer_vert(tmp)        ---tmp={x,y}
            for k,v in ipairs(map_vert) do
                if (v.x == tmp.x) and (v.y == tmp.y) then
                    table.remove(map_vert,k)   
                    -- print("vh:"..v.y..","..v.x)      --debug
                    recorrer_vert({x=tmp.x, y=tmp.y-1})
                    recorrer_vert({x=tmp.x, y=tmp.y+1})
                    break
                end
            end
        end

        while #map_horz>0 do
            perim_horz = perim_horz + 1
            -- print("per hz:"..perim_horz)
            recorrer_hrz(map_horz[1])    
        end
        while #map_vert>0 do
            perim_vert = perim_vert + 1
            -- print("per ver:"..perim_vert)
            recorrer_vert(map_vert[1])    
        end
    end

    -- --debug
    -- print("horz lines:"..perim_horz)        
    -- print("vert lines:"..perim_vert)
    result = result + (perim_horz + perim_vert) * #vals
end

print("Solucion Parte 2 = "..result)   -- R: 881182
