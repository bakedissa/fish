--[[
    =====================================================================
    -- ## ADVANCED STARTER ROUTINE (HYBRID STABILITY VERSION) ##
    =====================================================================
    -- This version uses the stable main loop from V13 and adds the
    -- features from V14.1, like Genie Quests and new potion logic.
]]

--[[
    ============================================================
    -- ## STARTER ROUTINE CONFIGURATION ##
    ============================================================
]]
local StarterConfig = {
    USE_THIRD_PART_AUTOFARM = true, -- <<<<< NEW VARIABLE
    -- ## MASTER TOGGLE ##
    StarterRoutineActive = true,

    -- ## MAIN GOAL ##
    PATH_TO_FESTIVAL = false,
    FESTIVAL_UNLOCK_GEMS = 150000,

    -- ## V14.1 FEATURES ##
    ENABLE_GENIE_QUESTS = true,
    ENABLE_AUTO_POTION_CRAFT = true,
    ENABLE_AUTO_MAX_PETS = true,
    PotionsToCraft = {"Coins", "Lucky", "Mythic", "Speed"},
    DONT_USE_T1_POTIONS = true,

    -- ## V14.1 POTION USAGE ##
    USE_POTIONS_ON_START = {"Coins", "Lucky", "Speed", "Infinity Elixir", "Egg Elixir", "Coins", "Lucky", "Speed", "Infinity Elixir", "Infinity Elixir", "Infinity Elixir", "Infinity Elixir", "Infinity Elixir", "Egg Elixir"},
    USE_BEST_POTIONS_AFTER_FESTIVAL_UNLOCK = true,
    POTIONS_TO_USE_AFTER_FESTIVAL_UNLOCK = {"Lucky", "Mythic", "Speed", "Lucky", "Mythic", "Speed", "Mythic", "Speed", "Infinity Elixir", "Egg Elixir", "Egg Elixir", "Infinity Elixir", "Infinity Elixir", "Infinity Elixir", "Infinity Elixir"},
    POTION_USAGE_CAP = 0,
    MAX_POTION_TIER_TO_USE = 5,
    
    -- ## PROGRESS & SPEED ##
    RESET_PROGRESS_ON_EXECUTE = false,
    PROGRESS_FILE_NAME = "StarterRoutineProgress.json",
    TWEEN_SPEED = 50,

    -- ## FEATURE TOGGLES ##
    ENABLE_PLAYTIME_REWARDS = true,
    ENABLE_CHEST_FARMING = true,
    ENABLE_WHEEL_SPIN = true,
    ENABLE_SHINY_CRAFTING = true,

    -- ## MASTERY GOALS ##
    TARGET_MASTERY_LEVELS = { Pets = 15, Buffs = 18, Shops = 0, Minigames = 0, Rifts = 0 },

    -- ## PET DELETION & CRAFTING ##
    RARITY_TO_DELETE = {"Common", "Unique", "Rare"},
    MAX_LEGENDARY_TIER_TO_DELETE = 0,
    RARITY_TO_SHINY = {"Common", "Unique", "Rare", "Epic", "Legendary"},
    SHINY_CRAFT_INTERVAL = 10,

    -- ## PICKUP & HATCHING SETTINGS ##
    PICKUP_CLEANUP_INTERVAL = 15.0,
    PICKUP_DELETION_GRACE_PERIOD = 10.0,
    INITIAL_HATCH_DURATION = 15.0,
    MASTERY_UPGRADE_DELAY = 180,
    UPGRADE_PURCHASE_DELAY = 2.0,
    HatchWhileFarmingGemsAndCoins = true,
    HatchWhileFarmingFestivalCoins = true,

    -- NEW FEATURE: Stop hatching after 2000 hatches before World 2 unlock (Zen only)
    STOP_HATCHING_AFTER_2000_HATCHES_BEFORE_WORLD2 = true,
    HATCH_LIMIT_BEFORE_WORLD2 = 2000,
}
getgenv().StarterConfig = StarterConfig

-- ============================================================
-- THIRD PARTY AUTOFARM LOADER
-- ============================================================
local function initThirdPartyAutofarm()
    print("[THIRD-PARTY] Initializing IdiotHub autofarm...")

    local folderName = "IdiotHub"
    local configFiles = {
        ["bgsiEggs.json"] = "{}",
        ["Bubble Gum Simulator Infinity.rfld"] = [[{"AutoCompetitionQuests":false,"ShinyRatio":"0","alien-shop":[],"fishing-shop":[],"HideHatchAnim":false,"SelectMasteries":[],"GameEggPriority":false,"SellSlider":100,"AutoDiceChest":false,"Webhook":"","shard-shop":[],"UniqueEggToHatch":["Infinity Egg"],"EpicEggToHatch":["Infinity Egg"],"NormalRatio":"0","SelectTeamThe Overworld":[],"AutoChest":false,"EnchantMethod":["Gems first, get one, use reroll Orb"],"AutoMastery":false,"SelectChests":[],"Autofestival-shop":false,"AutoCartEscape":false,"SpecificRatio":"0","SelectDonateItems":[],"RareEggToHatch":["Infinity Egg"],"SelectEgg":[],"StartEnchanting":false,"SelectPotionsToUseRift10":[],"AutoPlaytime":false,"SelectPotionsToUseRift1":[],"CommonEggToHatch":["Infinity Egg"],"LegendaryEggToHatch":["Infinity Egg"],"AutoPetMatch":false,"dice-shop":[],"AutoShrine":false,"AlwaysNotifySecrets":true,"AutoGoldChest":false,"BlessingTime":1,"ShinyOnly":false,"Autodice-shop":false,"MythicEggToHatch":["Infinity Egg"],"AutoGoToRiftEggs":true,"GoldKeySlider":1,"MinigameDifficulties":["Insane"],"AutoRiftGift":false,"AutoRoyalChest":false,"SelectTiles":[],"AutoOpenEgg":false,"AutoSpinWheel":false,"DetermineBestEgg":["Mythic","Legendary","Epic","Rare","Unique","Common"],"AutoCoinsForce":true,"AutoSellBubble":false,"SelectPotionsToUseNormal":[],"Autoshard-shop":false,"traveling-merchant":[],"Autotraveling-merchant":false,"RareEggPriority":false,"AutoPotion":false,"AutoBubble":false,"SelectSellLocation":[],"MythicOnly":false,"AutoRollDice":false,"AutoFishing":false,"RenderDistance":2,"HatchAmount":[],"festival-shop":[],"AutoCoins":true,"EnabledQuestTypes":["Mythic","Shiny","SpecificRarity","SpecificEgg","Normal"],"AutoHyperDarts":false,"Autofishing-shop":false,"AutoPressE":false,"AutoRobotClaw":false,"SelectPotionsToUseRift25":[],"MythicRatio":"0","SelectMinigamesToSkipTime":[],"SelectPotionsToUseAura":[],"SelectEggRift":[],"AutoDogRun":false,"NotifyLegendary":true,"Autoalien-shop":false,"SelectedEnchants":["gleaming 1"],"ShinyMythicOnly":false,"HideTransition":true,"SelectPotionsToUseRift5":[],"AutoMysteryBox":false,"SelectTeamMinigame Paradise":[],"PreferredEggToHatch":["Infinity Egg"],"MinimumRarity":"69420","AutoClaimFreeSpin":false}]]
    }
    if not isfolder(folderName) then
        makefolder(folderName)
    end
    for fileName, content in pairs(configFiles) do
        local filePath = folderName .. "/" .. fileName
        if not isfile(filePath) then
            writefile(filePath, content)
        end
    end

    getgenv().boardSettings = {
        UseGoldenDice = true,
        GoldenDiceDistance = 1,
        DiceDistance = 6,
        GiantDiceDistance = 10,
    }

    getgenv().remainingItems = {} 

    loadstring(game:HttpGet("https://raw.githubusercontent.com/IdiotHub/Scripts/refs/heads/main/BGSI/main.lua"))()
    print("[THIRD-PARTY] IdiotHub autofarm script loaded.")
