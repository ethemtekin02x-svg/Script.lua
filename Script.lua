-- Services
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ScreenGui (En Üst Katman - Marketlerin Asla Altında Kalmaz)
local targetParent = localPlayer:WaitForChild("PlayerGui")
local existingGui = targetParent:FindFirstChild("UltimateCleanModMenu") or CoreGui:FindFirstChild("UltimateCleanModMenu")
if existingGui then existingGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateCleanModMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 2147483647
screenGui.Parent = targetParent

local isMenuLocked = false

-- 1. TOGGLE BUTTON (MOD Butonu)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleMenuBtn"
toggleBtn.Size = UDim2.new(0, 45, 0, 45)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -22)
toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
toggleBtn.BorderColor3 = Color3.fromRGB(0, 230, 118)
toggleBtn.BorderSizePixel = 2
toggleBtn.TextColor3 = Color3.fromRGB(0, 230, 118)
toggleBtn.TextSize = 12
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Text = "MOD"
toggleBtn.ZIndex = 1000
toggleBtn.Parent = screenGui

local cornerToggle = Instance.new("UICorner")
cornerToggle.CornerRadius = UDim.new(0, 8)
cornerToggle.Parent = toggleBtn

-- 2. MAIN MENU (Küçültülmüş Kompakt Boyut)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 360)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
mainFrame.BorderColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true
mainFrame.ZIndex = 999
mainFrame.Parent = screenGui

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 10)
cornerMain.Parent = mainFrame

-- Sürüklenebilirlik
local function makeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragInput, dragStart, startPos
    
    handle.InputBegan:Connect(function(input)
        if isMenuLocked then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not isMenuLocked and dragging and dragInput and (input == dragInput) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(toggleBtn)
makeDraggable(mainFrame, mainFrame)

toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and (input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.F4) then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- Title Bar (Made by blackhat İmzalı)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "   SCP: ANOMALY SITE | Made by blackhat"
titleLabel.TextColor3 = Color3.fromRGB(0, 230, 118)
titleLabel.TextSize = 12
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 1000
titleLabel.Parent = mainFrame

-- Tabs List
local tabListFrame = Instance.new("ScrollingFrame")
tabListFrame.Size = UDim2.new(0, 140, 1, -35)
tabListFrame.Position = UDim2.new(0, 0, 0, 35)
tabListFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
tabListFrame.BorderSizePixel = 0
tabListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
tabListFrame.ZIndex = 1000
tabListFrame.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Parent = tabListFrame

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -140, 1, -35)
contentFrame.Position = UDim2.new(0, 140, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.ZIndex = 1000
contentFrame.Parent = mainFrame

local pages = {}
local tabButtons = {}

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(160, 160, 170)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.ZIndex = 1000
    btn.Parent = tabListFrame

    table.insert(tabButtons, btn)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 900)
    page.ScrollBarThickness = 4
    page.ZIndex = 1000
    page.Parent = contentFrame

    local pLayout = Instance.new("UIListLayout")
    pLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pLayout.Padding = UDim.new(0, 10)
    pLayout.Parent = page

    local pPadding = Instance.new("UIPadding")
    pPadding.PaddingTop = UDim.new(0, 12)
    pPadding.PaddingLeft = UDim.new(0, 15)
    pPadding.Parent = page

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, b in pairs(tabButtons) do b.TextColor3 = Color3.fromRGB(160, 160, 170) end
        page.Visible = true
        btn.TextColor3 = Color3.fromRGB(0, 230, 118)
    end)

    if #pages == 0 then
        page.Visible = true
        btn.TextColor3 = Color3.fromRGB(0, 230, 118)
    end
    table.insert(pages, page)
    return page
end

local pageCombat = createTab("Combat")
local pageMovement = createTab("Movement")
local pageVisuals = createTab("Visuals")
local pageTeleport = createTab("Teleport")

-- Toggle Helper
local function addToggle(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 345, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(220, 220, 225)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text .. " [ OFF ]"
    btn.ZIndex = 1000
    btn.Parent = parent

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
            btn.Text = text .. " [ ON ]"
        else
            btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
            btn.Text = text .. " [ OFF ]"
        end
        callback(active)
    end)
    return btn
end

