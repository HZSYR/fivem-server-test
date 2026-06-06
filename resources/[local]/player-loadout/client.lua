local allWeapons = {
    `WEAPON_PISTOL`,
    `WEAPON_PISTOL_MK2`,
    `WEAPON_COMBATPISTOL`,
    `WEAPON_APPISTOL`,
    `WEAPON_STUNGUN`,
    `WEAPON_PISTOL50`,
    `WEAPON_SNSPISTOL`,
    `WEAPON_SNSPISTOL_MK2`,
    `WEAPON_HEAVYPISTOL`,
    `WEAPON_VINTAGEPISTOL`,
    `WEAPON_FLAREGUN`,
    `WEAPON_MARKSMANPISTOL`,
    `WEAPON_REVOLVER`,
    `WEAPON_REVOLVER_MK2`,
    `WEAPON_DOUBLEACTION`,
    `WEAPON_CERAMICPISTOL`,
    `WEAPON_NAVYREVOLVER`,
    `WEAPON_GADGETPISTOL`,
    `WEAPON_PISTOLXM3`,
    `WEAPON_MICROSMG`,
    `WEAPON_SMG`,
    `WEAPON_SMG_MK2`,
    `WEAPON_ASSAULTSMG`,
    `WEAPON_COMBATPDW`,
    `WEAPON_MACHINEPISTOL`,
    `WEAPON_MINISMG`,
    `WEAPON_RAYCARBINE`,
    `WEAPON_PUMPSHOTGUN`,
    `WEAPON_PUMPSHOTGUN_MK2`,
    `WEAPON_SAWNOFFSHOTGUN`,
    `WEAPON_ASSAULTSHOTGUN`,
    `WEAPON_BULLPUPSHOTGUN`,
    `WEAPON_MUSKET`,
    `WEAPON_HEAVYSHOTGUN`,
    `WEAPON_DOUBLEBARRELSHOTGUN`,
    `WEAPON_AUTOSHOTGUN`,
    `WEAPON_COMBATSHOTGUN`,
    `WEAPON_ASSAULTRIFLE`,
    `WEAPON_ASSAULTRIFLE_MK2`,
    `WEAPON_CARBINERIFLE`,
    `WEAPON_CARBINERIFLE_MK2`,
    `WEAPON_ADVANCEDRIFLE`,
    `WEAPON_SPECIALCARBINE`,
    `WEAPON_SPECIALCARBINE_MK2`,
    `WEAPON_BULLPUPRIFLE`,
    `WEAPON_BULLPUPRIFLE_MK2`,
    `WEAPON_COMPACTRIFLE`,
    `WEAPON_MILITARYRIFLE`,
    `WEAPON_HEAVYRIFLE`,
    `WEAPON_TACTICALRIFLE`,
    `WEAPON_MG`,
    `WEAPON_COMBATMG`,
    `WEAPON_COMBATMG_MK2`,
    `WEAPON_GUSENBERG`,
    `WEAPON_SNIPERRIFLE`,
    `WEAPON_HEAVYSNIPER`,
    `WEAPON_HEAVYSNIPER_MK2`,
    `WEAPON_MARKSMANRIFLE`,
    `WEAPON_MARKSMANRIFLE_MK2`,
    `WEAPON_PRECISIONRIFLE`,
    `WEAPON_RPG`,
    `WEAPON_GRENADELAUNCHER`,
    `WEAPON_GRENADELAUNCHER_SMOKE`,
    `WEAPON_MINIGUN`,
    `WEAPON_FIREWORK`,
    `WEAPON_RAILGUN`,
    `WEAPON_HOMINGLAUNCHER`,
    `WEAPON_COMPACTLAUNCHER`,
    `WEAPON_RAYMINIGUN`,
    `WEAPON_EMPLAUNCHER`,
    `WEAPON_GRENADE`,
    `WEAPON_BZGAS`,
    `WEAPON_MOLOTOV`,
    `WEAPON_STICKYBOMB`,
    `WEAPON_PROXMINE`,
    `WEAPON_SNOWBALL`,
    `WEAPON_PIPEBOMB`,
    `WEAPON_BALL`,
    `WEAPON_SMOKEGRENADE`,
    `WEAPON_FLARE`,
    `WEAPON_KNIFE`,
    `WEAPON_NIGHTSTICK`,
    `WEAPON_HAMMER`,
    `WEAPON_BAT`,
    `WEAPON_GOLFCLUB`,
    `WEAPON_CROWBAR`,
    `WEAPON_BOTTLE`,
    `WEAPON_DAGGER`,
    `WEAPON_HATCHET`,
    `WEAPON_MACHETE`,
    `WEAPON_FLASHLIGHT`,
    `WEAPON_SWITCHBLADE`,
    `WEAPON_BATTLEAXE`,
    `WEAPON_POOLCUE`,
    `WEAPON_STONE_HATCHET`,
    `WEAPON_KNUCKLE`,
    `WEAPON_PARACHUTE`,
    `WEAPON_FIREEXTINGUISHER`,
    `WEAPON_PETROLCAN`,
    `WEAPON_NIGHTVISION`,
    `WEAPON_HAZARDCAN`,
}

local function playLoadoutEffect()
    AnimpostfxPlay("SuccessMichael", 0, false)
    PlaySoundFrontend(-1, "PICK_UP_WEAPON", "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET", true)
    Wait(500)
    PlaySoundFrontend(-1, "Weapon_Purchase", "DLC_GUN_RUNNING_WEAPONS_SHOP_SOUNDSET", true)
end

local function giveAllWeapons()
    local ped = PlayerPedId()

    if not DoesEntityExist(ped) or IsEntityDead(ped) then return end

    for _, weapon in ipairs(allWeapons) do
        GiveWeaponToPed(ped, weapon, 9999, false, false)
    end

    SetPedInfiniteAmmo(ped, true, 0)
    SetPedInfiniteAmmoClip(ped, true)

    playLoadoutEffect()

    TriggerEvent('chat:addMessage', {
        color = {255, 165, 0},
        multiline = true,
        args = {"[SECRET ROOM]", "Arsenal lengkap diterima! Unlimited ammo aktif!"}
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = PlayerPedId()
        if DoesEntityExist(ped) and not IsEntityDead(ped) then
            SetPedInfiniteAmmo(ped, true, 0)
            SetPedInfiniteAmmoClip(ped, true)
        end
    end
end)

AddEventHandler('playerSpawned', function()
    Wait(1500)
    giveAllWeapons()
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Wait(3000)
        giveAllWeapons()
    end
end)

RegisterCommand('loadout', function()
    giveAllWeapons()
end, false)

TriggerEvent('chat:addSuggestion', '/loadout', 'Ambil semua senjata + unlimited ammo')
