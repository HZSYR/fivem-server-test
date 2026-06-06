local policeModels = {
    `s_m_y_cop_01`,
    `s_f_y_cop_01`,
    `s_m_y_sheriff_01`,
    `s_m_y_swat_01`,
}

local policeWeapons = {
    `WEAPON_PISTOL`,
    `WEAPON_COMBATPISTOL`,
    `WEAPON_PUMPSHOTGUN`,
    `WEAPON_CARBINERIFLE`,
    `WEAPON_SMG`,
}

local policeVehicles = {
    `police`,
    `police2`,
    `police3`,
    `policeb`,
    `sheriff`,
    `sheriff2`,
}

local spawnedCops = {}
local MAX_COPS = 10
local copCount = 0
local dispatchCooldown = false

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(10)
    end
end

local function getAngryNpcsNearby(coords, radius)
    local result = {}
    local handle, ped = FindFirstPed()
    local found = true

    while found do
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) then
            if IsPedInCombat(ped, 0) or IsPedShooting(ped) or IsEntityOnFire(ped) then
                local pedPos = GetEntityCoords(ped)
                if #(coords - pedPos) <= radius then
                    local isPolicePed = false
                    for _, cop in ipairs(spawnedCops) do
                        if cop.ped == ped then
                            isPolicePed = true
                            break
                        end
                    end
                    if not isPolicePed then
                        result[#result + 1] = ped
                    end
                end
            end
        end
        found, ped = FindNextPed(handle)
    end

    EndFindPed(handle)
    return result
end

local function spawnPoliceUnit(targetCoords)
    if copCount >= MAX_COPS then return end

    local offsetX = math.random(-80, 80)
    local offsetY = math.random(-80, 80)
    local spawnPos = vector3(targetCoords.x + offsetX, targetCoords.y + offsetY, targetCoords.z)

    local foundGround, groundZ = GetGroundZFor_3dCoord(spawnPos.x, spawnPos.y, spawnPos.z + 100.0, false)
    if foundGround then
        spawnPos = vector3(spawnPos.x, spawnPos.y, groundZ + 1.0)
    else
        spawnPos = vector3(spawnPos.x, spawnPos.y, targetCoords.z + 1.0)
    end

    local vehModel = policeVehicles[math.random(1, #policeVehicles)]
    local copModel = policeModels[math.random(1, #policeModels)]
    local weapon = policeWeapons[math.random(1, #policeWeapons)]

    loadModel(vehModel)
    loadModel(copModel)

    local node, nodePos = GetClosestVehicleNodeWithHeading(spawnPos.x, spawnPos.y, spawnPos.z, 1, 3.0, 0)
    if not node then
        nodePos = spawnPos
    end

    local heading = math.random(0, 360) + 0.0
    local vehicle = CreateVehicle(vehModel, nodePos.x, nodePos.y, nodePos.z, heading, true, false)

    SetVehicleSiren(vehicle, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)

    local cop1 = CreatePedInsideVehicle(vehicle, 4, copModel, -1, true, false)
    copCount = copCount + 1
    spawnedCops[#spawnedCops + 1] = { ped = cop1, vehicle = vehicle }

    GiveWeaponToPed(cop1, weapon, 9999, true, true)
    SetPedArmour(cop1, 200)
    SetEntityHealth(cop1, 300)
    SetPedAccuracy(cop1, math.random(50, 80))
    SetPedCombatAbility(cop1, 100)
    SetPedCombatMovement(cop1, 3)
    SetPedCombatRange(cop1, 2)
    SetPedCombatAttributes(cop1, 0, true)
    SetPedCombatAttributes(cop1, 1, true)
    SetPedCombatAttributes(cop1, 2, true)
    SetPedCombatAttributes(cop1, 3, true)
    SetPedCombatAttributes(cop1, 5, true)
    SetPedCombatAttributes(cop1, 46, true)
    SetPedCombatAttributes(cop1, 52, true)
    SetPedFleeAttributes(cop1, 0, false)
    SetBlockingOfNonTemporaryEvents(cop1, true)

    local cop2Model = policeModels[math.random(1, #policeModels)]
    loadModel(cop2Model)
    local cop2 = CreatePedInsideVehicle(vehicle, 4, cop2Model, 0, true, false)
    copCount = copCount + 1
    spawnedCops[#spawnedCops + 1] = { ped = cop2, vehicle = vehicle }

    local weapon2 = policeWeapons[math.random(1, #policeWeapons)]
    GiveWeaponToPed(cop2, weapon2, 9999, true, true)
    SetPedArmour(cop2, 200)
    SetEntityHealth(cop2, 300)
    SetPedAccuracy(cop2, math.random(50, 80))
    SetPedCombatAbility(cop2, 100)
    SetPedCombatMovement(cop2, 3)
    SetPedCombatRange(cop2, 2)
    SetPedCombatAttributes(cop2, 0, true)
    SetPedCombatAttributes(cop2, 1, true)
    SetPedCombatAttributes(cop2, 2, true)
    SetPedCombatAttributes(cop2, 3, true)
    SetPedCombatAttributes(cop2, 5, true)
    SetPedCombatAttributes(cop2, 46, true)
    SetPedCombatAttributes(cop2, 52, true)
    SetPedFleeAttributes(cop2, 0, false)
    SetBlockingOfNonTemporaryEvents(cop2, true)

    SetModelAsNoLongerNeeded(vehModel)
    SetModelAsNoLongerNeeded(copModel)
    SetModelAsNoLongerNeeded(cop2Model)

    return cop1, cop2, vehicle
end

local function dispatchPolice(targetCoords, targets)
    if dispatchCooldown then return end
    dispatchCooldown = true

    local unitsToSend = math.min(math.ceil(#targets / 2), 3)

    for i = 1, unitsToSend do
        local cop1, cop2, vehicle = spawnPoliceUnit(targetCoords)

        if cop1 and vehicle then
            Citizen.SetTimeout(500 * i, function()
                if DoesEntityExist(vehicle) and DoesEntityExist(cop1) then
                    local target = targets[math.random(1, #targets)]

                    if DoesEntityExist(target) and not IsEntityDead(target) then
                        local targetPos = GetEntityCoords(target)
                        TaskVehicleDriveToCoordLongrange(cop1, vehicle, targetPos.x, targetPos.y, targetPos.z, 30.0, 787004, 5.0)

                        Citizen.SetTimeout(math.random(8000, 15000), function()
                            if DoesEntityExist(cop1) and not IsEntityDead(cop1) then
                                TaskLeaveVehicle(cop1, vehicle, 256)
                                Citizen.SetTimeout(1500, function()
                                    if DoesEntityExist(cop1) and not IsEntityDead(cop1) then
                                        local aliveTargets = {}
                                        for _, t in ipairs(targets) do
                                            if DoesEntityExist(t) and not IsEntityDead(t) then
                                                aliveTargets[#aliveTargets + 1] = t
                                            end
                                        end
                                        if #aliveTargets > 0 then
                                            TaskCombatPed(cop1, aliveTargets[math.random(1, #aliveTargets)], 0, 16)
                                            SetPedKeepTask(cop1, true)
                                        end
                                    end
                                end)
                            end

                            if DoesEntityExist(cop2) and not IsEntityDead(cop2) then
                                TaskLeaveVehicle(cop2, vehicle, 256)
                                Citizen.SetTimeout(2000, function()
                                    if DoesEntityExist(cop2) and not IsEntityDead(cop2) then
                                        local aliveTargets = {}
                                        for _, t in ipairs(targets) do
                                            if DoesEntityExist(t) and not IsEntityDead(t) then
                                                aliveTargets[#aliveTargets + 1] = t
                                            end
                                        end
                                        if #aliveTargets > 0 then
                                            TaskCombatPed(cop2, aliveTargets[math.random(1, #aliveTargets)], 0, 16)
                                            SetPedKeepTask(cop2, true)
                                        end
                                    end
                                end)
                            end
                        end)
                    end
                end
            end)
        end
    end

    Citizen.SetTimeout(15000, function()
        dispatchCooldown = false
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)

        local playerPos = GetEntityCoords(PlayerPedId())
        local angryTargets = getAngryNpcsNearby(playerPos, 100.0)

        if #angryTargets >= 1 then
            dispatchPolice(playerPos, angryTargets)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)

        for i = #spawnedCops, 1, -1 do
            local cop = spawnedCops[i]

            if not DoesEntityExist(cop.ped) or IsEntityDead(cop.ped) then
                if DoesEntityExist(cop.ped) then
                    SetEntityAsNoLongerNeeded(cop.ped)
                end
                table.remove(spawnedCops, i)
                copCount = copCount - 1
            else
                local copPos = GetEntityCoords(cop.ped)
                local playerPos = GetEntityCoords(PlayerPedId())
                local dist = #(copPos - playerPos)

                if dist > 200.0 then
                    if DoesEntityExist(cop.vehicle) then
                        DeleteVehicle(cop.vehicle)
                    end
                    DeletePed(cop.ped)
                    table.remove(spawnedCops, i)
                    copCount = copCount - 1
                else
                    if not IsPedInCombat(cop.ped, 0) then
                        local nearbyTargets = getAngryNpcsNearby(copPos, 50.0)
                        if #nearbyTargets > 0 then
                            local target = nearbyTargets[math.random(1, #nearbyTargets)]
                            TaskCombatPed(cop.ped, target, 0, 16)
                            SetPedKeepTask(cop.ped, true)
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for _, cop in ipairs(spawnedCops) do
            if DoesEntityExist(cop.ped) and not IsEntityDead(cop.ped) then
                SetPedRelationshipGroupHash(cop.ped, `COP`)
                SetPedAsEnemy(cop.ped, false)
            end
        end
    end
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent('chat:addMessage', {
            color = {0, 150, 255},
            multiline = true,
            args = {"[SECRET ROOM]", "Police Response aktif! Polisi otomatis datang menindak NPC rusuh!"}
        })
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, cop in ipairs(spawnedCops) do
            if DoesEntityExist(cop.ped) then
                DeletePed(cop.ped)
            end
            if DoesEntityExist(cop.vehicle) then
                DeleteVehicle(cop.vehicle)
            end
        end
        spawnedCops = {}
        copCount = 0
    end
end)