end


--[[
    ============================================================
    -- CORE SCRIPT (No need to edit below this line)
    ============================================================
]]

-- ## Services & Modules ##
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RemoteEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent")
local RemoteFunction = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteFunction")
local LocalData = require(ReplicatedStorage.Client.Framework.Services.LocalData)
local PetDatabase = require(ReplicatedStorage.Shared.Data.Pets)
local MasteryData = require(ReplicatedStorage.Shared.Data.Mastery)

-- ## State Variables ##
local State = {
    isTeleporting = false,
    isPetDeletionActive = false,
    isVoidChestRoutineActive = false,
    isClaimingChest = false, -- Flag to halt the main loop
    currentFarmingLocation = "Zen",
    currentQuestTask = "None",
    nextPickupCleanup = 0
}

local function getChestTime(chestType)
    local label
    local success, calculatedTime = pcall(function()
        if chestType == "Void" then
            label = workspace.Rendered.Generic["Void Chest"].Countdown.BillboardGui.Label
        elseif chestType == "Giant" then
            label = workspace.Rendered.Generic["Giant Chest"].Countdown.BillboardGui.Label
        end

        if not label or not label.Text then
            return 9999 -- Return a long cooldown if the label isn't found
        end

        local text = label.Text
        if text == "" or text:lower():match("ready") or text:lower():match("claim") then
            return 0 -- Chest is ready
        end

        local m_ss_minutes, m_ss_seconds = text:match("(%d+):(%d+)")
        if m_ss_minutes and m_ss_seconds then
            return (tonumber(m_ss_minutes) * 60) + tonumber(m_ss_seconds)
        end

        local minutes_only = text:match("(%d+)m")
        if minutes_only then
            return tonumber(minutes_only) * 60
        end

        local seconds_only = text:match("(%d+)s")
        if seconds_only then
            return tonumber(seconds_only)
        end

        return 9999 -- Return a long cooldown if text parsing fails
    end)

    if success then
        return calculatedTime
    else
        warn("[ERROR] Failed to get chest time for: " .. chestType)
        return 9999 -- Return a long cooldown on critical failure
    end
end


local shinyRequirements = {["Common"] = 16, ["Unique"] = 16, ["Rare"] = 12, ["Epic"] = 12, ["Legendary"] = 10}
local potionRequirements = { [2] = 5, [3] = 5, [4] = 4, [5] = 4 }
local function useAllGoldenOrbs()
    local playerData = LocalData:Get()
    if not (playerData and playerData.Powerups) then return end

    local orbName = "Golden Orb"
    local amount = playerData.Powerups[orbName] or 0
    if amount > 0 then
        print("[CHEST MANAGER] Using "..amount.."x Golden Orbs...")
        RemoteEvent:FireServer("UseGift", orbName, amount)
        task.wait(1)
    else
        print("[CHEST MANAGER] No Golden Orbs to use.")
    end
end
-- Background: Keep AutoBubble active and sell bubbles constantly
local function startAutoBubbleAndSellRoutine()
    task.spawn(function()
        print("[BUBBLE MANAGER] Starting auto bubble & sell routine...")
        local targetColor = Color3.new(0.14902, 0.901961, 0.14902)
        local uiWaitTimeout = 5

        -- Wait for UI elements once
        local button
        pcall(function()
            local playerGui = LocalPlayer:WaitForChild("PlayerGui")
            button = playerGui:WaitForChild("ScreenGui", uiWaitTimeout)
                              :WaitForChild("HUD", uiWaitTimeout)
                              :WaitForChild("Left", uiWaitTimeout)
                              :WaitForChild("Currency", uiWaitTimeout)
                              :WaitForChild("Bubble", uiWaitTimeout)
                              :WaitForChild("Frame", uiWaitTimeout)
                              :WaitForChild("AutoBubble", uiWaitTimeout)
                              :WaitForChild("Button", uiWaitTimeout)
        end)

        while getgenv().StarterConfig.StarterRoutineActive do
            -- Keep AutoBubble on
            pcall(function()
                if button then
                    local attributeValue = button:GetAttribute("BaseAutoColor")
                    if attributeValue then
                        local colorToCompare
                        if typeof(attributeValue) == "Color3" then
                            colorToCompare = attributeValue
                        elseif typeof(attributeValue) == "ColorSequence" and #attributeValue.Keypoints > 0 then
                            colorToCompare = attributeValue.Keypoints[1].Value
                        end
                        if colorToCompare then
                            local colorVector = Vector3.new(colorToCompare.R, colorToCompare.G, colorToCompare.B)
                            local targetVector = Vector3.new(targetColor.R, targetColor.G, targetColor.B)
                            if (colorVector - targetVector).Magnitude > 0.01 then
                                button:SetAttribute("Pressed", true)
                                task.wait(0.1)
                                button:SetAttribute("Pressed", false)
                            end
                        end
                    end
                end
            end)

            -- Sell bubbles
            pcall(function()
                RemoteEvent:FireServer("SellBubble")
            end)

            task.wait(1) -- every second
        end
    end)
end


