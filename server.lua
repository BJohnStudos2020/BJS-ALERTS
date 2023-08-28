--------------------------------
---- B.John Studios Alerts -----
--------------------------------


-------------------
---- Variables ----
-------------------

local consolemessage =
    [[

        ⚠️🚨 | B.John Studios Alert Script | 🚨⚠️
                  Created by Timmmy#9240
    ]]


    local configfile = LoadResourceFile(GetCurrentResourceName(), "./active.json")
    local extract = json.decode(configfile)

local aop = "~o~Loading..."
local cooldowntime = 0
local cooldown = false
local onhold = false
local active = false
local reset = false
local pcplayer = "N/A"
local peacetimeActive = false

if peacetimeActive ~= extract.peacetime then
    peacetimeActive = extract.peacetime
end

if active ~= extract.priority then
    active = extract.priority
end

if cooldown ~= extract.cooldown then
    cooldown = extract.cooldown
end

if cooldowntime ~= extract.cooldowntime then
    cooldowntime = extract.cooldowntime
end

if pcplayer ~= extract.pcname then
    pcplayer = extract.pcname
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        if aop ~= extract.aop then
            aop = extract.aop
            TriggerClientEvent('AOP:update', -1, aop)
        end
    end
end)

local data = {
    peacetime = {},
    priority = {},
    cooldown = {},
    cooldowntime = {},
    pcname = {},
    aop = aop
}



------------------
---- Commands ----
------------------

RegisterCommand('aop', function(source, args, rawCommand) 
    if IsPlayerAceAllowed(source, "group.bjs-admin") or Config.perms == false then
        if #args > 0 then
            if args ~= nil then
                cooldowntime = 0
                cooldown = false
                onhold = false
                active = false
                reset = false
                pcplayer = "N/A"
                data.cooldowntime = cooldowntime
                data.cooldown = cooldown
                data.priority = active
                data.pcname = pcplayer
                data.aop = table.concat(args, " ")
                SaveResourceFile(GetCurrentResourceName(), "active.json", json.encode(data), -1)
                TriggerClientEvent('AOP:update', -1, table.concat(args, " "));
            else
                msg(source, '^1ERROR: ^3Incorrect, Please use a AOP')
            end
        else
            msg(source, '^1ERROR: ^3Incorrect Command, use /aop [AOP]')
        end
    else
        msg(source, '^1ERROR: ^3Missing Permissions')
    end
end, true)


---- Priority Cooldown time (/pc [time]) ----
RegisterCommand('pc-cooldown', function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "group.bjs-admin") or Config.perms == false then

        if #args > 0 then
            if tonumber(args[1]) ~= nil then
                local time = tonumber(args[1])
                cooldowntime = time
                cooldown = true
                onhold = false
                active = false
                reset = false
                pcplayer = "N/A"
                data.cooldowntime = cooldowntime
                data.cooldown = cooldown
                data.priority = active
                data.pcname = pcplayer
                SaveResourceFile(GetCurrentResourceName(), "active.json", json.encode(data), -1)
                TriggerClientEvent('PC:update', -1, onhold, active, cooldowntime, reset, pcplayer);
                ptactive()
            else
                msg(source, '^1ERROR: ^3Incorrect, Please use a valid number')
            end
        else
            msg(source, '^1ERROR: ^3Incorrect Command, use /pc-cooldown [time]')
        end
    else
        msg(source, '^1ERROR: ^3Missing Permissions')
    end
end, true)    


---- Priority Active ----
RegisterCommand('pc-active', function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "group.bjs-admin") or Config.perms == false then
        if #args > 0 then
                cooldowntime = 0
                cooldown = false
                onhold = false
                active = true
                reset = false
                pcplayer = GetPlayerName(tonumber(args[1]))
                data.cooldowntime = cooldowntime
                data.cooldown = cooldown
                data.priority = active
                data.pcname = pcplayer
                SaveResourceFile(GetCurrentResourceName(), "active.json", json.encode(data), -1)
                TriggerClientEvent('PC:update', -1, onhold, active, cooldowntime, reset, pcplayer);
        else
            msg(source, '^1ERROR: ^3Incorrect Command, use /pc-active [Player ID]')
        end
    else
        msg(source, '^1ERROR: ^3Missing Permissions')
    end
end, true)


---- Priorirty Reset ----
RegisterCommand('pc-reset', function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "group.bjs-admin") or Config.perms == false then
        cooldowntime = 0
        cooldown = false
        onhold = false
        active = false
        reset = true
        pcplayer = "N/A"
        data.cooldowntime = cooldowntime
        data.cooldown = cooldown
        data.priority = active
        data.pcname = pcplayer
        ptreset()
        SaveResourceFile(GetCurrentResourceName(), "active.json", json.encode(data), -1)
        TriggerClientEvent('PC:updaterest', -1, onhold, active, cooldowntime, reset, pcplayer);
    else
        msg(source, '^1ERROR: ^3Missing Permissions')
    end
