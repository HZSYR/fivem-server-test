local npcWeapons = {
    { hash = `WEAPON_PISTOL`, tier = 1 },
    { hash = `WEAPON_COMBATPISTOL`, tier = 1 },
    { hash = `WEAPON_PISTOL50`, tier = 1 },
    { hash = `WEAPON_HEAVYPISTOL`, tier = 1 },
    { hash = `WEAPON_REVOLVER`, tier = 1 },
    { hash = `WEAPON_DOUBLEACTION`, tier = 1 },
    { hash = `WEAPON_MICROSMG`, tier = 2 },
    { hash = `WEAPON_SMG`, tier = 2 },
    { hash = `WEAPON_ASSAULTSMG`, tier = 2 },
    { hash = `WEAPON_COMBATPDW`, tier = 2 },
    { hash = `WEAPON_MACHINEPISTOL`, tier = 2 },
    { hash = `WEAPON_PUMPSHOTGUN`, tier = 2 },
    { hash = `WEAPON_SAWNOFFSHOTGUN`, tier = 2 },
    { hash = `WEAPON_ASSAULTSHOTGUN`, tier = 2 },
    { hash = `WEAPON_HEAVYSHOTGUN`, tier = 2 },
    { hash = `WEAPON_DOUBLEBARRELSHOTGUN`, tier = 2 },
    { hash = `WEAPON_ASSAULTRIFLE`, tier = 3 },
    { hash = `WEAPON_CARBINERIFLE`, tier = 3 },
    { hash = `WEAPON_SPECIALCARBINE`, tier = 3 },
    { hash = `WEAPON_BULLPUPRIFLE`, tier = 3 },
    { hash = `WEAPON_COMPACTRIFLE`, tier = 3 },
    { hash = `WEAPON_MILITARYRIFLE`, tier = 3 },
    { hash = `WEAPON_MG`, tier = 3 },
    { hash = `WEAPON_COMBATMG`, tier = 3 },
    { hash = `WEAPON_GUSENBERG`, tier = 3 },
    { hash = `WEAPON_RPG`, tier = 4 },
    { hash = `WEAPON_MINIGUN`, tier = 4 },
    { hash = `WEAPON_GRENADELAUNCHER`, tier = 4 },
    { hash = `WEAPON_HOMINGLAUNCHER`, tier = 4 },
    { hash = `WEAPON_RAILGUN`, tier = 4 },
    { hash = `WEAPON_SNIPERRIFLE`, tier = 4 },
    { hash = `WEAPON_HEAVYSNIPER`, tier = 4 },
}

local angryNpcs = {}
local angryCount = 0
local MAX_ANGRY_NPCS = 30