local function teleportAndConfirm(dest, isAtLocation, maxRetries, timeout)
    maxRetries = maxRetries or 3
    timeout = timeout or 8
    for attempt = 1, maxRetries do
        print(("[TELEPORT] Attempt #%d to %s"):format(attempt, dest))
        State.isTeleporting = true
        pcall(function()
            RemoteEvent:FireServer("Teleport", dest)
        end)

        local startTime = tick()
        while tick() - startTime < timeout do
            if isAtLocation and isAtLocation() then
                print("[TELEPORT] Arrived successfully at", dest)
                State.isTeleporting = false
                return true
            end
            task.wait(0.2)
        end

        warn("[TELEPORT] Attempt #" .. attempt .. " failed to arrive. Retrying...")
    end

    State.isTeleporting = false
    warn("[TELEPORT] Failed to reach " .. dest .. " after " .. maxRetries .. " attempts.")
    return false
end

local function saveProgress(p) if writefile then pcall(function() writefile(StarterConfig.PROGRESS_FILE_NAME, HttpService:JSONEncode(p)) end) end end
local function loadProgress() local pD={unlocked_islands=false,redeemed_codes=false,opened_boxes=false,initial_hatch_done=false,purchased_free_masteries=false};if isfile and isfile(StarterConfig.PROGRESS_FILE_NAME)then local fC=readfile(StarterConfig.PROGRESS_FILE_NAME);if fC and fC~=""then local s,dD=pcall(HttpService.JSONDecode,HttpService,fC);if s then for k,v in pairs(dD)do pD[k]=v end;print("[PROGRESS] Loaded saved progress.")else warn("Could not parse progress file.")end end end;return pD end
local function getCurrency(cT) local pD=LocalData:Get();return pD and pD[cT]or 0 end
local function tweenTo(pos) local char=LocalPlayer.Character;local rP=char and char:FindFirstChild("HumanoidRootPart");if not rP then return end;local dist=(rP.Position-pos).Magnitude;local time=dist/StarterConfig.TWEEN_SPEED;local tween=TweenService:Create(rP,TweenInfo.new(time,Enum.EasingStyle.Linear),{CFrame=CFrame.new(pos)});tween:Play();tween.Completed:Wait()end
local function pressE() VirtualInputManager:SendKeyEvent(true,Enum.KeyCode.E,false,game);task.wait(0.1);VirtualInputManager:SendKeyEvent(false,Enum.KeyCode.E,false,game)end
local function isPlayerInArea(area) local rP=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");if not rP then return false end;if area=="Zen"then return rP.Position.Y>15000 end;if area=="Festival" then return rP.Position.Z > 150 end;return false end
local function teleportTo(dest) State.isTeleporting=true;print("[TELEPORT] Pausing background tasks...");pcall(function()RemoteEvent:FireServer("Teleport",dest)end);task.wait(5);print("[TELEPORT] Resuming background tasks.");State.isTeleporting=false end
local function getPetTier(petName) local T1={["Emerald Golem"]=true,["Inferno Dragon"]=true,["Unicorn"]=true,["Flying Pig"]=true,["Lunar Serpent"]=true,["Electra"]=true,["Dark Serpent"]=true,["Inferno Cube"]=true,["Crystal Unicorn"]=true,["Cyborg Phoenix"]=true,["Neon Wyvern"]=true};local T2={["Neon Elemental"]=true,["Green Hydra"]=true,["Stone Gargoyle"]=true,["Gummy Dragon"]=true};local T3={["NULLVoid"]=true,["Virus"]=true,["Demonic Hydra"]=true,["Hexarium"]=true,["Rainbow Shock"]=true,["Space Invader"]=true,["Bionic Shard"]=true,["Neon Wire Eye"]=true,["Equalizer"]=true,["Candy Winged Hydra"]=true,["Rock Candy Golem"]=true};if T1[petName]then return 1 end;if T2[petName]then return 2 end;if T3[petName]then return 3 end;return 0 end
local function getNormalPetCounts() local pD=LocalData:Get();if not(pD and pD.Pets)then return{}end;local pG={};for _,pI in pairs(pD.Pets)do if not pI.Shiny and not pI.Mythic then if not pG[pI.Name]then pG[pI.Name]={Count=0,Instances={}}end;pG[pI.Name].Count=pG[pI.Name].Count+(pI.Amount or 1);table.insert(pG[pI.Name].Instances,pI)end end;return pG end
local function collectNearbyPickups() if State.isTeleporting or State.isClaimingChest then return end;local cR=ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup");local rF=workspace:WaitForChild("Rendered");for _,c in ipairs(rF:GetChildren())do if c.Name=="Chunker"then for _,i in ipairs(c:GetChildren())do if not string.match(i.Name,"Egg")and i:GetAttribute("MarkedForDeletionTime")==nil then i:SetAttribute("MarkedForDeletionTime",tick());pcall(function()cR:FireServer(i.Name);task.wait()end)end end end end end
local function cleanupLocalPickups() if State.isTeleporting or State.isClaimingChest then return end;print("[CLEANUP] Checking for old pickup models to clear...");local rendered=workspace:FindFirstChild("Rendered");if not rendered then return end;local pC=0;for _,chunker in ipairs(rendered:GetChildren())do if chunker.Name=="Chunker"then for _,item in ipairs(chunker:GetChildren())do local mT=item:GetAttribute("MarkedForDeletionTime");if mT then if(tick()-mT)>StarterConfig.PICKUP_DELETION_GRACE_PERIOD then item:Destroy();pC=pC+1 end end end end end;if pC>0 then print("[CLEANUP] Removed "..pC.." old models.")end end
local function useSpecificPotions(potionNameList, usageCap, bypassTierCheck)
    if State.isTeleporting then return end
    if State.isClaimingChest then
        warn("[POTIONS] Skipped potion usage because chest claim is active.")
        return
    end

    local playerData = LocalData:Get()
    if not (playerData and playerData.Potions) then return end

    local bestPotions = {}
    for _, potionData in pairs(playerData.Potions) do
        if bypassTierCheck or (potionData.Level <= StarterConfig.MAX_POTION_TIER_TO_USE) then
            if not bestPotions[potionData.Name] or potionData.Level > bestPotions[potionData.Name].Level then
                bestPotions[potionData.Name] = {
                    Level = potionData.Level,
                    Name = potionData.Name,
                    Amount = potionData.Amount
                }
            end
        end
    end

    for _, potionName in ipairs(potionNameList) do
        if bestPotions[potionName] then
            local potionData = bestPotions[potionName]
            local quantityToUse = math.min(potionData.Amount, usageCap)
            if quantityToUse > 0 then
                print("-> Using " .. quantityToUse .. "x '" .. potionData.Name .. "' (Level " .. potionData.Level .. ") one by one...")
                for i = 1, quantityToUse do
                    if State.isTeleporting or State.isClaimingChest then
                        warn("[POTIONS] Interrupted while using '" .. potionData.Name .. "' due to teleport or chest claim.")
                        return
                    end
                    RemoteEvent:FireServer("UsePotion", potionData.Name, potionData.Level, 1)
                    task.wait(0.5)
                end
            end
        end
    end
