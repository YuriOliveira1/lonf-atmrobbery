local Config = lib.require('Config')

RegisterNetEvent('lonf-atmrobbery:server:sucessRob', function()
    print("Evento chamado no servidor")  -- Confirma que o evento foi chamado
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    
    local reward = math.random(Config.minReward, Config.maxReward)
    player.Functions.AddMoney('cash', reward)
    TriggerClientEvent('lonf-atmrobbery:server:sucessRob')
end)

lib.callback.register('lonf-atmrobbery:server:getNumCops', function (source)
    return exports.qbx_core:GetDutyCountType('leo')
end)
