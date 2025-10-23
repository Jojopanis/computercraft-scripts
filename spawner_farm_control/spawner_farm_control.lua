local screen = peripheral.find('monitor')
term.redirect(screen)

local spawner_list = {
    {'cav_creeper',54},
}

local function draw_button(x,y,color,message,sizeX,sizeY)
    sizeX = sizeX or 7
    sizeY = sizeY or 2
    message = message or "rieeen"
    color = color or colors.red
    paintutils.drawFilledBox(x,y,x+sizeX,y+sizeY,color)
    term.setCursorPos(x+1,y+1)
    term.setTextColor(colors.black)
    write(string.sub(message,1,6))
end

local function draw_menu()
    paintutils.drawLine(61,1,61,26,colors.gray)
    draw_button(menu_map[1].x,menu_map[1].y,colors.gray, " Menu")
end

local function init_buttons(map,list)
    for i,spawner in ipairs(list) do
        draw_button(map[i].x, map[i].y, nil, spawner[1])
    end
end

term.setBackgroundColor(colors.black)
term.clear()
term.setTextColor(colors.white)

local button_map = {}
for i=2,52,10 do
    for j=2,22,4 do
        table.insert(button_map,{x=i,y=j})
    end
end

local menu_map = {}
for i= 2,22,4 do
    table.insert(menu_map, {x=63, y=i})
end

--for i,button in ipairs(button_map) do
--    draw_button(button.x,button.y)
--end

init_buttons(button_map,spawner_list)
draw_menu()

while true do
    local event,side,x,y = os.pullEvent("monitor_touch")
    for i,button in ipairs(button_map) do
        if x >= button.x and x <= button.x+7 and y >= button.y and y <= button.y+2 then
            draw_button(button.x,button.y,colors.green)
        end
    end
end