end

local function autoDeletePets() if State.isTeleporting or State.isClaimingChest then return end;local rL={};for _,r in ipairs(StarterConfig.RARITY_TO_DELETE)do table.insert(rL,string.lower(r))end;local pTD={};local pD=LocalData:Get();if not(pD and pD.Pets)then return end;for _,pI in pairs(pD.Pets)do if not pI.Equipped then local pBD=PetDatabase[pI.Name];local sD=false;if pBD and pBD.Rarity then local rL2=string.lower(pBD.Rarity);if pBD.Rarity=="Legendary"then local pT=getPetTier(pI.Name);if pT>0 and pT<=StarterConfig.MAX_LEGENDARY_TIER_TO_DELETE and not pI.Shiny and not pI.Mythic then sD=true end elseif table.find(rL,rL2)then sD=true end end;if sD then table.insert(pTD,pI)end end end;if #pTD>0 then for _,p in pairs(pTD)do RemoteEvent:FireServer("DeletePet",p.Id,p.Amount or 1,false);task.wait(0.3)end end end
local function autoCraftShinies() if State.isTeleporting or State.isClaimingChest then return end;local nPG=getNormalPetCounts();local aR={};for _,r in ipairs(StarterConfig.RARITY_TO_SHINY)do aR[r]=true end;for pN,gD in pairs(nPG)do local pBD=PetDatabase[pN];if pBD and pBD.Rarity and aR[pBD.Rarity]then if gD.Count>=(shinyRequirements[pBD.Rarity]or 999)then print("[SHINY] Found enough normal '"..pN.."' to craft shiny. Crafting...");RemoteEvent:FireServer("MakePetShiny",gD.Instances[1].Id);task.wait(1);return end end end end
local function purchaseFreeMasteries() if State.isTeleporting or State.isClaimingChest then return end;print("[ROUTINE] Purchasing free masteries...");for _,pN in ipairs({"Pets","Buffs","Shops","Minigames","Rifts"})do local cL=LocalData:Get().MasteryLevels[pN]or 0;local nLD=MasteryData.Upgrades[pN].Levels[cL+1];if nLD and nLD.Cost.Amount==0 then print("-> Purchasing free upgrade for '"..pN.."'");RemoteEvent:FireServer("UpgradeMastery",pN);task.wait(0.5)end end;print("[ROUTINE] Free mastery check complete.")end
local function unlockAllIslands()
    if State.isTeleporting or State.isClaimingChest then return end
    print("[ROUTINE] Unlocking all islands with verification...")

    local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        warn("No HumanoidRootPart found — cannot unlock islands.")
        return
    end

    -- Define islands to check
    local allIslandNames = {
        -- World 1
        "Floating Island", "Outer Space", "Twilight", "The Void", "Zen",
        -- World 2
        "Dice Island", "Minecart Forest", "Robot Factory", "Hyperwave Island"
    }

    -- Containers + required world unlocks
    local islandContainersToScan = {
        { path = Workspace.Worlds["The Overworld"].Islands, requiredWorld = nil }, -- always available
        { path = Workspace.Worlds["Minigame Paradise"].Islands, requiredWorld = "Minigame Paradise" }
    }

    -- Helper: verify if all target islands are unlocked
    local function areAllIslandsUnlocked()
        local playerData = LocalData:Get()
        if not (playerData and playerData.AreasUnlocked) then
            return false
        end
        for _, name in ipairs(allIslandNames) do
            if not playerData.AreasUnlocked[name] then
                print("Verification Check: Missing '" .. name .. "'")
                return false
            end
        end
        print("Verification Check: All islands are unlocked!")
        return true
    end

    -- Save position to return later
    local originalCFrame = rootPart.CFrame
    local attempts = 0
    local maxAttempts = 3

    -- Try until verified or attempts exceeded
    while not areAllIslandsUnlocked() and attempts < maxAttempts do
        attempts += 1
        print("--- Starting unlock attempt #" .. attempts .. " ---")

        local playerData = LocalData:Get()
        local unlockedAreas = playerData.AreasUnlocked or {}
        local worldsUnlocked = playerData.WorldsUnlocked or {}
        local unlockedThisAttempt = 0

        for _, containerData in ipairs(islandContainersToScan) do
            -- Skip this container if its world isn't unlocked yet
            if containerData.requiredWorld and not worldsUnlocked[containerData.requiredWorld] then
                print("Waiting for world '" .. containerData.requiredWorld .. "' to be unlocked...")
                continue
            end

            local islandsContainer = containerData.path
            if islandsContainer then
                for _, islandModel in ipairs(islandsContainer:GetChildren()) do
                    if not unlockedAreas[islandModel.Name] then
                        local hitbox = islandModel:FindFirstChild("UnlockHitbox", true)
                        if hitbox then
                            print("Unlocking: " .. islandModel.Name)
                            rootPart.Anchored = true
                            rootPart.CFrame = hitbox.CFrame
                            rootPart.Anchored = false
                            task.wait(1)

                            rootPart.Anchored = true
                            rootPart.CFrame = originalCFrame
                            rootPart.Anchored = false
                            task.wait(0.5)

                            unlockedThisAttempt += 1
                        end
                    end
                end
            end
        end

        if unlockedThisAttempt == 0 and attempts > 1 then
            print("No new islands unlocked this attempt — possible issue.")
        end

        print("Unlock attempt #" .. attempts .. " complete. Re-checking...")
        task.wait(2)
    end

    -- Return to start
    rootPart.Anchored = true
    rootPart.CFrame = originalCFrame
    rootPart.Anchored = false

    if areAllIslandsUnlocked() then
        print("[ROUTINE] All islands successfully unlocked.")
    else
        print("[ROUTINE] Some islands may still be locked after " .. maxAttempts .. " attempts.")
    end
end
local function useBestPotionsFromList(pT)
    if not LocalData:Get() or not LocalData:Get().Potions then return end
    for _, pN in ipairs(pT) do
        local bP = nil
        for _, pI in pairs(LocalData:Get().Potions) do
            if string.match(pI.Name, pN) and (not bP or pI.Level > bP.Level) then
                bP = pI
            end
        end
        if bP and bP.Amount > 0 then
            print("-> Using best '"..pN.."' potion: '"..bP.Name.."'")
            RemoteEvent:FireServer("UsePotion", bP.Name, bP.Level, 1)
            task.wait(1)
        end
    end
