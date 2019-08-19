ESX = nil
local v1 = vector3(-1043.493, -2661.503, 14.950)
local onmenu = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    locationblip = AddBlipForCoord(-1043.493, -2661.503, 13.830)
    SetBlipSprite(locationblip, 315)
    SetBlipDisplay(locationblip, 4)
    SetBlipScale(locationblip, 0.9)
    SetBlipColour(locationblip, 3)
    SetBlipAsShortRange(locationblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("~b~Location")
    EndTextCommandSetBlipName(locationblip)

    local hash = GetHashKey("s_m_m_gardener_01")

    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end

	local ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_gardener_01", -1043.493, -2661.503, 12.830, 224.591, true, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)

    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -1043.493, -2661.503, 13.830)

            if dist <= 1.2 and onmenu == false then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour intéragir avec ~b~Bernard")
			if IsControlJustPressed(1, 51) then 
                mainMenu:Visible(not mainMenu:Visible())
                onmenu = true
			end
        end

        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < 20 and onmenu == false then
            Draw3DText(v1.x,v1.y,v1.z, "Bernard")
        end
    end
end)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Location","Liste", 5, 300, "shopui_title_ie_modgarage", "shopui_title_ie_modgarage")
_menuPool:Add(mainMenu)

local spawnCar = function(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(car, -1038.4711914063, -2665.87890625, 13.830752372742, 0.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "LOCATION")
end

Draw3DText = function(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local AddCarMenu = function(menu)

    local carsubmenu = _menuPool:AddSubMenu(menu, "Voiture", "Choisissez une voiture", 5, 300, "shopui_title_ie_modgarage", "shopui_title_ie_modgarage")
    carsubmenu.Item:SetRightBadge(BadgeStyle.Car)

    local motosubmenu = _menuPool:AddSubMenu(menu, "Moto", "Choisissez une moto", 5, 300, "shopui_title_ie_modgarage", "shopui_title_ie_modgarage")
    motosubmenu.Item:SetRightBadge(BadgeStyle.Bike)
    
    local velosubmenu = _menuPool:AddSubMenu(menu, "Vélo", "Choisissez un vélo", 5, 300, "shopui_title_ie_modgarage", "shopui_title_ie_modgarage")
    velosubmenu.Item:SetRightBadge(BadgeStyle.Bike)

    local blista = NativeUI.CreateItem("Blista", "")
    carsubmenu.SubMenu:AddItem(blista)
    blista:RightLabel("~g~800$")

    local vespa = NativeUI.CreateItem("Vespa", "")
    motosubmenu.SubMenu:AddItem(vespa)
    vespa:RightLabel("~g~500$")

    local bmx = NativeUI.CreateItem("BMX", "")
    velosubmenu.SubMenu:AddItem(bmx)
    bmx:RightLabel("~g~00$")

    carsubmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == blista then
            onmenu = false
            blista:SetRightBadge(BadgeStyle.Car)
            TriggerServerEvent('buyBlista')
            ESX.ShowNotification('Patientez...')
            Citizen.Wait(10000)
            spawnCar("blista")
            ESX.ShowNotification('Vous avez payez ~r~800$')
            ESX.ShowAdvancedNotification("Location", "Votre ~b~véhicule ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus()
        end
    end

    motosubmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == vespa then
            onmenu = false
            vespa:SetRightBadge(BadgeStyle.Bike)
            TriggerServerEvent('buyVespa')
            ESX.ShowNotification('Patientez...')
            Citizen.Wait(10000)
            spawnCar("faggio2")
            ESX.ShowNotification('Vous avez payez ~r~500$')
            ESX.ShowAdvancedNotification("Location", "Votre ~b~moto ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus()
        end
    end

    velosubmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == bmx then
            onmenu = false
            TriggerServerEvent('buyBmx')
            ESX.ShowNotification('Patientez...')
            Citizen.Wait(10000)
            spawnCar("bmx")
            ESX.ShowNotification('Vous avez payez ~r~200$')
            ESX.ShowAdvancedNotification("Location", "Votre ~b~vélo ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
            ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
            _menuPool:CloseAllMenus()
        end
    end

    menu.OnMenuClosed = function()
        onmenu = false
    end
end
        
AddCarMenu(mainMenu)
_menuPool:RefreshIndex()
_menuPool:MouseEdgeEnabled (false);