local function getRandomWeapon()
    local roll = math.random(1, 100)
    local tier

    if roll <= 25 then
        tier = 1
    elseif roll <= 60 then
        tier = 2
    elseif roll <= 90 then
        tier = 3
    else
        tier = 4
    end

    local tierWeapons = {}
    for _, w in ipairs(npcWeapons) do
        if w.tier == tier then
            tierWeapons[#tierWeapons + 1] = w.hash
        end
    end

    return tierWeapons[math.random(1, #tierWeapons)]
end

local function angryEffect(npcPed)
    PlayPain(npcPed, 6, 0)
    SetFlash(0, 0, 80, 200, 80)
end

function getNearbyPeds(coords, radius)
    local result = {}
    local handle, ped = FindFirstPed()
    local found = true

    while found do
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) then
            local pedPos = GetEntityCoords(ped)
            if #(coords - pedPos) <= radius then
                result[#result + 1] = ped
            end
        end
        found, ped = FindNextPed(handle)
    end

    EndFindPed(handle)
    return result
end

local function makeNpcAngry(npcPed)
    if angryNpcs[npcPed] then return end
    if not DoesEntityExist(npcPed) then return end
    if IsEntityDead(npcPed) then return end
    if IsPedAPlayer(npcPed) then return end
    if angryCount >= MAX_ANGRY_NPCS then return end

    angryNpcs[npcPed] = true
    angryCount = angryCount + 1

    local playerPed = PlayerPedId()
    local weapon = getRandomWeapon()

    GiveWeaponToPed(npcPed, weapon, 9999, true, true)
    SetCurrentPedWeapon(npcPed, weapon, true)

    SetPedCombatAbility(npcPed, 100)
    SetPedCombatMovement(npcPed, 3)
    SetPedCombatRange(npcPed, 2)
    SetPedAccuracy(npcPed, math.random(40, 75))
    SetPedSeeingRange(npcPed, 200.0)
    SetPedHearingRange(npcPed, 150.0)

    SetPedCombatAttributes(npcPed, 0, true)
    SetPedCombatAttributes(npcPed, 1, true)
    SetPedCombatAttributes(npcPed, 2, true)
    SetPedCombatAttributes(npcPed, 3, true)
    SetPedCombatAttributes(npcPed, 5, true)
    SetPedCombatAttributes(npcPed, 20, true)
    SetPedCombatAttributes(npcPed, 46, true)
    SetPedCombatAttributes(npcPed, 52, true)

    SetPedFleeAttributes(npcPed, 0, false)
    SetBlockingOfNonTemporaryEvents(npcPed, true)

    SetEntityHealth(npcPed, math.random(200, 400))
    SetPedArmour(npcPed, math.random(50, 150))

    TaskCombatPed(npcPed, playerPed, 0, 16)
    SetPedKeepTask(npcPed, true)

    angryEffect(npcPed)

    if math.random(1, 100) <= 30 then
        Citizen.SetTimeout(math.random(1000, 3000), function()
            local nearbyPeds = getNearbyPeds(GetEntityCoords(npcPed), 15.0)
            for _, nearbyPed in ipairs(nearbyPeds) do
                if not angryNpcs[nearbyPed] and math.random(1, 100) <= 50 then
                    makeNpcAngry(nearbyPed)
                    break
                end
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)

        local handle, ped = FindFirstPed()
        local found = true

        while found do
            if DoesEntityExist(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) and not angryNpcs[ped] then
                local pedPos = GetEntityCoords(ped)
                local dist = #(playerPos - pedPos)

                if dist < 80.0 then
                    local triggered = false

                    if HasEntityBeenDamagedByEntity(ped, playerPed, true) then
                        triggered = true
                    end

                    if not triggered and IsPedInAnyVehicle(playerPed, false) then
                        local veh = GetVehiclePedIsIn(playerPed, false)
                        if HasEntityBeenDamagedByEntity(ped, veh, true) then
                            triggered = true
                        end
                    end

                    if not triggered and IsPedRagdoll(ped) and dist < 5.0 then
                        triggered = true
                    end

                    if not triggered and IsPedShooting(playerPed) and dist < 25.0 then
                        if math.random(1, 100) <= 40 then
                            triggered = true
                        end
                    end

                    if triggered then
                        makeNpcAngry(ped)
                        ClearEntityLastDamageEntity(ped)
                    end
                end
            end

            found, ped = FindNextPed(handle)
        end

        EndFindPed(handle)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)

        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local speed = GetEntitySpeed(vehicle) * 3.6

            if speed > 5.0 then
                local vehPos = GetEntityCoords(vehicle)
                local handle, ped = FindFirstPed()
                local found = true

                while found do
                    if DoesEntityExist(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) and not angryNpcs[ped] then
                        local pedPos = GetEntityCoords(ped)
                        local dist = #(vehPos - pedPos)

                        if dist < 4.0 then
                            makeNpcAngry(ped)
                        elseif dist < 7.0 and speed > 40.0 then
                            if math.random(1, 100) <= 60 then
                                makeNpcAngry(ped)
                            end
                        end
                    end

                    found, ped = FindNextPed(handle)
                end

                EndFindPed(handle)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)

        SetAllRandomPedsFlee(false)

        for npcPed, _ in pairs(angryNpcs) do
            if not DoesEntityExist(npcPed) or IsEntityDead(npcPed) then
                angryNpcs[npcPed] = nil
                angryCount = angryCount - 1
            end
        end

        local handle, ped = FindFirstPed()
        local found = true

        while found do
            if DoesEntityExist(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) then
                SetPedDiesWhenInjured(ped, false)
                SetPedSuffersCriticalHits(ped, false)
                SetPedConfigFlag(ped, 281, true)
            end
            found, ped = FindNextPed(handle)
        end
        EndFindPed(handle)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        ClearPlayerWantedLevel(PlayerId())
        SetMaxWantedLevel(0)
        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
    end
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent('chat:addMessage', {
            color = {255, 50, 50},
            multiline = true,
            args = {"[SECRET ROOM]", "NPC RAGE MODE aktif! Jangan senggol mereka... atau senggol aja!"}
        })
    end
end)

RegisterCommand('rageall', function()
    local playerPos = GetEntityCoords(PlayerPedId())
    local nearbyPeds = getNearbyPeds(playerPos, 30.0)

    for _, ped in ipairs(nearbyPeds) do
        makeNpcAngry(ped)
    end

    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        args = {"[RAGE]", #nearbyPeds .. " NPC sekarang marah besar!"}
    })
end, false)

RegisterCommand('ragereset', function()
    for npcPed, _ in pairs(angryNpcs) do
        if DoesEntityExist(npcPed) then
            ClearPedTasks(npcPed)
            RemoveAllPedWeapons(npcPed, true)
            SetPedAsNoLongerNeeded(npcPed)
        end
    end
    angryNpcs = {}
    angryCount = 0

    TriggerEvent('chat:addMessage', {
        color = {0, 255, 100},
        args = {"[RESET]", "Semua NPC sudah tenang kembali."}
    })
end, false)

TriggerEvent('chat:addSuggestion', '/rageall', 'Bikin semua NPC di sekitar marah besar!')
TriggerEvent('chat:addSuggestion', '/ragereset', 'Reset semua NPC marah jadi normal')
