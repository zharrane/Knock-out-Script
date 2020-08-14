
--┌≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈┐
--│                                                       │
--│  #     Knocked Out                                    │
--│                                                       │
--│                                                       │
--│  Knockout With effect {When knocked out,              │ 
--│        While knocked out}                             │
--│                                                       │
--│                                                       │
--│                                                       │
--│                                                       │
--│  Made by : https://forum.cfx.re/u/Cosmo               │ 
--│  @ Modification upon need by Rango!(zaki)             │
--│                                                       │
--│  Contact (discord) : Zaki#1196                        │
--│                                                       │
--└≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈┘

local knockedOut = false
local wait = 15
local count = 60


Citizen.CreateThread(function()
	while true do
		Wait(1)
        local myPed = GetPlayerPed(-1)
        -- With melee weapon or unarmed only
        if IsPedInMeleeCombat(myPed) then
            -- Without any kind of weapon
            if (HasPedBeenDamagedByWeapon(myPed, GetHashKey("WEAPON_UNARMED"), 0) )then
                -- Health to be knocked out
                if GetEntityHealth(myPed) < 145 then
                    SetPlayerInvincible(PlayerId(), false)
                    -- Position taken by your Ped
					SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
					--  Effect 
					ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 2.5)
					-- Time to wait
                    wait = 15
                    --** Add progress Bar here if you wand **--
					knockedOut = true
					-- Health after knockout preferably dont make it more than 150 (50 %) because people will abuse with it {No need to go to hospital or so}
					SetEntityHealth(myPed, 140)
				end
			end
		end
		
		if knockedOut == true then		
			--Your ped is able to die
			SetPlayerInvincible(PlayerId(), false)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			-- Red Cam
			SetTimecycleModifier("REDMIST")
			-- Cam vibration
			ShakeGameplayCam("VIBRATE_SHAKE", 1.0)
			if wait >= 0 then
				count = count - 1
                if count == 0 then
                    
					count = 60
					wait = wait - 1
					--- in case bark
                    if GetEntityHealth(myPed) <= 50 then
                        -- Ped healing 
						SetEntityHealth(myPed, GetEntityHealth(myPed)+2)
						
					end
				end
            else
                -- Remove red cam
				SetTimecycleModifier("")
                SetTransitionTimecycleModifier("")		
                -- Ped Able to die again
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end

	end
end)