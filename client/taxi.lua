
RegisterNUICallback('GetAvailableTaxiDrivers', function(_, cb)
    QBCore.Functions.TriggerCallback('qb-phone:server:GetAvailableTaxiDrivers', function(drivers)
        cb(drivers)
    end)
end)