
wait(12)

local requiredGameId = 9874911474 

if game.PlaceId ~= requiredGameId then
    return 
end

local allowedUsernames = {
    "",
    "",
    "",
    ""
}


local groupId = 35379196


local function checkGroupAndUser()
    local player = game.Players.LocalPlayer
    local usernameValid = false
    local groupValid = false

    
    for _, username in ipairs(allowedUsernames) do
        if player.Name == username then
            usernameValid = true
            break
        end
    end

    
    local inGroup = player:IsInGroup(groupId)
    if inGroup then
        groupValid = true
    end

    
    return usernameValid and groupValid
end


if not checkGroupAndUser() then
    
    game.Players.LocalPlayer:Kick(" Authnetication Failed, Contact Script Owner If This Is a Issue.")
    return
end





local function createSpiderManGui()
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpiderManGui") then
        return -- Exit if the GUI already exists
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SpiderManGui"
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Name = "GradientFrame"
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 30) -- Dark Blue
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = "Spidermans TB2 Autofarm"
    title.Font = Enum.Font.Code
    title.TextSize = 36
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Parent = frame

    local playerNameLabel = Instance.new("TextLabel")
    playerNameLabel.Name = "PlayerNameLabel"
    playerNameLabel.Text = "Player: " .. game:GetService("Players").LocalPlayer.Name
    playerNameLabel.Font = Enum.Font.Code
    playerNameLabel.TextSize = 30
    playerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    playerNameLabel.BackgroundTransparency = 1
    playerNameLabel.Size = UDim2.new(0, 400, 0, 50)
    playerNameLabel.Position = UDim2.new(0.5, -200, 0.4, -25)
    playerNameLabel.Parent = frame

    local walletLabel = Instance.new("TextLabel")
    walletLabel.Name = "WalletLabel"
    walletLabel.Text = "Wallet: Loading..."
    walletLabel.Font = Enum.Font.Code
    walletLabel.TextSize = 25
    walletLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    walletLabel.BackgroundTransparency = 1
    walletLabel.Size = UDim2.new(0, 400, 0, 50)
    walletLabel.Position = UDim2.new(0.5, -200, 0.5, 10)
    walletLabel.Parent = frame

    local bankLabel = Instance.new("TextLabel")
    bankLabel.Name = "BankLabel"
    bankLabel.Text = "Bank: Loading..."
    bankLabel.Font = Enum.Font.Code
    bankLabel.TextSize = 25
    bankLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    bankLabel.BackgroundTransparency = 1
    bankLabel.Size = UDim2.new(0, 400, 0, 50)
    bankLabel.Position = UDim2.new(0.5, -200, 0.55, 10)
    bankLabel.Parent = frame

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Text = "Status: Idle"
    statusLabel.Font = Enum.Font.Code
    statusLabel.TextSize = 25
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Size = UDim2.new(0, 400, 0, 50)
    statusLabel.Position = UDim2.new(0.5, -200, 0.6, 10)
    statusLabel.Parent = frame

    local function updateLabels(robbedCount)
        local player = game.Players.LocalPlayer
        if player then
            local storedFolder = player:WaitForChild("stored", 5)
            if storedFolder then
                local money = storedFolder:FindFirstChild("Money")
                if money then
                    walletLabel.Text = "Wallet: " .. tostring(money.Value)
                end

                local bankMoney = storedFolder:FindFirstChild("Bank")
                if bankMoney then
                    bankLabel.Text = "Bank: " .. tostring(bankMoney.Value)
                end
            end
        end
        if robbedCount and robbedCount > 0 then
            statusLabel.Text = "Status: Collecting money: " .. tostring(robbedCount)
        else
            statusLabel.Text = "Status: Idle"
        end
    end

    return updateLabels
end



-- Initialize GUI and get updater function
local updateLabels = createSpiderManGui()

-- Your provided script logic, integrated with the GUI
local moneyStacks = {
    workspace.StudioPay.Money.StudioPay1.StudioMoney1,
    workspace.StudioPay.Money.StudioPay2.StudioMoney1,
    workspace.StudioPay.Money.StudioPay3.StudioMoney1
}

local robCount = 0

