RegisterServerEvent('zSignLanguage:show3DText')
AddEventHandler('zSignLanguage:show3DText', function(text)
    local src = source
    TriggerClientEvent('zSignLanguage:display3DText', -1, src, text)

    -- Zpráva do chatu
    TriggerClientEvent('chat:addMessage', -1, {
        color = {255, 182, 193},
        args = {"Překlad", text}
    })
end)