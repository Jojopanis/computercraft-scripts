rednet.open("top")
rednet.host("mob_farm","relay")

local relays = {peripheral.find("redstone_relay")}

while true do
    local _, message = rednet.receive()
    if type(message) ~= 'table' then
        local relay = relays[message]
        print("Received message for relay #"..message)
        relay.setOutput("bottom", not relay.getOutput("bottom"))
    end
end
