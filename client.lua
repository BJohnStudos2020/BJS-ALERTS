--------------------------------
---- B.John Studios Alerts -----
--------------------------------


-------------------
---- Variables ----
-------------------


---- Peacetime ----
peacetimeActive = false


---- AOP ----
local AOPxNew = 0.660
local AOPyNew = 1.364
local AOPyNew2 = AOPyNew + 0.025
aop = "~o~Loading..."


---- Priority ----
local onhold = false
local active = false
local reset = false
local cooldownnum = 0
local time = 0
local pttime = 0
local pctime = 0
local pcplayer = "N/A"


--------------------------
---- Chat Suggestions ----
--------------------------

TriggerEvent("chat:addSuggestion", "/pc-cooldown", "Priority Cooldown", {
    { name = "Time", help = "Enter Cooldown time here!"}
})
TriggerEvent("chat:addSuggestion", "/pc-active", "Activate Priority", {
    { name = "Player ID", help = "Enter Active Priority Player's ID here!"}
})
TriggerEvent("chat:addSuggestion", "/pc-reset", "Priority Reset")

TriggerEvent("chat:addSuggestion", "/pt-active", "Activate Peacetime")

TriggerEvent("chat:addSuggestion", "/pt-reset", "Reset Peacetime")

-----------------------
---- Client Events ----
-----------------------


---- Peacetime ----

RegisterNetEvent('PT:update')
AddEventHandler('PT:update', function(peace)
    if peacetimeActive ~= peace then
        pttime = 0
        ptannounce(peace)
    end
end)

function ptannounce(peace)
    peacetimeActive = peace
    
        if peace then 
            local info = "Peacetime Active";
            TriggerEvent('BJS-ALERTS:Notification', 'Peacetime', info, 10000, 'Red')
        else 
            local info = "Peacetime Reset";
            TriggerEvent('BJS-ALERTS:Notification', 'Peacetime', info, 10000, 'Green')
        end 
end

function Draw2DText4(x, y, text, scale)
    -- Draw text on screen
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local player = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(player)

        if peacetimeActive then
                if IsControlPressed(0, 106) then
                    ShowInfo("~r~Peacetime is enabled. ~n~~s~You cannot cause violence.")
                end
                SetPlayerCanDoDriveBy(player, false)
                DisablePlayerFiring(player, true)
                DisableControlAction(0, 140) -- Melee R
        end
    end
end)

function ShowInfo(text)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(true, false)
end


---- Priority ----
RegisterNetEvent('PC:update')
AddEventHandler('PC:update', function(oh, at, cdn, res, pcp)
    if pcp then
        onhold = oh
        active = at
        cooldownnum = cdn
        reset = res
        pcplayer = pcp
        pctime = 0
        pcannounce(oh, at, reset, cdn, pcplayer)
    else
        TriggerEvent("chatMessage", "^1ERROR: There is no player with that ID")
    end
end)
RegisterNetEvent('PC:updaterest')
AddEventHandler('PC:updaterest', function(oh, at, cdn, res, pcp)
        onhold = oh
        active = at
        cooldownnum = cdn
        reset = res
        pcplayer = pcp
        pctime = 0
        pcannounce(oh, at, reset, cdn, pcplayer)
end)

function pcannounce(oh, at, res, cdn, pcp)
        if res == true then 
            local info = "Priority's Reset";
            TriggerEvent('BJS-ALERTS:Notification', 'Priority', info, 10000, 'Green')
        elseif cdn > 0 then
            TriggerEvent('BJS-ALERTS:Notification', 'Priority', "Priority Cooldown Now Active", 10000, 'Red')
        else
            local info = "Priority Alert! - " ..  pcp;
            TriggerEvent('BJS-ALERTS:Notification', 'Priority', info, 10000, 'Red')
        end
end

RegisterNetEvent('PC:cooldowntimer')
AddEventHandler('PC:cooldowntimer', function(cdn)
    cooldownnum = cdn
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if cooldownnum then
            local cooldowntext = "~y~Priority Cooldown: ~r~" .. cooldownnum .. " [MINS]";
            if cooldownnum > 0 then

                local message = cooldowntext
                --TriggerServerEvent('myNotificationEvent', message)

                --TriggerEvent('BJS-ALERTS:Notification', 'Priority', cooldowntext, 10000)
                Draw2DText(.5, .03, cooldowntext, 0.5);
            end
        end
        local pcactivetext = "~y~Priority Active ~r~Player: " .. pcplayer;
        if pcplayer ~= "N/A" then 
            Draw2DText(.5, .03, pcactivetext, 0.5);
        end


    end
end)

function Draw2DText(x, y, text, scale)
    -- Draw text on screen
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextJustification(2)
    AddTextComponentString(text)
    DrawText(x, y)
end

function Draw2DText2(x, y, text, scale)
    -- Draw text on screen
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end




---- AOP ----

RegisterNetEvent('AOP:update')
AddEventHandler('AOP:update', function(newaop)
        if aop ~= newaop then
            time = 0
            aopannounce(newaop)
        end
end)

function aopannounce(newaop)
    aop = newaop
    local info = "AOP Has Changed To '" .. newaop ..  "' Please move over to New AOP!"
    TriggerEvent('BJS-ALERTS:Notification', 'AOP', info, 10000, 'Green')
end

function Draw2DText3(x, y, text, scale)
    -- Draw text on screen
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end


Citizen.CreateThread(function()
    TriggerServerEvent("AOP:Boot")
    while true do
        Citizen.Wait(1)
        if not peacetimeActive then
            DrawTextAOP2(AOPxNew, 1.411, 1.0,1.0,0.45, "~y~PeaceTime: ~r~Disabled", 255, 255, 255, 255)
        else 
            DrawTextAOP2(AOPxNew, 1.411, 1.0,1.0,0.45,"~y~PeaceTime: ~g~Enabled", 255, 255, 255, 255)
        end
            DrawTextAOP(AOPxNew, AOPyNew2, 1.0,1.0,0.45, "~y~Current AOP: ~b~" .. aop, 255, 255, 255, 255)
	end
end)

function DrawTextAOP(x,y ,width,height,scale, text, r,g,b,a)
    if AOPLocation == 1 or AOPLocation == 4 then
        SetTextCentre(true)
    end
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end
function DrawTextAOP2(x,y ,width,height,scale, text, r,g,b,a)
    if AOPLocation == 1 or AOPLocation == 4 then
        SetTextCentre(true)
    end
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end


function Alert(title, message, time, types)
	SendNUIMessage({
		action = 'notify',
        type = types,
        title = title,
        message = message,
        time = time
	})
end

RegisterNetEvent('BJS-ALERTS:Notification')
AddEventHandler('BJS-ALERTS:Notification', function(title, message, time, types)
	Alert(title, message, time, types)
end)	