end
local function openAllBoxes() if State.isTeleporting or State.isClaimingChest then return end;print("[ROUTINE] Opening all boxes...");local bO={"Mystery Box","Light Box","Festival Mystery Box"};local pD=LocalData:Get().Powerups;if pD then for _,bN in ipairs(bO)do if pD[bN]and pD[bN]>0 then local oQ=pD[bN];print("-> Using "..oQ.."x '"..bN.."'");RemoteEvent:FireServer("UseGift",bN,oQ);task.wait(1)end end;task.wait(3);local gF=workspace.Rendered:FindFirstChild("Gifts");if gF then for _,g in ipairs(gF:GetChildren())do RemoteEvent:FireServer("ClaimGift",g.Name);g:Destroy();task.wait(0.5)end end end;print("[ROUTINE] Box opening finished.")end
local function redeemAllCodes() if State.isTeleporting or State.isClaimingChest then return end;print("[ROUTINE] Redeeming all codes...");local cM=require(ReplicatedStorage.Shared.Data.Codes);if not cM then return end;local cTR={};for cN,_ in pairs(cM)do table.insert(cTR,cN)end;if #cTR>0 then print("Found "..#cTR.." codes. Redeeming...");for _,cN in ipairs(cTR)do pcall(function()RemoteFunction:InvokeServer("RedeemCode",cN)end);task.wait(0.1)end end;print("[ROUTINE] Code redemption finished.")end
local function getPotionInventory() local i={};local pD=LocalData:Get();if not(pD and pD.Potions)then return i end;for _,pI in pairs(pD.Potions)do local k=pI.Name.."_T"..pI.Level;i[k]=pI.Amount or 0 end;return i end
local function autoCraftPotions() if State.isTeleporting or State.isClaimingChest then return end;local cP=getPotionInventory();for _,pN in ipairs(StarterConfig.PotionsToCraft)do for t=2,5 do if State.isTeleporting or State.isClaimingChest then return end;if t==2 and StarterConfig.DONT_USE_T1_POTIONS then continue end;local rPT=t-1;local rA=potionRequirements[t]or 5;local iK=pN.."_T"..rPT;local aO=cP[iK]or 0;if aO>=rA then print("[CRAFTING] Have "..aO.."x T"..rPT.." '"..pN.."'. Crafting Tier "..t.."...");RemoteEvent:FireServer("CraftPotion",pN,t,true);task.wait(2.5);cP=getPotionInventory()end end end end
local function autoMaxPets() if State.isTeleporting or State.isClaimingChest then return end;local pD=LocalData:Get();if not(pD and pD.TeamEquipped and pD.Teams)then return end;local eTID=pD.TeamEquipped;local tI=pD.Teams[eTID];if tI and tI.Pets then for _,pID in ipairs(tI.Pets)do if State.isTeleporting or State.isClaimingChest then return end;local pI=nil;for _,pet in pairs(pD.Pets)do if pet.Id==pID then pI=pet;break end end;if pI and(pI.XP or 0)<400000 then RemoteEvent:FireServer("UsePowerOrb",pI.Id);task.wait(0.2);return end end end end

local function initialCraftPotions()
    if State.isTeleporting or State.isClaimingChest then return end
    print("[INITIAL CRAFT] Starting one-time potion crafting session...")

    for _ = 1, 10 do
        local craftedThisPass = false
        local currentPotions = getPotionInventory()
        for _, potionName in ipairs(StarterConfig.PotionsToCraft) do
            for tier = 2, 5 do
                if StarterConfig.DONT_USE_T1_POTIONS and tier == 2 then continue end
                local requiredTier = tier - 1
                local key = potionName .. "_T" .. requiredTier
                local amountOwned = currentPotions[key] or 0
                if amountOwned >= (potionRequirements[tier] or 5) then
                    print(("[INITIAL CRAFT] Have %dx T%d '%s'. Crafting Tier %d..."):format(amountOwned, requiredTier, potionName, tier))
                    RemoteEvent:FireServer("CraftPotion", potionName, tier, true)
                    craftedThisPass = true
                    task.wait(2.5)
                    currentPotions = getPotionInventory()
                end
            end
        end
        if not craftedThisPass then break end
    end

    print("[INITIAL CRAFT] Potion crafting session finished.")
end


local function useAllPowerOrbs()
    if State.isTeleporting or State.isClaimingChest then return end
    print("[ROUTINE] Using all available Power Orbs on non-maxed equipped pets...")
    local playerData = LocalData:Get()
    if not (playerData and playerData.TeamEquipped and playerData.Teams) then return end

    local equippedTeamId = playerData.TeamEquipped
    local teamInfo = playerData.Teams[equippedTeamId]
    if not (teamInfo and teamInfo.Pets) then return end

    for _ = 1, 20 do -- safety limit
        local foundPetToLevel = false
        for _, petId in ipairs(teamInfo.Pets) do
            for _, petData in pairs(playerData.Pets) do
                if petData.Id == petId and (petData.XP or 0) < 400000 then
                    print("-> Using Power Orb on '" .. petData.Name .. "'")
                    RemoteEvent:FireServer("UsePowerOrb", petData.Id)
                    foundPetToLevel = true
                    task.wait(0.1)
                    break
                end
            end
            if foundPetToLevel then break end
        end
        if not foundPetToLevel then break end
    end

    print("[ROUTINE] Power Orb usage cycle complete.")
end


local function claimGiantChestOnce()
    print("[ROUTINE] Attempting to claim the Giant Chest.")
    teleportAndConfirm(
        "Workspace.Worlds.The Overworld.Islands.Floating Island.Island.Portal.Spawn",
        function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            return hrp and hrp.Position.Y > 300 and hrp.Position.Y < 600
        end
    )

    tweenTo(Vector3.new(14, 428, 162)); task.wait(3);
    pressE();
    task.wait(2)
    print("[ROUTINE] Giant Chest claimed (or attempt made).")
end

