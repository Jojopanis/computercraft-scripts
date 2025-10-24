local screen = peripheral.find('monitor')
term.redirect(screen)

--Variables Definition
local spawner_list = {
    {label = 'cav_creeper',relay_id = 54},
    {label = 'witch',relay_id = 73},
}
local menu_list = {
    {label = ' Menu'}
}
local menu_map = {}
local button_map = {}

--Functions Definition
--Drawing Functions
local function draw_button2(button,item,is_menu)
    local x = button.x
    local y = button.y
    local sizeX = 7
    local sizeY = 2
    local message = item.label or "......"
    local color = colors.gray
    if is_menu == false then
        if button.state == true then
            color = colors.green
        else
            color = colors.red
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
        if map[i].state == nil then
            map[i].state = false
        end
        draw_button2(map[i],item,is_menu)
    end
end

local function draw_spawner_screen()
    init_buttons(button_map,spawner_list,false)
    paintutils.drawLine(61,1,61,26,colors.gray)
    init_buttons(menu_map,menu_list,true)
end

--Logic Functions
local function button_clicked(x,y,map)
    for i,button in ipairs(map) do
        if x >= button.x and x <= button.x+7 and y >= button.y and y <= button.y+2 then
            return i
        end
    end
end

local function populate_buttons()
    for i=2,52,10 do
        for j=2,22,4 do
            table.insert(button_map,{x=i,y=j,state=nil})
        end
    end
end

local function populate_menu()
    for i= 2,22,4 do
        table.insert(menu_map, {x=63, y=i})
    end
end

--Rednet Functions
local net = {}

function net.send(map,id)
    local receiver_id = rednet.lookup("mob_farm", "relay")
    rednet.send(receiver_id,map[id].relay_id)
end

function net.init()
    local side = peripheral.getName(peripheral.find("modem"))
    rednet.open(side)
    rednet.host("mob_farm", "control")
end

term.setBackgroundColor(colors.black)
term.clear()
term.setTextColor(colors.white)
populate_buttons()
populate_menu()
net.init()

while true do
    draw_spawner_screen()
    local _,_,x,y = os.pullEvent("monitor_touch")
    local s_id = button_clicked(x,y,button_map)
    if s_id ~= nil then
        button_map[s_id].state = not button_map[s_id].state
        net.send(button_map,s_id)
    end
end