-- Değişkenler
local aimbotActive = false
local wallCheckActive = true
local teamCheckActive = true
local speedActive = false
local speedVal = 16
local flyActive = false
local flySpeedVal = 50
local noclipActive = false
local infJumpActive = false
local espActive = false

addToggle(pageCombat, "Aimbot (Auto-Lock)", function(state) aimbotActive = state end)
addToggle(pageCombat, "Wall Check (No Wall Aim)", function(state) wallCheckActive = state end)
addToggle(pageCombat, "Team Check (No Team Aim)", function(state) teamCheckActive = state end)

addToggle(pageMovement, "Speed Hack", function(state) speedActive = state end)

-- Speed Slider (1 - 255)
local speedSliderFrame = Instance.new("Frame")
speedSliderFrame.Size = UDim2.new(0, 345, 0, 45)
speedSliderFrame.BackgroundTransparency = 1
speedSliderFrame.ZIndex = 1000
speedSliderFrame.Parent = pageMovement

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 18)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed Value: 16 (Max: 255)"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
speedLabel.TextSize = 11
speedLabel.Font = Enum.Font.GothamMedium
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.ZIndex = 1000
speedLabel.Parent = speedSliderFrame

local speedTrack = Instance.new("Frame")
speedTrack.Size = UDim2.new(1, 0, 0, 5)
speedTrack.Position = UDim2.new(0, 0, 0, 26)
speedTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
speedTrack.BorderSizePixel = 0
speedTrack.ZIndex = 1000
speedTrack.Parent = speedSliderFrame
Instance.new("UICorner", speedTrack).CornerRadius = UDim.new(1, 0)

local speedFill = Instance.new("Frame")
speedFill.Size = UDim2.new(16/255, 0, 1, 0)
speedFill.BackgroundColor3 = Color3.fromRGB(0, 230, 118)
speedFill.BorderSizePixel = 0
speedFill.ZIndex = 1000
speedFill.Parent = speedTrack
Instance.new("UICorner", speedFill).CornerRadius = UDim.new(1, 0)

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0, 16, 0, 16)
speedBtn.Position = UDim2.new(16/255, -8, 0, -5.5)
speedBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.Text = ""
speedBtn.ZIndex = 1000
speedBtn.Parent = speedTrack
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(1, 0)

local speedSliding = false
speedBtn.MouseButton1Down:Connect(function() speedSliding = true end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        speedSliding = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if speedSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = input.Position.X
        local absPos = speedTrack.AbsolutePosition.X
        local absSize = speedTrack.AbsoluteSize.X
        local rel = math.clamp((pos - absPos) / absSize, 0, 1)
        speedFill.Size = UDim2.new(rel, 0, 1, 0)
        speedBtn.Position = UDim2.new(rel, -8, 0, -5.5)
        speedVal = math.floor(rel * 254 + 1)
        speedLabel.Text = "Speed Value: " .. speedVal .. " (Max: 255)"
    end
end)

addToggle(pageMovement, "Fly (Flight)", function(state) flyActive = state end)

-- Fly Speed Slider (1 - 200)
local flySliderFrame = Instance.new("Frame")
flySliderFrame.Size = UDim2.new(0, 345, 0, 45)
flySliderFrame.BackgroundTransparency = 1
flySliderFrame.ZIndex = 1000
flySliderFrame.Parent = pageMovement

local flyLabel = Instance.new("TextLabel")
flyLabel.Size = UDim2.new(1, 0, 0, 18)
flyLabel.BackgroundTransparency = 1
flyLabel.Text = "Fly Speed: 50 (Max: 200)"
flyLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
flyLabel.TextSize = 11
flyLabel.Font = Enum.Font.GothamMedium
flyLabel.TextXAlignment = Enum.TextXAlignment.Left
flyLabel.ZIndex = 1000
flyLabel.Parent = flySliderFrame

local flyTrack = Instance.new("Frame")
flyTrack.Size = UDim2.new(1, 0, 0, 5)
flyTrack.Position = UDim2.new(0, 0, 0, 26)
flyTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
flyTrack.BorderSizePixel = 0
flyTrack.ZIndex = 1000
flyTrack.Parent = flySliderFrame
Instance.new("UICorner", flyTrack).CornerRadius = UDim.new(1, 0)