-- ## BACKGROUND ROUTINES ##
local function startBackgroundRoutines()
    print("[SETUP] Starting background tasks...")
    startAutoBubbleAndSellRoutine()
    task.spawn(function() while getgenv().StarterConfig.StarterRoutineActive do if not State.isTeleporting and not State.isClaimingChest then RemoteEvent:FireServer("SellBubble") end; task.wait(1) end end)
    task.spawn(function() while getgenv().StarterConfig.StarterRoutineActive do collectNearbyPickups(); task.wait(1) end end)
    task.spawn(function() while getgenv().StarterConfig.StarterRoutineActive do if not State.isTeleporting and not State.isClaimingChest then RemoteEvent:FireServer("EquipBestPets") end; task.wait(5) end end)
    if StarterConfig.ENABLE_PLAYTIME_REWARDS then task.spawn(function() while StarterConfig.StarterRoutineActive do if not State.isTeleporting and not State.isClaimingChest then for i=1,9 do pcall(RemoteFunction.InvokeServer,RemoteFunction,"ClaimPlaytime",i); task.wait(0.5) end end; task.wait(60) end end) end
    if StarterConfig.ENABLE_WHEEL_SPIN then task.spawn(function() while StarterConfig.StarterRoutineActive do if not State.isTeleporting and not State.isClaimingChest then RemoteEvent:FireServer("ClaimFreeWheelSpin"); task.wait(2); pcall(RemoteFunction.InvokeServer, RemoteFunction, "WheelSpin"); task.wait(3); RemoteEvent:FireServer("ClaimWheelSpinQueue") end; task.wait(60) end end) end
    if StarterConfig.ENABLE_SHINY_CRAFTING then task.spawn(function() while StarterConfig.StarterRoutineActive do autoCraftShinies(); task.wait(StarterConfig.SHINY_CRAFT_INTERVAL) end end) end
    if StarterConfig.ENABLE_AUTO_POTION_CRAFT then task.spawn(function() while StarterConfig.StarterRoutineActive do autoCraftPotions(); task.wait(300) end end) end
    if StarterConfig.ENABLE_AUTO_MAX_PETS then task.spawn(function() while StarterConfig.StarterRoutineActive do autoMaxPets(); task.wait(10) end end) end
end

-- -- Helper: wait until near position, retry teleport/tween if needed
-- local function moveToAndWait(position, portalPath, maxDistance, timeout, retries)
--     retries = retries or 2
--     for attempt = 1, retries do
--         -- Teleport first to get close to chest island
--         teleportTo(portalPath)
--         task.wait(0.5)
--         -- Tween into exact position
--         tweenTo(position)

--         local startTime = tick()
--         while tick() - startTime < (timeout or 10) do
--             local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
--             if hrp and (hrp.Position - position).Magnitude <= (maxDistance or 5) then
--                 return true
--             end
--             task.wait(0.1)
--         end

--         warn(("[CHEST MANAGER] Attempt #%d failed to reach position. Retrying..."):format(attempt))
--     end
--     return false
-- end

local function startChestRoutine()
    task.spawn(function()
        print("[CHEST MANAGER] Dedicated chest checking routine started.")
        while getgenv().StarterConfig.StarterRoutineActive do
            if not State.isClaimingChest and not State.isTeleporting then
                local cfg = StarterConfig
                local claimedSomething = false

                -- Void Chest
                if cfg.ENABLE_CHEST_FARMING and State.isVoidChestRoutineActive then
                    local voidChestTime = getChestTime("Void")
                    if voidChestTime < 7 then
                        State.isClaimingChest = true
                        claimedSomething = true
                        print("[CHEST MANAGER] Claiming Void Chest...")

                        task.wait(2)
                        print("[CLEANUP] Forcing local pickup cleanup before teleport...")
                        cleanupLocalPickups() -- [2] Immediate cleanup is performed
                        local returnLocation = (State.currentFarmingLocation == "Festival")
                            and "Workspace.Worlds.The Overworld.FastTravel.Spawn"
                            or "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn"

                        local chestPos = Vector3.new(76, 10149, 51)
                        
                        -- Step 1: Robustly teleport to the island and verify arrival
                        if teleportAndConfirm(
                            "Workspace.Worlds.The Overworld.Islands.The Void.Island.Portal.Spawn",
                            function()
                                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                -- ## THIS IS THE CORRECTED LINE ##
                                return hrp and hrp.Position.Y > 9500 and hrp.Position.Y < 11000 -- This range is specific to The Void
                            end,
                            3, 8
                        ) then
                            -- Step 2: Only if teleport succeeded, tween to the chest
                            print("[CHEST MANAGER] Arrived at The Void. Moving to chest...")
                            tweenTo(chestPos)
                            task.wait(3)
                            pressE()
                            task.wait(2)
                            useAllGoldenOrbs()
                            print("[CHEST MANAGER] Void Chest claimed. Returning...")
                        else
                            warn("[CHEST MANAGER] Failed to teleport to Void Island after retries. Aborting claim.")
                        end

                        -- Step 3: Robustly teleport back to the farming location
                        teleportAndConfirm(
                            returnLocation,
                            function()
                                return (State.currentFarmingLocation == "Festival" and isPlayerInArea("Festival")) or isPlayerInArea("Zen")
                            end,
                            3, 8
                        )
                        State.isClaimingChest = false
                    end
                end

                -- Giant Chest (No changes needed here, its logic is already sound)
                if not claimedSomething and cfg.ENABLE_CHEST_FARMING then
                    local giantChestTime = getChestTime("Giant")
                    if giantChestTime < 7 then
                        State.isClaimingChest = true
                        print("[CHEST MANAGER] Claiming Giant Chest...")
                        task.wait(2)
                        print("[CLEANUP] Forcing local pickup cleanup before teleport...")
                        cleanupLocalPickups() -- [2] Immediate cleanup is performed
                        local returnLocation = (State.currentFarmingLocation == "Festival")
                            and "Workspace.Worlds.The Overworld.FastTravel.Spawn"
                            or "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn"

                        local chestPos = Vector3.new(14, 428, 162)

                        if teleportAndConfirm(
                            "Workspace.Worlds.The Overworld.Islands.Floating Island.Island.Portal.Spawn",
                            function()
                                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                return hrp and hrp.Position.Y > 300 and hrp.Position.Y < 600
                            end,
                            3, 8
                        ) then
                            print("[CHEST MANAGER] Arrived at Floating Island. Moving to chest...")
                            tweenTo(chestPos)
                            task.wait(3)
                            pressE()
                            task.wait(2)
                            useAllGoldenOrbs()
                            print("[CHEST MANAGER] Giant Chest claimed. Returning...")
                        else
                            warn("[CHEST MANAGER] Failed to teleport to Floating Island after retries. Aborting claim.")
                        end
                        
                        teleportAndConfirm(
                            returnLocation,
                            function()
                                return (State.currentFarmingLocation == "Festival" and isPlayerInArea("Festival")) or isPlayerInArea("Zen")
                            end,
                            3, 8
                        )
                        State.isClaimingChest = false
                    end
                end
            end
            task.wait(3)
        end
    end)