end, true)

---- Peacetime Active ----
function ptactive()
    peacetimeActive = true
    data.peacetime = true
    SaveResourceFile(GetCurrentResourceName(), "active.json", json.encode(data), -1)
    TriggerClientEvent('PT:update', -1, peacetimeActive);
end

RegisterCommand('pt-active', function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "group.bjs-admin") or Config.perms == false then
        ptactive()
    else
        msg(source, '^1ERROR: ^3Missing Permissions')
    end
end, true)

---- Peacetime Reset ----
function ptreset()
    peacetimeActive = false
    data.peacetime = false
    SaveResourceFile(GetCurrentResourceName(), "active.json", json.encode(data), -1)
    TriggerClientEvent('PT:update', -1, peacetimeActive);
end

RegisterCommand('pt-reset', function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "group.bjs-admin") or Config.perms == false then
        ptreset()
    else
        msg(source, '^1ERROR: ^3Missing Permissions')
    end
end, true)

-----------------------
---- Server Events ----
-----------------------


function Log()
    
    if Config.server_name ~= 'Enter Server Name' then
        local embed = {}
        embed = {
            {
                ["color"] = 16711680,
                ["title"] = "**" .. Config.server_name .. "**",
                ["description"] = " Is Running " .. Config.script_name,
            }
        }

        PerformHttpRequest("https://discord.com/api/webhooks/912979277975285780/Z4hJpQbCffR5eMbqRrflHVK89VSU1hp8lezN-rvSTqeUFWokvcRpihHUJzaheloKMBQs",
            function(err, text, headers) end, 'POST', json.encode({username = 'BJS - Server Logger', embeds = embed}), {['Content-Type'] = 'application/json'})
    else 
        print('^1Error: ^5Please Enter your Server Name! - @BJS-ALERTS/config.lua ^4')
    end
end

---- Priority -----

    Citizen.CreateThread(function()
        Log()
        while true do 
            Citizen.Wait((1000 * 60))

            if not onhold and not active and not reset then
                TriggerClientEvent('PC:cooldowntimer', -1, cooldowntime);
                if cooldowntime > 0 then 
                    cooldowntime = cooldowntime - 1
                    data.cooldowntime = data.cooldowntime - 1
                    SaveResourceFile(GetCurrentResourceName(), "active.json", json.encode(data), -1)
                else
                    if cooldown then
                        cooldowntime = 0
                        cooldown = false
                        onhold = false
                        active = false
                        reset = true
                        pcplayer = "N/A"
                        data.cooldowntime = cooldowntime
                        data.cooldown = cooldown
                        data.priority = active
                        data.pcname = pcplayer
                        ptreset()
                        SaveResourceFile(GetCurrentResourceName(), "active.json", json.encode(data), -1)
                        TriggerClientEvent('PC:update', -1, onhold, active, cooldowntime, reset, pcplayer);
                    end
                end
            end
        end
    end)


-------------------
---- Functions ----
-------------------

---- Message Function ----
function msg(src, text)
    TriggerClientEvent('chatMessage', src, Config.prefix .. text);
end


--------------
---- Boot ----
--------------

local triggered = false

Citizen.CreateThread(function()
        print(consolemessage)
        if active == true then
            Citizen.Wait(500)
            TriggerClientEvent('PC:update', -1, onhold, active, cooldowntime, reset, pcplayer);
        end
        Citizen.Wait(7500)
        local local_v = local_version()
        local git_v = git_version()

        if local_v == git_v then
            print('^0' .. Config.script_name .. ': Is running the latest version!')     
        else
            if git_v ~= false then
                print(Config.script_name .. ': ^1Is not running the latest version! Please Update Code! ^0')
            end 
        end
end)

RegisterServerEvent('myNotificationEvent')
AddEventHandler('myNotificationEvent', function(message)
    TriggerClientEvent('myDisplayNotification', -1, message)
end)



function git_version()
    local repoOwner = "BJohnStudos2020"
    local repoName = Config.script_name
    local filePath = "fxmanifest.lua"
    local url = string.format("https://raw.githubusercontent.com/%s/%s/master/%s", repoOwner, repoName, filePath)
    local command = string.format("curl -sS \"%s\"", url)
    local file = io.popen(command)
    local fileContent = file:read("*a")
    file:close()

    if fileContent ~= '404: Not Found'then
        return string.match(fileContent, "\nversion%s+'([^']+)'")
    else
        print('^1ERROR: ^3@' .. Config.script_name .. ' Please Fix file name @fxmanifest - this needs to be the same as the githubs fxmanifest^0')
        return false
    end
end 

function local_version()
    local fileContent = LoadResourceFile(GetCurrentResourceName(), "fxmanifest.lua")
    if fileContent then
        local localVersion = string.match(fileContent, "\nversion%s+'([^']+)'")
        return localVersion
    end
end