local function robMoneyStack()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local nearbyObjects = workspace:GetDescendants()

        for _, object in ipairs(nearbyObjects) do
            if object.Name:lower():find("money") and object:IsA("BasePart") then
                local distance = (object.Position - humanoidRootPart.Position).Magnitude
                if distance <= 10 then
                    local prompt = object:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt then
                        fireproximityprompt(prompt)
                        robCount = robCount + 1
                        updateLabels(robCount)
                        wait(0.5)
                    
                        
                    end
                end
            end
        end
    else
        warn("Player's character not found!")
    end
end


local function teleportToPosition(position)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
    else
        warn("Player's character or HumanoidRootPart not found!")
    end
end

-- Deposit function with game pass check
local function depositMoney()
    local player = game.Players.LocalPlayer
    local extraWalletGamePassId = 916047373 -- Game pass ID for Extra Wallet Space
    local gamePassService = game:GetService("MarketplaceService")
    local maxBank = 990000 -- Default max bank limit
    local maxDeposit = 30000

    -- Check for the game pass and adjust maxBank if applicable
    local success, hasGamePass = pcall(function()
        return gamePassService:UserOwnsGamePassAsync(player.UserId, extraWalletGamePassId)
    end)

    if success and hasGamePass then
        maxBank = 1600000 -- Adjust max bank limit for game pass holders
    elseif not success then
        warn("Error checking game pass ownership!")
    end

    if player then
        local storedFolder = player:WaitForChild("stored", 5)
        if storedFolder then
            local money = storedFolder:FindFirstChild("Money")
            local bankMoney = storedFolder:FindFirstChild("Bank")

            if money and bankMoney then
                -- If bank money is already at max, no need to deposit anything
                if bankMoney.Value >= maxBank then
                    print("Bank is already full, no need to deposit.")
                    return -- Exit the function since the bank is already at the maximum
                end

                local function depositAllMoney()
                    local remainingMoney = money.Value
                    local spaceInBank = maxBank - bankMoney.Value

                    while remainingMoney > 0 and spaceInBank > 0 do
                        local depositAmount = math.min(spaceInBank, maxDeposit, remainingMoney)
                        game.ReplicatedStorage:WaitForChild("BankAction"):FireServer("depo", depositAmount)

                        -- Wait for the bank value to update
                        repeat
                            wait(0.5)
                        until bankMoney.Value < maxBank and money.Value < remainingMoney

                        -- Recalculate remaining money and space in the bank
                        remainingMoney = money.Value
                        spaceInBank = maxBank - bankMoney.Value

                        -- Update the labels
                        if updateLabels then
                            updateLabels(0) -- Pass 0 since we're depositing, not robbing
                        end
                    end
                end

                depositAllMoney()
            else
                warn("Money or Bank not found in stored folder.")
            end
        else
            warn("Stored folder not found.")
        end
    else
        warn("Player not found.")
    end
end


local function serverHop()
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local PlaceId = game.PlaceId
    local currentJobId = game.JobId

    -- Function to fetch server list with error handling and retries
    local function fetchServerList()
        local retries = 3  -- Maximum number of retries
        local attempt = 0

        while attempt < retries do
            local success, result = pcall(function()
                return HttpService:JSONDecode(
                    game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
                )
            end)

            if success and result and result.data then
                return result.data
            elseif result and result.status == 429 then
                -- Error 429: Too many requests
                print("Error 429: Too many requests. Retrying in 10 seconds...")
                wait(10)  -- Wait 10 seconds before retrying
            else
                -- General failure or other error
                print("Failed to fetch server list. Retrying in 5 seconds...")
                wait(5)  -- Wait a bit before retrying
            end

            attempt = attempt + 1
        end

        -- After retries, if still no success
        warn("Failed to fetch server list after multiple attempts.")
        return nil
    end

    -- Get server list with retry mechanism
    local serverList = fetchServerList()

    -- If server list is successfully fetched, attempt server hopping
    if serverList then
        for _, server in ipairs(serverList) do
            if server.id ~= currentJobId and server.playing < server.maxPlayers then
                TeleportService:TeleportToPlaceInstance(PlaceId, server.id)
                print("Server hopping to: " .. server.id)
                return
            end
        end
        warn("Suitable server not found ❌")
    end
end


local function teleportAndRob()
    local studioPosition = Vector3.new(93422.08, 14484.72, 563.49)
    teleportToPosition(studioPosition)
    wait(1)
    robMoneyStack()
    wait(3)
    depositMoney()
    wait(7) 
    serverHop()
end

-- Execute
teleportAndRob()