local flyFill = Instance.new("Frame")
flyFill.Size = UDim2.new(50/200, 0, 1, 0)
flyFill.BackgroundColor3 = Color3.fromRGB(0, 176, 255)
flyFill.BorderSizePixel = 0
flyFill.ZIndex = 1000
flyFill.Parent = flyTrack
Instance.new("UICorner", flyFill).CornerRadius = UDim.new(1, 0)

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 16, 0, 16)
flyBtn.Position = UDim2.new(50/200, -8, 0, -5.5)
flyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.Text = ""
flyBtn.ZIndex = 1000
flyBtn.Parent = flyTrack
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(1, 0)

local flySliding = false
flyBtn.MouseButton1Down:Connect(function() flySliding = true end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        flySliding = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if flySliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = input.Position.X
        local absPos = flyTrack.AbsolutePosition.X
        local absSize = flyTrack.AbsoluteSize.X
        local rel = math.clamp((pos - absPos) / absSize, 0, 1)
        flyFill.Size = UDim2.new(rel, 0, 1, 0)
        flyBtn.Position = UDim2.new(rel, -8, 0, -5.5)
        flySpeedVal = math.floor(rel * 190 + 10)
        flyLabel.Text = "Fly Speed: " .. flySpeedVal .. " (Max: 200)"
    end
end)

addToggle(pageMovement, "Noclip", function(state) noclipActive = state end)
addToggle(pageMovement, "Infinite Jump", function(state) infJumpActive = state end)
addToggle(pageVisuals, "Master ESP (Highlight)", function(state) espActive = state end)

-- TELEPORT SECTION
local escapeBtn = Instance.new("TextButton")
escapeBtn.Size = UDim2.new(0, 345, 0, 35)
escapeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 0)
escapeBtn.BorderSizePixel = 0
escapeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
escapeBtn.TextSize = 11
escapeBtn.Font = Enum.Font.GothamBold
escapeBtn.Text = "Escape Prison"
escapeBtn.ZIndex = 1000
escapeBtn.Parent = pageTeleport
Instance.new("UICorner", escapeBtn).CornerRadius = UDim.new(0, 6)

escapeBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if myRoot then
            myRoot.CFrame = CFrame.new(1207.3, 131.8, -683.2)
        end
    end)
end)

local nukeBtn = Instance.new("TextButton")
nukeBtn.Size = UDim2.new(0, 345, 0, 35)
nukeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
nukeBtn.BorderSizePixel = 0
nukeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
nukeBtn.TextSize = 11
nukeBtn.Font = Enum.Font.GothamBold
nukeBtn.Text = "TP Nuke"
nukeBtn.ZIndex = 1000
nukeBtn.Parent = pageTeleport
Instance.new("UICorner", nukeBtn).CornerRadius = UDim.new(0, 6)

nukeBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if myRoot then
            myRoot.CFrame = CFrame.new(1472.7, 175.9, -1231.7)
        end
    end)
end)

-- OYUNCU SEÇEREK IŞINLANMA (Player List)
local playerListLabel = Instance.new("TextLabel")
playerListLabel.Size = UDim2.new(0, 345, 0, 20)
playerListLabel.BackgroundTransparency = 1
playerListLabel.Text = "--- Select Player to Teleport ---"
playerListLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
playerListLabel.TextSize = 11
playerListLabel.Font = Enum.Font.GothamBold
playerListLabel.ZIndex = 1000
playerListLabel.Parent = pageTeleport

local playerScrollFrame = Instance.new("ScrollingFrame")
playerScrollFrame.Size = UDim2.new(0, 345, 0, 130)
playerScrollFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
playerScrollFrame.BorderSizePixel = 0
playerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
playerScrollFrame.ScrollBarThickness = 4
playerScrollFrame.ZIndex = 1000
playerScrollFrame.Parent = pageTeleport
Instance.new("UICorner", playerScrollFrame).CornerRadius = UDim.new(0, 6)

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerListLayout.Padding = UDim.new(0, 5)
playerListLayout.Parent = playerScrollFrame

local function refreshPlayerList()
    for _, v in pairs(playerScrollFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, -10, 0, 32)
            pBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            pBtn.BorderSizePixel = 0
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.TextSize = 11
            pBtn.Font = Enum.Font.GothamMedium
            pBtn.Text = player.Name .. " (" .. player.DisplayName .. ")"
            pBtn.ZIndex = 1000
            pBtn.Parent = playerScrollFrame
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 4)

            pBtn.MouseButton1Click:Connect(function()
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            myRoot.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        end
                    end
                end)
            end)
        end
    end
    playerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, playerListLayout.AbsoluteContentSize.Y + 10)