end



-- ============================================================
-- WORLD 2 UNLOCK & STARTER ROUTINE
-- ============================================================
local function unlockWorld2()
    print("[WORLD 2] Unlocking Minigame Paradise...")
    RemoteEvent:FireServer("UnlockWorld", "Minigame Paradise")
end

local function runIslandUnlockerWorld2()
    print("[WORLD 2] Running full island unlocker for both worlds...")
    unlockAllIslands()
end

local function runWorld2StarterRoutine()
    print("[WORLD 2] Running starter routine...")
    local ticketGoals = {120000, 240000, 580000, 1160000, 2320000, 4640000, 9280000, 18560000, 37120000, 74240000, 100000000}
    local function getTickets()
        local pd = LocalData:Get()
        return (pd and pd.Currencies and pd.Currencies["Tickets"]) or 0
    end
    local function goToIsland(name)
        print("[WORLD 2] Teleporting to " .. name)
        teleportAndConfirm("Workspace.Worlds.Minigame Paradise.Islands."..name..".Island.Portal.Spawn", function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            return hrp and hrp.Position.Y > 1000 -- rough check
        end)
    end
    local function goToCoords(x,y,z)
        tweenTo(Vector3.new(x,y,z))
    end
    local function openEggAndEquip()
        pressE()
        task.wait(1)
        RemoteEvent:FireServer("EquipBestPets")
    end

    goToIsland("Hyperwave Island")
    for _, goal in ipairs(ticketGoals) do
        while getTickets() < goal do task.wait(5) end
        if goal == 120000 then
            goToIsland("Minecart Forest")
            goToCoords(9917, 7682, 242)
        else
            goToIsland("Hyperwave Island")
            goToCoords(9884, 20090, 260)
        end
        openEggAndEquip()
    end
    print("[WORLD 2] Starter routine complete.")
end

