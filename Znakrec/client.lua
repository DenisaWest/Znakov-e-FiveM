RegisterCommand('z', function(source, args)
   local text = table.concat(args, " ")
   if text == "" then
       TriggerEvent('chat:addMessage', {
           color = { 255, 0, 0 },
           multiline = true,
           args = {"System", "Použití: /z <text>"}
       })
       return
   end

   -- Spuštění animace Argue
   RequestAnimDict("misscarsteal4@actor")
   while not HasAnimDictLoaded("misscarsteal4@actor") do
       Wait(0)
   end
   TaskPlayAnim(PlayerPedId(), "misscarsteal4@actor", "actor_berating_loop", 8.0, -8.0, -1, 49, 0, false, false, false)

   -- Zobrazení 3D textu nad hlavou hráče
   TriggerServerEvent('zSignLanguage:show3DText', text)

   -- Po 5 vteřinách zastavit animaci
   SetTimeout(5000, function()
       ClearPedTasks(PlayerPedId())
   end)
end, false)

-- Přijetí eventu od serveru pro zobrazení textu
RegisterNetEvent('zSignLanguage:display3DText')
AddEventHandler('zSignLanguage:display3DText', function(serverId, message)
   local player = GetPlayerFromServerId(serverId)
   if player ~= -1 then
       local ped = GetPlayerPed(player)
       local coords = GetEntityCoords(ped)
       local displayTime = 5000 -- 5 vteřin
       local startTime = GetGameTimer()

       CreateThread(function()
           while GetGameTimer() - startTime < displayTime do
               coords = GetEntityCoords(ped)
               DrawText3D(coords.x, coords.y, coords.z + 1.0, "~p~Osoba Znakuje")
               Wait(0)
           end
       end)
   end
end)

-- Funkce pro vykreslení 3D textu
function DrawText3D(x, y, z, text)
   local onScreen, _x, _y = World3dToScreen2d(x, y, z)
   local px, py, pz = table.unpack(GetGameplayCamCoords())
   SetTextScale(0.35, 0.35)
   SetTextFont(4)
   SetTextProportional(1)
   SetTextColour(255, 105, 180, 215) -- růžová
   SetTextEntry("STRING")
   SetTextCentre(1)
   AddTextComponentString(text)
   DrawText(_x, _y)
   local factor = (string.len(text)) / 370
   DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 100)
end