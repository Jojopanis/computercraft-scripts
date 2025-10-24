local relays = {peripheral.find("redstone_relay")}

for i, relay in ipairs(relays) do
    if relay.getInput('bottom') then
        print("The powered one is relay #"..i)
        break
    end
end
