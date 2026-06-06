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
local angryBlips = {}
local angryCount = 0
local MAX_ANGRY_NPCS = 50

local function getRandomWeapon()
    local roll = math.random(1, 100)
    local tier

    if roll <= 15 then
        tier = 1
    elseif roll <= 45 then
        tier = 2
    elseif roll <= 80 then
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

local function isHumanPed(ped)
    return not IsPedAnimal(ped)
end

local function addBlipForNpc(npcPed)
    if angryBlips[npcPed] and DoesBlipExist(angryBlips[npcPed]) then
        RemoveBlip(angryBlips[npcPed])
    end
    local blip = AddBlipForEntity(npcPed)
    SetBlipSprite(blip, 161)
    SetBlipColour(blip, 1)
    SetBlipScale(blip, 0.9)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("MUSUH")
    EndTextCommandSetBlipName(blip)
    angryBlips[npcPed] = blip
end

local function removeBlipForNpc(npcPed)
    if angryBlips[npcPed] then
        if DoesBlipExist(angryBlips[npcPed]) then
            RemoveBlip(angryBlips[npcPed])
        end
        angryBlips[npcPed] = nil
    end
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
    if not isHumanPed(npcPed) then return end

    angryNpcs[npcPed] = true
    angryCount = angryCount + 1

    local playerPed = PlayerPedId()
    local weapon = getRandomWeapon()

    SetPedFleeAttributes(npcPed, 0, false)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    SetPedConfigFlag(npcPed, 281, true)
    SetPedConfigFlag(npcPed, 2, false)
    SetPedConfigFlag(npcPed, 292, true)

    ClearPedTasksImmediately(npcPed)

    GiveWeaponToPed(npcPed, weapon, 9999, true, true)
    SetCurrentPedWeapon(npcPed, weapon, true)

    SetPedCombatAbility(npcPed, 100)
    SetPedCombatMovement(npcPed, 3)
    SetPedCombatRange(npcPed, 2)
    SetPedAccuracy(npcPed, math.random(50, 85))
    SetPedSeeingRange(npcPed, 250.0)
    SetPedHearingRange(npcPed, 200.0)
    SetPedAlertness(npcPed, 3)

    SetPedCombatAttributes(npcPed, 0, true)
    SetPedCombatAttributes(npcPed, 1, true)
    SetPedCombatAttributes(npcPed, 2, true)
    SetPedCombatAttributes(npcPed, 3, true)
    SetPedCombatAttributes(npcPed, 5, true)
    SetPedCombatAttributes(npcPed, 20, true)
    SetPedCombatAttributes(npcPed, 46, true)
    SetPedCombatAttributes(npcPed, 52, true)
    SetPedCombatAttributes(npcPed, 58, true)

    SetEntityHealth(npcPed, math.random(300, 500))
    SetPedArmour(npcPed, math.random(100, 200))

    SetPedRelationshipGroupHash(npcPed, GetHashKey("HATES_PLAYER"))

    TaskCombatPed(npcPed, playerPed, 0, 16)
    SetPedKeepTask(npcPed, true)

    addBlipForNpc(npcPed)

    PlayPain(npcPed, 6, 0)
    SetFlash(0, 0, 80, 200, 80)

    Citizen.SetTimeout(math.random(300, 1500), function()
        local nearbyPeds = getNearbyPeds(GetEntityCoords(npcPed), 40.0)
        for _, nearbyPed in ipairs(nearbyPeds) do
            if not angryNpcs[nearbyPed] then
                makeNpcAngry(nearbyPed)
            end
        end
    end)
end

Citizen.CreateThread(function()
    AddRelationshipGroup("HATES_PLAYER")
    SetRelationshipBetweenGroups(5, GetHashKey("HATES_PLAYER"), GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("HATES_PLAYER"))
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)
        local isShooting = IsPedShooting(playerPed)
        local isAiming = IsPlayerFreeAiming(PlayerId())

        local handle, ped = FindFirstPed()
        local found = true

        while found do
            if DoesEntityExist(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) and not angryNpcs[ped] then
                if isHumanPed(ped) then
                    local pedPos = GetEntityCoords(ped)
                    local dist = #(playerPos - pedPos)

                    if dist < 120.0 then
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

                        if not triggered and IsPedRagdoll(ped) and dist < 8.0 then
                            triggered = true
                        end

                        if not triggered and isShooting and dist < 100.0 then
                            triggered = true
                        end

                        if not triggered and isAiming and dist < 15.0 then
                            triggered = true
                        end

                        if triggered then
                            makeNpcAngry(ped)
                            ClearEntityLastDamageEntity(ped)
                        end
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
        Citizen.Wait(150)

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
                        if isHumanPed(ped) then
                            local pedPos = GetEntityCoords(ped)
                            local dist = #(vehPos - pedPos)

                            if dist < 5.0 then
                                makeNpcAngry(ped)
                            elseif dist < 10.0 and speed > 30.0 then
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
        Citizen.Wait(1500)

        SetAllRandomPedsFlee(false)
        SetAllRandomPedsFleeThisFrame(false)

        for npcPed, _ in pairs(angryNpcs) do
            if not DoesEntityExist(npcPed) or IsEntityDead(npcPed) then
                removeBlipForNpc(npcPed)
                angryNpcs[npcPed] = nil
                angryCount = angryCount - 1
            else
                if not angryBlips[npcPed] or not DoesBlipExist(angryBlips[npcPed]) then
                    addBlipForNpc(npcPed)
                end

                local playerPed = PlayerPedId()
                if not IsPedInCombat(npcPed, playerPed) then
                    ClearPedTasksImmediately(npcPed)
                    TaskCombatPed(npcPed, playerPed, 0, 16)
                    SetPedKeepTask(npcPed, true)
                    SetBlockingOfNonTemporaryEvents(npcPed, true)
                end
            end
        end

        local handle, ped = FindFirstPed()
        local found = true

        while found do
            if DoesEntityExist(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) and isHumanPed(ped) then
                SetPedDiesWhenInjured(ped, false)
                SetPedSuffersCriticalHits(ped, false)
                SetPedConfigFlag(ped, 281, true)
                SetPedConfigFlag(ped, 2, false)
                SetPedFleeAttributes(ped, 0, false)
                SetPedCombatAttributes(ped, 17, false)
            end
            found, ped = FindNextPed(handle)
        end
        EndFindPed(handle)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetAllRandomPedsFleeThisFrame(false)
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
            args = {"[SECRET ROOM]", "NPC RAGE MODE EXTREME! Tembak = semua NPC dalam 100m langsung marah!"}
        })
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for npcPed, _ in pairs(angryNpcs) do
            removeBlipForNpc(npcPed)
        end
    end
end)

RegisterCommand('rageall', function()
    local playerPos = GetEntityCoords(PlayerPedId())
    local nearbyPeds = getNearbyPeds(playerPos, 80.0)

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
        removeBlipForNpc(npcPed)
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
