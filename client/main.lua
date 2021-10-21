local currentSpeedlimit, newSpeedLimit = "N/A", "N/A"

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			if Config.OnlyDriver then
				local vehicle = GetVehiclePedIsIn(playerPed, false)

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					updateSpeedlimit(playerPed)
				end
			else
				updateSpeedlimit(playerPed)
			end
		else
			currentSpeedlimit, newSpeedLimit = "N/A", "N/A"

			SendNUIMessage({
				speedlimit = currentSpeedlimit,
				show = false
			})
		end
	end
end)

function updateSpeedlimit(playerPed)
	local playerCoords = GetEntityCoords(playerPed)
	local zone = GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z)

	if Config.Speedlimits[zone] ~= nil then
		newSpeedLimit = Config.Speedlimits[zone]
	else
		newSpeedLimit = "N/A"
	end

	if currentSpeedlimit ~= newSpeedLimit then
		currentSpeedlimit = newSpeedLimit

		SendNUIMessage({
			speedlimit = newSpeedLimit,
			show = true
		})
	end
end
