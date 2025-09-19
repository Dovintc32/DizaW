local json = require "dkjson"

function ind(text, i, j) 
    return string.sub(text, i, j)
end

-- Читаем файл через io.open (чистый Lua)
local file = io.open("World.json", "r")
local fileContent
if file then
    fileContent = file:read("*all")
    file:close()
else
    print("World.json не найден!")
end

-- Декодируем JSON или создаём пустой мир
local World
if fileContent then
    local success, decoded = pcall(json.decode, fileContent)
    if success then
        World = decoded
    else
        print("Ошибка при разборе JSON:", decoded)
        World = {}
    end
else
    World = {}
end

-- Перебираем мир и выводим ключи
for Ykey, row in pairs(World) do
    if type(row) == "table" then  -- защита от не-таблиц
        for Xkey, value in pairs(row) do  -- исправлено: row → value
            y = string.find(Ykey, "y")
            x = string.find(Ykey, "x")
            print(tonumber(ind(Ykey, 2, #Ykey)), tonumber(ind(Xkey, 2, #Xkey)), value)
        end 
    end
end
s = "Text"



print(ind("TexT", 1, 3))

local s = "Hello"
local startPos = string.find(s, "e")
print(startPos)