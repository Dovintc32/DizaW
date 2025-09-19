local M = {}

function M.ind(text, i, j) 
    return string.sub(text, i, j)
end

function M.ChangeFont(Size, Font)
    Font = Font or "Font/FREEDOM/Freedom-10eM.ttf"
    customFont = love.graphics.newFont(Font, Size)
    love.graphics.setFont(customFont)
end

function M.FindCenter(text, y)
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    local x = love.graphics.getWidth() / 2 - textWidth / 2  
    return text, x, y
end

function M.ind(text, i, j) 
    return string.sub(text, i, j)
end

return M