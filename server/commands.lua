

QBCore.Commands.Add("setmetadata", "Set Player Metadata (God Only)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if args[1] then
        if args[1] == "trucker" then
            if args[2] then
                local newrep = Player.PlayerData.metadata["jobrep"]
                newrep.trucker = tonumber(args[2])
                Player.Functions.SetMetaData("jobrep", newrep)
            end
        end
    end
end, "god")

QBCore.Commands.Add("p#", "Provide Phone Number", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerPed = GetPlayerPed(src)
    local number = Player.PlayerData.charinfo.phone
	local PlayerCoords = GetEntityCoords(PlayerPed)
	for _, v in pairs(QBCore.Functions.GetPlayers()) do
		local TargetPed = GetPlayerPed(v)
		local dist = #(PlayerCoords - GetEntityCoords(TargetPed))

		if dist < 3.0 then
            TriggerClientEvent('chat:addMessage', v, {
                color = { 255, 0, 0},
                multiline = true,
                args = {"Phone #", number}
            })
		end
	end
end)


QBCore.Commands.Add('setjob', 'Set A Players Job (Admin Only)', { { name = 'id', help = 'Player ID' }, { name = 'job', help = 'Job name' }, { name = 'grade', help = 'Grade' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        local job = tostring(args[2])
        local grade = tonumber(args[3])
        local sgrade = tostring(args[3])
        local jobInfo = QBCore.Shared.Jobs[job]
        if jobInfo then
            if jobInfo["grades"][sgrade] then
                Player.Functions.SetJob(job, grade)
                exports['ks-phone']:hireUser(job, Player.PlayerData.citizenid, grade)
            else
                TriggerClientEvent('QBCore:Notify', source, "Not a valid grade", 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Not a valid job", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')


QBCore.Commands.Add('removejob', 'Removes A Players Job (Admin Only)', { { name = 'id', help = 'Player ID' }, { name = 'job', help = 'Job name' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        if Player.PlayerData.job.name == tostring(args[2]) then
            Player.Functions.SetJob("unemployed", 0)
        end
        exports['ks-phone']:fireUser(tostring(args[2]), Player.PlayerData.citizenid)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')
