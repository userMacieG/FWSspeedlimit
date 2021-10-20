local currentSpeedlimit, newSpeedLimit = "N/A", "N/A"

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed) then
			local playerCoords = GetEntityCoords(playerPed)
			local zone = GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z)

			if Config.Speedlimits[zone] then
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
		else
			SendNUIMessage({
				speedlimit = currentSpeedlimit,
				show = false
			})
		end
	end
end)
