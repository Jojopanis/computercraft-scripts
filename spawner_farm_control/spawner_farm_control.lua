local screen = peripheral.find('monitor')
term.redirect(screen)

--Variable Definition
local spawner_list = {
    {label = 'cav_creeper',relay_id = 54},
    {label = 'witch',relay_id = 73},
}
local menu_list = {
    {label = ' Menu'}
}
local menu_map = {}
local button_map = {}

--Function Definition
local function draw_button(x,y,color,message,sizeX,sizeY)
    sizeX = sizeX or 7
    sizeY = sizeY or 2
    message = message or "......"
    color = color or colors.red
    paintutils.drawFilledBox(x,y,x+sizeX,y+sizeY,color)
    term.setCursorPos(x+1,y+1)
    term.setTextColor(colors.black)
    write(string.sub(message,1,6))
end
local function draw_button2(button,item,is_menu)
    x = button.x
    y = button.y
    sizeX = 7
    sizeY = 2
    message = item.label or "......"
    color = colors.gray
    if is_menu == false then
        if button.state == false then
            color = colors.red
        else
            color = colors.green
        end
    end
    paintutils.drawFilledBox(x,y,x+sizeX,y+sizeY,color)
    term.setCursorPos(x+1,y+1)
    term.setTextColor(colors.black)
    write(string.sub(message,1,6))
end

local function init_buttons(map,list,is_menu)
    color = color or colors.cyan
    for i,item in ipairs(list) do
        --draw_button(map[i].x, map[i].y, color, item.label)
        draw_button2(map[i],item,is_menu)
        if map[i].state == nil then
            map[i].state = false
        end
    end
end

local function draw_menu()
    paintutils.drawLine(61,1,61,26,colors.gray)
    init_buttons(menu_map,menu_list,true)
end

local function draw_spawners()
    init_buttons(button_map,spawner_list,false)
end

local function button_clicked(x,y,map)
    for i,button in ipairs(map) do
        if x >= button.x and x <= button.x+7 and y >= button.y and y <= button.y+2 then
            return i
        end
    end
end


for i=2,52,10 do
    for j=2,22,4 do
        table.insert(button_map,{x=i,y=j,state=nil})
    end
end

for i= 2,22,4 do
    table.insert(menu_map, {x=63, y=i})
end

term.setBackgroundColor(colors.black)
term.clear()
term.setTextColor(colors.white)

while true do
    draw_spawners()
    draw_menu()
    local _,_,x,y = os.pullEvent("monitor_touch")
    local id = button_clicked(x,y,button_map)
    button_map[id].state = not button_map[id].state
end
