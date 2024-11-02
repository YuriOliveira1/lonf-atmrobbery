local Config = lib.require('config')

local atms = {
    `prop_atm_01`,
    `prop_atm_02`,
    `prop_atm_03`,
    `prop_fleeca_atm`
}

-- Chamar os PM
function dropFingerprint()
    local src = source
    local player = GetPlayerPed(src)
    if Config.fingerPrintChance > math.random(0, 100) then
        local coords = GetEntityCoords(player)
        TriggerServerEvent('evidence:server:CreateFingerDrop', coords)
    end
end

local function afterRob()
    TriggerServerEvent('lonf-atmrobbery:server:sucessRob')
    TriggerServerEvent('hud:server:GainStress', math.random(12, 20))
end

local function atmDone(success)
    TriggerEvent('mhacking:hide')
    if not success then
        TriggerServerEvent('police:server:policeAlert')
    else
        afterRob()
        if not Config.robbed then
            Config.robbed = true
            Wait(Config.timeWait)
            Config.robbed = false
        end
    end
end

exports.ox_target:addModel(atms, {
    label = 'Hack ATM',
    name = 'Hack ATM',
    icon = 'fa fa-laptop',
    items = Config.item,
    onSelect = function()
        local cops = lib.callback.await('lonf-atmrobbery:server:getNumCops', 100)
        if cops > Config.minCops then
            if not Config.robbed then
                if lib.progressCircle({
                        duration = 8000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                            move = true,
                            combat = true,
                        },
                        anim = {
                            dict = 'anim@heists@ornate_bank@hack',
                            clip = 'hack_enter'
                        },
                    }) then
                    TriggerEvent('mhacking:show')
                    TriggerEvent('mhacking:start', math.random(3, 6), math.random(20, 40), atmDone)
                    dropFingerprint()
                else
                    lib.notify({
                        title = 'Notification title',
                        description = 'Notification description',
                        type = 'error'
                    })
                end
            else
                lib.notify({
                    title = 'Notification title',
                    description = 'Notification description',
                    type = 'error'
                })
            end
        end
    end
})