-- ## MAIN ROUTINE ##
task.spawn(function()
    if not getgenv().StarterConfig.StarterRoutineActive then return end
    print("--- ADVANCED STARTER ROUTINE (HYBRID) INITIATED ---")
    if StarterConfig.USE_THIRD_PART_AUTOFARM then
        initThirdPartyAutofarm()
    end
    
    local progress = loadProgress()
    if StarterConfig.RESET_PROGRESS_ON_EXECUTE then print("[PROGRESS] Resetting saved progress."); progress={}; saveProgress(progress) end
    
    while not(LocalData:Get() and LocalData:Get().Pets and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) do task.wait(1) end
    print("Player data loaded!")
    
    if StarterConfig.PATH_TO_FESTIVAL and LocalData:Get().UnlockedBubbleFestival then
        print("[PROGRESS] Bubble Festival already unlocked. Setting farming location to Festival.")
        State.currentFarmingLocation = "Festival"
        if StarterConfig.USE_BEST_POTIONS_AFTER_FESTIVAL_UNLOCK then useSpecificPotions(StarterConfig.POTIONS_TO_USE_AFTER_FESTIVAL_UNLOCK, StarterConfig.POTION_USAGE_CAP) end
    end

    if not progress.purchased_free_masteries then purchaseFreeMasteries(); progress.purchased_free_masteries=true; saveProgress(progress) else print("[PROGRESS] Skipping free masteries.") end
    if not progress.unlocked_islands then unlockAllIslands(); progress.unlocked_islands=true; saveProgress(progress) else print("[PROGRESS] Skipping island unlock.") end
    if not progress.redeemed_codes then redeemAllCodes(); progress.redeemed_codes=true; saveProgress(progress) else print("[PROGRESS] Skipping code redemption.") end
    if not progress.opened_boxes then
        openAllBoxes()
        progress.opened_boxes = true
        saveProgress(progress)
    else
        print("[PROGRESS] Skipping box opening.")
    end

    -- NEW: Use starting potions immediately after gifts
    print("[INITIAL HATCH] Using starting potions...")
    useBestPotionsFromList(StarterConfig.USE_POTIONS_ON_START)

    startBackgroundRoutines()
    
    if not progress.initial_hatch_done and State.currentFarmingLocation == "Zen" then
        task.wait(2)
        print("[INITIAL ROUTINE] Starting one-time setup...")

        -- OPTIONAL: skip initial potion crafting if unwanted
        -- if StarterConfig.ENABLE_AUTO_POTION_CRAFT then
        --     initialCraftPotions()
        -- end
        
        -- 1. Original Iceshard Egg hatching
        print("[INITIAL HATCH] Moving to Iceshard Egg...")
        tweenTo(Vector3.new(-4, 10, -58))
        local hatchEndTime = tick() + StarterConfig.INITIAL_HATCH_DURATION
        while tick() < hatchEndTime do
            pressE()
            task.wait(0.1)
        end
        print("[INITIAL HATCH] Iceshard hatching complete.")

        -- 2. Claim the Giant Chest
        claimGiantChestOnce()

        -- 3. Use all available Golden/Power Orbs
        useAllPowerOrbs()

        -- 4. Use the best available "Coins" potion
        print("[INITIAL ROUTINE] Using best available 'Coins' potion...")
        useSpecificPotions({"Coins"}, 1, true)

        print("[INITIAL ROUTINE] Setup complete. Returning to Zen to start main loop...")
        teleportTo("Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn")

        progress.initial_hatch_done = true
        saveProgress(progress)
    else
        print("[PROGRESS] Skipping initial setup routine.")
    end

    startChestRoutine()
    print("[CHEST MANAGER] Starting now...")

    task.spawn(function() while getgenv().StarterConfig.StarterRoutineActive do if not State.isTeleporting and not State.isClaimingChest then pressE() end; task.wait(0.1); end end)

    print("[MAIN LOOP] Starting main farming and mastery upgrade cycle.")
    local masteryUpgradeReadyTime = tick() + StarterConfig.MASTERY_UPGRADE_DELAY

    while StarterConfig.StarterRoutineActive do
        -- Halt main loop if a chest is being claimed.
        if State.isClaimingChest then
            print("[MAIN LOOP] Paused for chest claim...")
            task.wait(1)
            continue -- Skips the rest of the loop and starts the next iteration.
        end


        -- WORLD 2 progression check
        local coins = (LocalData:Get().Currencies and LocalData:Get().Currencies["Coins"]) or 0
        local festDone = not StarterConfig.PATH_TO_FESTIVAL or LocalData:Get().UnlockedBubbleFestival
        if coins >= 1000000000 and festDone and not progress.world2Unlocked then
            unlockWorld2()
            runIslandUnlockerWorld2()
            progress.world2Unlocked = true
            saveProgress(progress)
        end
        if progress.world2Unlocked and not progress.world2StarterComplete then
            runWorld2StarterRoutine()
            progress.world2StarterComplete = true
            saveProgress(progress)
        end
        local currentTime = tick()
        local cfg = StarterConfig
        
        if not State.isPetDeletionActive and (LocalData:Get().MasteryLevels["Pets"] or 0) >= 6 then
             print("[PROGRESSION] Pets Mastery Lvl 6 reached! Activating advanced routines.")
             State.isPetDeletionActive = true
             State.isVoidChestRoutineActive = true
        end

        if cfg.ENABLE_GENIE_QUESTS then
            local questData = LocalData:Get().Quests and LocalData:Get().Quests["gem-genie"]
            if not questData then
                RemoteEvent:FireServer("StartGenieQuest", 1); task.wait(2)
            else
                local isQuestDone = true
                for i, taskData in ipairs(questData.Tasks) do
                    if questData.Progress[i] < taskData.Amount then
                        isQuestDone = false; State.currentQuestTask = taskData.Type; break
                    end
                end
                if isQuestDone then
                    print("[GENIE] All tasks complete! Claiming rewards and starting new quest.")
                    RemoteEvent:FireServer("StartGenieQuest", 1); State.currentQuestTask = "None"; task.wait(2)
                end
            end
        end

        -- Main Action Decision Logic (Chest claiming is now handled separately)
        if State.currentFarmingLocation == "Festival" then
            if not isPlayerInArea("Festival") then
                print("[MANAGER] Not at Festival. Teleporting to home base...");
                teleportAndConfirm(
                    "Workspace.Worlds.The Overworld.FastTravel.Spawn",
                    function() return isPlayerInArea("Festival") end
                )
            end
            if cfg.HatchWhileFarmingFestivalCoins then tweenTo(Vector3.new(243, 13, 229)) else tweenTo(Vector3.new(206, 22, 183)) end
        else -- Default to Zen farming area logic
            local currentTask = (State.currentQuestTask ~= "None") and State.currentQuestTask or "Farming"

            if currentTask == "Hatch" then
                 print("[MANAGER] Task: Genie quest - Hatching."); teleportTo("Workspace.Worlds.The Overworld.FastTravel.Spawn"); tweenTo(Vector3.new(-123, 10, 5))
            elseif currentTask == "Bubble" then
                print("[MANAGER] Task: Genie quest - Bubbles.");
            else -- Farming
                if not isPlayerInArea("Zen") then
                    print("[MANAGER] Not at Zen. Teleporting...")
                    teleportAndConfirm(
                        "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn",
                        function() return isPlayerInArea("Zen") end
                    )
                end
                
                -- Zen-only hatch limit check before World 2 unlock
                if cfg.STOP_HATCHING_AFTER_2000_HATCHES_BEFORE_WORLD2 then
                    local world2Unlocked = LocalData:Get().WorldsUnlocked["Minigame Paradise"]
                    if not world2Unlocked then
                        local hatches = (LocalData:Get().Stats and LocalData:Get().Stats.Hatches) or 0
                        if hatches >= cfg.HATCH_LIMIT_BEFORE_WORLD2 and cfg.HatchWhileFarmingGemsAndCoins then
                            print(string.format(
                                "[HATCH LIMIT] %d hatches reached in Zen before World 2. Disabling hatching...",
                                cfg.HATCH_LIMIT_BEFORE_WORLD2
                            ))
                            cfg.HatchWhileFarmingGemsAndCoins = false
                        end
                    else
                        if not cfg.HatchWhileFarmingGemsAndCoins then
                            print("[HATCH LIMIT] World 2 unlocked! Re-enabling hatching in Zen...")
                            cfg.HatchWhileFarmingGemsAndCoins = true
                        end
                    end
                end

if cfg.HatchWhileFarmingGemsAndCoins then tweenTo(Vector3.new(-35,15973,45)) end
            end
        end

        -- Universal tasks
        if State.isPetDeletionActive then autoDeletePets() end
        if currentTime >= State.nextPickupCleanup then cleanupLocalPickups(); State.nextPickupCleanup = currentTime + cfg.PICKUP_CLEANUP_INTERVAL end
        
        if currentTime >= masteryUpgradeReadyTime then
            local allMasteryGoalsMet=true;for _,pN in ipairs({"Pets","Buffs","Shops","Minigames","Rifts"})do local cL=LocalData:Get().MasteryLevels[pN]or 0;local tL=cfg.TARGET_MASTERY_LEVELS[pN]or 0;if cL<tL then allMasteryGoalsMet=false;local nLD=MasteryData.Upgrades[pN].Levels[cL+1];if nLD and getCurrency(nLD.Cost.Currency)>=nLD.Cost.Amount then print("Upgrading '"..pN.."' to level "..(cL+1));RemoteEvent:FireServer("UpgradeMastery",pN);task.wait(cfg.UPGRADE_PURCHASE_DELAY)end end end;if allMasteryGoalsMet then print("[GOAL] All mastery targets met!");break end
        end

        -- Progression path check
        if cfg.PATH_TO_FESTIVAL and State.currentFarmingLocation == "Zen" and not LocalData:Get().UnlockedBubbleFestival then
            if getCurrency("Gems") >= cfg.FESTIVAL_UNLOCK_GEMS then
                print("[PROGRESSION] Reached "..cfg.FESTIVAL_UNLOCK_GEMS.." Gems! Unlocking Bubble Festival...")
                RemoteEvent:FireServer("UnlockBubbleFestival"); task.wait(2)
                print("[PROGRESSION] Purchasing 'Alien Gum'..."); local args = { "GumShopPurchase", "Alien Gum" }; RemoteEvent:FireServer(unpack(args))
                State.currentFarmingLocation = "Festival"; print("[PROGRESSION] Path switched to Festival Farming.")
                if cfg.USE_BEST_POTIONS_AFTER_FESTIVAL_UNLOCK then useSpecificPotions(cfg.POTIONS_TO_USE_AFTER_FESTIVAL_UNLOCK, cfg.POTION_USAGE_CAP) end
            else
                  print("Farming for Festival Unlock. Current Gems: " .. getCurrency("Gems") .. "/" .. cfg.FESTIVAL_UNLOCK_GEMS)
            end
        end
        
        task.wait(5)
    end
    
    print("--- STARTER ROUTINE FINISHED ---");
    StarterConfig.StarterRoutineActive = false
end)