end

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
task.spawn(refreshPlayerList)

-- Farklı Takım Renkleri ESP Fonksiyonu
local function getTeamColor(player)
    if player.Team then
        local tName = player.Team.Name:lower()
        if tName:find("d") or tName:find("sinif") or tName:find("class d") then
            return Color3.fromRGB(255, 140, 0)
        elseif tName:find("bilim") or tName:find("scientist") then
            return Color3.fromRGB(240, 240, 240)
        elseif tName:find("guvenlik") or tName:find("security") or tName:find("guard") then
            return Color3.fromRGB(100, 100, 120)
        elseif tName:find("mtf") or tName:find("mobile task") then
            return Color3.fromRGB(0, 120, 255)
        elseif tName:find("yonetici") or tName:find("site director") then
            return Color3.fromRGB(200, 0, 200)
        elseif tName:find("ci") or tName:find("chaos") then
            return Color3.fromRGB(0, 180, 80)
        else
            return player.Team.Color.Color
        end
    end
    return Color3.fromRGB(255, 50, 50)
end

-- Motorlar ve Looplar
UserInputService.JumpRequest:Connect(function()
    if infJumpActive and localPlayer.Character then
        local hum = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

RunService.Stepped:Connect(function()
    if noclipActive and localPlayer.Character then
        for _, v in pairs(localPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- ESP Loop
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local char = player.Character
            local box = char:FindFirstChild("CleanESPBox")
            if espActive then
                if not box then
                    box = Instance.new("Highlight")
                    box.Name = "CleanESPBox"
                    box.Adornee = char
                    box.Parent = char
                end
                box.FillColor = getTeamColor(player)
                box.OutlineColor = Color3.fromRGB(255, 255, 255)
                box.Enabled = true
            else
                if box then box.Enabled = false end
            end
        end
    end
end)
-- Fly, Speed & Aimbot Motoru
local bv, bg
RunService.RenderStepped:Connect(function()
    local char = localPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")

    if hum then
        if speedActive and not flyActive then
            hum.WalkSpeed = speedVal
        end
    end

    if flyActive and hrp and hum then
        hum.PlatformStand = true
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Parent = hrp
        end
        if not bg then
            bg = Instance.new("BodyGyro")
            bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            bg.P = 9e4
            bg.Parent = hrp
        end
        bg.CFrame = camera.CFrame
        local mDir = hum.MoveDirection
        if mDir.Magnitude > 0 then
            local cCF = camera.CFrame
            local lVec = cCF:VectorToObjectSpace(mDir)
            local fwd = cCF.LookVector * (-lVec.Z)
            local rgt = cCF.RightVector * (lVec.X)
            bv.Velocity = (fwd + rgt).Unit * flySpeedVal
        else
            bv.Velocity = Vector3.new(0, 0, 0)
        end
    else
        if hum and hum.PlatformStand then hum.PlatformStand = false end
        if bv then bv:Destroy() bv = nil end
        if bg then bg:Destroy() bg = nil end
    end

    if aimbotActive then
        local target = nil
        local minDist = math.huge
        local center = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                local isTeamMate = false
                if teamCheckActive then
                    if localPlayer.Team and player.Team and localPlayer.Team == player.Team then
                        isTeamMate = true
                    end
                end

                if not isTeamMate and player.Character and player.Character:FindFirstChild("Head") then
                    local head = player.Character.Head
                    local pos, onScreen = camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        if dist < minDist then
                            local canSee = true
                            if wallCheckActive then
                                local rayParams = RaycastParams.new()
                                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                                rayParams.FilterDescendantsInstances = {char, camera}
                                local res = workspace:Raycast(camera.CFrame.Position, head.Position - camera.CFrame.Position, rayParams)
                                if res and not res.Instance:IsDescendantOf(player.Character) then
                                    canSee = false
                                end
                            end
                            if canSee then
                                minDist = dist
                                target = head
                            end
                        end
                    end
                end
            end
        end

        if target then
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
        end
    end
end)
