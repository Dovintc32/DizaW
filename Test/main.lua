function love.load()
    -- Получаем полную версию
    local major, minor, revision = love.getVersion(true)
    print(string.format("✅ Love2D Version: %d.%d.%d", major, minor, revision))

    -- Проверяем, доступен ли getInfo (должен быть с 11.3+)
    if love.graphics.getInfo then
        local info = love.graphics.getInfo()
        print("🎮 GPU: " .. (info.device or "Unknown"))
        print("🏭 Vendor: " .. (info.vendor or "Unknown"))
    else
        print("❌ graphics.getInfo() not available — update to 11.3+")
    end

    -- Опционально: путь к исполняемому файлу (чтобы убедиться, что запускаешь правильную версию)
    print("📂 Executable: " .. love.filesystem.getExecutablePath())
end