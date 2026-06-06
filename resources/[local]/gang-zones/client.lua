local gangs = {
    {
        name = "Ballas",
        color = {128, 0, 128},
        blipColor = 27,
        zone = vector3(-180.0, -1670.0, 33.0),
        radius = 200.0,
        peds = {`g_m_y_ballaorig_01`, `g_m_y_ballaeast_01`, `g_m_y_ballasout_01`},
        weapons = {`WEAPON_PISTOL`, `WEAPON_MICROSMG`, `WEAPON_PUMPSHOTGUN`, `WEAPON_MACHETE`},
        vehicles = {`buccaneer`, `tornado`, `manana`, `emperor`},
        maxMembers = 12,
        members = {},
        spawned = false,
    },
    {
        name = "Vagos",
        color = {255, 255, 0},
        blipColor = 28,
        zone = vector3(325.0, -2040.0, 20.0),
        radius = 200.0,
        peds = {`g_m_y_mexgang_01`, `g_m_y_mexgoon_01`, `g_m_y_mexgoon_02`, `g_m_y_mexgoon_03`},
        weapons = {`WEAPON_PISTOL`, `WEAPON_MICROSMG`, `WEAPON_ASSAULTRIFLE`, `WEAPON_KNIFE`},
        vehicles = {`tornado2`, `buccaneer2`, `chino`, `virgo`},
        maxMembers = 12,
        members = {},
        spawned = false,
    },
    {
        name = "Families",
        color = {0, 200, 0},
        blipColor = 2,
        zone = vector3(-150.0, -1770.0, 30.0),
        radius = 180.0,
        peds = {`g_m_y_famca_01`, `g_m_y_famdnf_01`, `g_m_y_famfor_01`},
        weapons = {`WEAPON_PISTOL`, `WEAPON_MICROSMG`, `WEAPON_SAWNOFFSHOTGUN`, `WEAPON_BAT`},
        vehicles = {`buccaneer`, `tornado`, `primo`, `emperor`},
        maxMembers = 10,
        members = {},
        spawned = false,
    },
    {
        name = "Lost MC",
        color = {100, 100, 100},
        blipColor = 40,
        zone = vector3(980.0, -130.0, 74.0),
        radius = 250.0,
        peds = {`g_m_y_lost_01`, `g_m_y_lost_02`, `g_m_y_lost_03`},
        weapons = {`WEAPON_PISTOL`, `WEAPON_SAWNOFFSHOTGUN`, `WEAPON_PUMPSHOTGUN`, `WEAPON_BAT`, `WEAPON_CROWBAR`},
        vehicles = {`daemon`, `daemon2`, `hexer`, `innovation`, `wolfsbane`, `zombiea`, `zombieb`},
        maxMembers = 10,
        members = {},
        spawned = false,
    },
    {
        name = "Mafia Italia",
        color = {50, 50, 50},
        blipColor = 40,
        zone = vector3(-1200.0, -800.0, 17.0),
        radius = 220.0,
        peds = {`g_m_m_armboss_01`, `g_m_m_armgoon_01`, `g_m_m_armlieut_01`, `g_m_y_armgoon_02`},
        weapons = {`WEAPON_PISTOL50`, `WEAPON_COMBATPISTOL`, `WEAPON_ASSAULTSMG`, `WEAPON_CARBINERIFLE`},
        vehicles = {`oracle`, `oracle2`, `schafter2`, `cognoscenti`, `cognoscenti2`, `superd`},
        maxMembers = 10,
        members = {},
        spawned = false,
    },
    {
        name = "Triads",
        color = {255, 50, 50},
        blipColor = 1,
        zone = vector3(-700.0, -900.0, 19.0),
        radius = 180.0,
        peds = {`g_m_m_chigoon_01`, `g_m_m_chigoon_02`, `g_m_m_chiboss_01`, `g_m_m_chicold_01`},
        weapons = {`WEAPON_PISTOL`, `WEAPON_SMG`, `WEAPON_ASSAULTRIFLE`, `WEAPON_DAGGER`},
        vehicles = {`fugitive`, `oracle`, `schafter2`, `fq2`},
        maxMembers = 10,
        members = {},
        spawned = false,
    },
    {
        name = "Redneck / Petani",
        color = {139, 90, 43},
        blipColor = 21,
        zone = vector3(2430.0, 4970.0, 46.0),
        radius = 350.0,
        peds = {`a_m_m_hillbilly_01`, `a_m_m_hillbilly_02`, `a_m_m_farmer_01`, `a_m_o_genstreet_01`},
        weapons = {`WEAPON_MUSKET`, `WEAPON_SAWNOFFSHOTGUN`, `WEAPON_PUMPSHOTGUN`, `WEAPON_HATCHET`, `WEAPON_BOTTLE`},
        vehicles = {`rebel`, `rebel2`, `bodhi2`, `dune`, `tractor`, `tractor2`},
        maxMembers = 8,
        members = {},
        spawned = false,
    },
    {
        name = "Cartel Mexico",
        color = {200, 100, 0},
        blipColor = 17,
        zone = vector3(1400.0, -2560.0, 45.0),
        radius = 250.0,
        peds = {`g_m_y_mexgang_01`, `g_m_y_mexgoon_01`, `g_m_y_mexgoon_02`, `g_m_y_mexgoon_03`},
        weapons = {`WEAPON_ASSAULTRIFLE`, `WEAPON_CARBINERIFLE`, `WEAPON_COMBATMG`, `WEAPON_RPG`, `WEAPON_HEAVYPISTOL`},
        vehicles = {`mesa3`, `dubsta`, `baller`, `cavalcade`},
        maxMembers = 10,
        members = {},
        spawned = false,
    },
    {
        name = "Street Racers",
        color = {0, 200, 255},
        blipColor = 3,
        zone = vector3(50.0, -780.0, 31.0),
        radius = 200.0,
        peds = {`a_m_y_hipster_01`, `a_m_y_hipster_02`, `a_m_y_vinewood_01`, `a_m_y_soucent_02`},
        weapons = {`WEAPON_PISTOL`, `WEAPON_MICROSMG`, `WEAPON_SWITCHBLADE`},
        vehicles = {`elegy2`, `jester`, `massacro`, `banshee`, `buffalo`, `comet2`, `feltzer2`, `sultan`},
        maxMembers = 8,
        members = {},
        spawned = false,
    },
    {
        name = "Military Rogue",
        color = {0, 80, 0},
        blipColor = 25,
        zone = vector3(-2360.0, 3250.0, 32.0),
        radius = 300.0,
        peds = {`s_m_y_armymech_01`, `s_m_m_marine_01`, `s_m_m_marine_02`, `s_m_y_marine_01`},
        weapons = {`WEAPON_CARBINERIFLE`, `WEAPON_SPECIALCARBINE`, `WEAPON_COMBATMG`, `WEAPON_RPG`, `WEAPON_HEAVYSNIPER`, `WEAPON_GRENADE`},
        vehicles = {`barracks`, `crusader`, `insurgent`, `insurgent2`, `rhino`},
        maxMembers = 8,
        members = {},
        spawned = false,
    },
    {
        name = "Hillbilly Meth Gang",
        color = {200, 200, 0},
        blipColor = 28,
        zone = vector3(1540.0, 1700.0, 110.0),
        radius = 250.0,
        peds = {`a_m_m_hillbilly_01`, `a_m_m_hillbilly_02`, `g_m_m_mexboss_01`, `g_m_m_mexboss_02`},
        weapons = {`WEAPON_PISTOL`, `WEAPON_SAWNOFFSHOTGUN`, `WEAPON_MICROSMG`, `WEAPON_MACHETE`, `WEAPON_MOLOTOV`},
        vehicles = {`rebel`, `rebel2`, `ratloader`, `dune`, `bison`},
        maxMembers = 8,
        members = {},
        spawned = false,
    },
    {
        name = "Bikers Club",
        color = {180, 0, 0},
        blipColor = 1,
        zone = vector3(-310.0, 6130.0, 31.0),
        radius = 200.0,
        peds = {`g_m_y_lost_01`, `g_m_y_lost_02`, `g_m_y_lost_03`},
        weapons = {`WEAPON_PISTOL`, `WEAPON_SAWNOFFSHOTGUN`, `WEAPON_BAT`, `WEAPON_CROWBAR`, `WEAPON_BOTTLE`},
        vehicles = {`daemon`, `daemon2`, `hexer`, `nightblade`, `ratbike`, `wolfsbane`, `avarus`},
        maxMembers = 8,
        members = {},
        spawned = false,
    },
}

local currentGangZone = nil
local spawnDistance = 300.0

local function loadModel(model)
    RequestModel(model)
    local timeout = 0
    while not HasModelLoaded(model) and timeout < 50 do
        Citizen.Wait(100)
        timeout = timeout + 1
    end
end

local function setupGangMember(ped, gang)
    local weapon = gang.weapons[math.random(1, #gang.weapons)]
    GiveWeaponToPed(ped, weapon, 9999, true, true)

    SetPedCombatAbility(ped, 100)
    SetPedCombatMovement(ped, 2)
    SetPedCombatRange(ped, 2)
    SetPedAccuracy(ped, math.random(30, 60))
    SetPedSeeingRange(ped, 100.0)
    SetPedHearingRange(ped, 80.0)

    SetPedCombatAttributes(ped, 0, true)
    SetPedCombatAttributes(ped, 1, true)
    SetPedCombatAttributes(ped, 2, true)
    SetPedCombatAttributes(ped, 5, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedCombatAttributes(ped, 52, true)

    SetPedFleeAttributes(ped, 0, false)

    SetEntityHealth(ped, math.random(200, 350))
    SetPedArmour(ped, math.random(0, 100))

    SetPedRelationshipGroupHash(ped, GetHashKey("GANG_" .. gang.name))
end

local function spawnGangMembers(gang)
    if gang.spawned then return end
    gang.spawned = true

    local zoneCenter = gang.zone
    local spawnCount = math.random(math.floor(gang.maxMembers * 0.6), gang.maxMembers)

    local relationshipGroup = GetHashKey("GANG_" .. gang.name)
    AddRelationshipGroup("GANG_" .. gang.name)
    SetRelationshipBetweenGroups(5, relationshipGroup, GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), relationshipGroup)

    for _, otherGang in ipairs(gangs) do
        if otherGang.name ~= gang.name then
            local otherGroup = GetHashKey("GANG_" .. otherGang.name)
            SetRelationshipBetweenGroups(5, relationshipGroup, otherGroup)
        end
    end

    SetRelationshipBetweenGroups(5, relationshipGroup, GetHashKey("COP"))
    SetRelationshipBetweenGroups(5, GetHashKey("COP"), relationshipGroup)

    local walkingCount = math.floor(spawnCount * 0.6)
    for i = 1, walkingCount do
        local offsetX = math.random(-math.floor(gang.radius * 0.7), math.floor(gang.radius * 0.7))
        local offsetY = math.random(-math.floor(gang.radius * 0.7), math.floor(gang.radius * 0.7))
        local spawnPos = vector3(zoneCenter.x + offsetX, zoneCenter.y + offsetY, zoneCenter.z)

        local foundGround, groundZ = GetGroundZFor_3dCoord(spawnPos.x, spawnPos.y, spawnPos.z + 100.0, false)
        if foundGround then
            spawnPos = vector3(spawnPos.x, spawnPos.y, groundZ + 1.0)
        end

        local model = gang.peds[math.random(1, #gang.peds)]
        loadModel(model)

        if HasModelLoaded(model) then
            local ped = CreatePed(4, model, spawnPos.x, spawnPos.y, spawnPos.z, math.random(0, 360) + 0.0, true, false)
            setupGangMember(ped, gang)

            local scenario = {"WORLD_HUMAN_HANG_OUT_STREET", "WORLD_HUMAN_SMOKING", "WORLD_HUMAN_DRUG_DEALER", "WORLD_HUMAN_STAND_IMPATIENT", "WORLD_HUMAN_GUARD_STAND"}
            TaskStartScenarioInPlace(ped, scenario[math.random(1, #scenario)], 0, true)
            SetPedKeepTask(ped, true)

            gang.members[#gang.members + 1] = { ped = ped, vehicle = nil }
            SetModelAsNoLongerNeeded(model)
        end
    end

    local vehicleCount = math.floor(spawnCount * 0.4 / 2)
    for i = 1, vehicleCount do
        local offsetX = math.random(-math.floor(gang.radius * 0.5), math.floor(gang.radius * 0.5))
        local offsetY = math.random(-math.floor(gang.radius * 0.5), math.floor(gang.radius * 0.5))
        local spawnPos = vector3(zoneCenter.x + offsetX, zoneCenter.y + offsetY, zoneCenter.z)

        local node, nodePos, heading = GetClosestVehicleNodeWithHeading(spawnPos.x, spawnPos.y, spawnPos.z, 1, 3.0, 0)
        if not node then
            nodePos = spawnPos
            heading = math.random(0, 360) + 0.0
        end

        local vehModel = gang.vehicles[math.random(1, #gang.vehicles)]
        loadModel(vehModel)

        if HasModelLoaded(vehModel) then
            local vehicle = CreateVehicle(vehModel, nodePos.x, nodePos.y, nodePos.z, heading, true, false)

            local r, g, b = gang.color[1], gang.color[2], gang.color[3]
            SetVehicleCustomPrimaryColour(vehicle, r, g, b)
            SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)

            local driverModel = gang.peds[math.random(1, #gang.peds)]
            loadModel(driverModel)

            if HasModelLoaded(driverModel) then
                local driver = CreatePedInsideVehicle(vehicle, 4, driverModel, -1, true, false)
                setupGangMember(driver, gang)
                TaskVehicleDriveWander(driver, vehicle, 15.0, 786603)
                SetPedKeepTask(driver, true)
                gang.members[#gang.members + 1] = { ped = driver, vehicle = vehicle }
                SetModelAsNoLongerNeeded(driverModel)
            end

            local passengerModel = gang.peds[math.random(1, #gang.peds)]
            loadModel(passengerModel)

            if HasModelLoaded(passengerModel) then
                local passenger = CreatePedInsideVehicle(vehicle, 4, passengerModel, 0, true, false)
                setupGangMember(passenger, gang)
                gang.members[#gang.members + 1] = { ped = passenger, vehicle = vehicle }
                SetModelAsNoLongerNeeded(passengerModel)
            end

            SetModelAsNoLongerNeeded(vehModel)
        end
    end
end

local function despawnGangMembers(gang)
    if not gang.spawned then return end

    for _, member in ipairs(gang.members) do
        if DoesEntityExist(member.ped) then
            DeletePed(member.ped)
        end
        if member.vehicle and DoesEntityExist(member.vehicle) then
            DeleteVehicle(member.vehicle)
        end
    end

    gang.members = {}
    gang.spawned = false
end

Citizen.CreateThread(function()
    for _, gang in ipairs(gangs) do
        local blip = AddBlipForRadius(gang.zone.x, gang.zone.y, gang.zone.z, gang.radius)
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, gang.blipColor)
        SetBlipAlpha(blip, 80)

        local iconBlip = AddBlipForCoord(gang.zone.x, gang.zone.y, gang.zone.z)
        SetBlipSprite(iconBlip, 310)
        SetBlipColour(iconBlip, gang.blipColor)
        SetBlipScale(iconBlip, 0.8)
        SetBlipAsShortRange(iconBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Gang: " .. gang.name)
        EndTextCommandSetBlipName(iconBlip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)

        local playerPos = GetEntityCoords(PlayerPedId())
        local inZone = nil

        for _, gang in ipairs(gangs) do
            local dist = #(playerPos - gang.zone)

            if dist < spawnDistance then
                if not gang.spawned then
                    spawnGangMembers(gang)
                end
            elseif dist > spawnDistance + 100.0 then
                if gang.spawned then
                    despawnGangMembers(gang)
                end
            end

            if dist < gang.radius then
                inZone = gang
            end
        end

        if inZone and inZone ~= currentGangZone then
            currentGangZone = inZone
            TriggerEvent('chat:addMessage', {
                color = inZone.color,
                args = {"[GANG ZONE]", "Kamu memasuki wilayah " .. inZone.name .. "! Hati-hati!"}
            })
        elseif not inZone and currentGangZone then
            TriggerEvent('chat:addMessage', {
                color = {200, 200, 200},
                args = {"[GANG ZONE]", "Kamu keluar dari wilayah gang."}
            })
            currentGangZone = nil
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        if currentGangZone then
            local gang = currentGangZone
            local r, g, b = gang.color[1], gang.color[2], gang.color[3]

            SetTextFont(4)
            SetTextScale(0.4, 0.4)
            SetTextColour(r, g, b, 220)
            SetTextDropshadow(1, 0, 0, 0, 200)
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString("~w~[ " .. gang.name .. " Territory ]")
            DrawText(0.5 - 0.06, 0.02)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)

        for _, gang in ipairs(gangs) do
            if gang.spawned then
                for i = #gang.members, 1, -1 do
                    local member = gang.members[i]
                    if not DoesEntityExist(member.ped) or IsEntityDead(member.ped) then
                        if DoesEntityExist(member.ped) then
                            SetEntityAsNoLongerNeeded(member.ped)
                        end
                        if member.vehicle and DoesEntityExist(member.vehicle) then
                            SetEntityAsNoLongerNeeded(member.vehicle)
                        end
                        table.remove(gang.members, i)
                    end
                end

                local deficit = gang.maxMembers - #gang.members
                if deficit >= 3 then
                    local respawnCount = math.random(2, math.min(deficit, 4))
                    for i = 1, respawnCount do
                        local offsetX = math.random(-math.floor(gang.radius * 0.7), math.floor(gang.radius * 0.7))
                        local offsetY = math.random(-math.floor(gang.radius * 0.7), math.floor(gang.radius * 0.7))
                        local spawnPos = vector3(gang.zone.x + offsetX, gang.zone.y + offsetY, gang.zone.z)

                        local foundGround, groundZ = GetGroundZFor_3dCoord(spawnPos.x, spawnPos.y, spawnPos.z + 100.0, false)
                        if foundGround then
                            spawnPos = vector3(spawnPos.x, spawnPos.y, groundZ + 1.0)
                        end

                        local model = gang.peds[math.random(1, #gang.peds)]
                        loadModel(model)

                        if HasModelLoaded(model) then
                            local ped = CreatePed(4, model, spawnPos.x, spawnPos.y, spawnPos.z, math.random(0, 360) + 0.0, true, false)
                            setupGangMember(ped, gang)
                            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
                            SetPedKeepTask(ped, true)
                            gang.members[#gang.members + 1] = { ped = ped, vehicle = nil }
                            SetModelAsNoLongerNeeded(model)
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent('chat:addMessage', {
            color = {255, 200, 0},
            multiline = true,
            args = {"[SECRET ROOM]", "Gang Zones aktif! 12 gang tersebar di seluruh peta. Cek blip di map!"}
        })
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, gang in ipairs(gangs) do
            despawnGangMembers(gang)
        end
    end
end)
