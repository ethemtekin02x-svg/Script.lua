-- Services
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ScreenGui (En Üst Katman)
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

-- FOV Çemberi Görseli
local fovRadiusVal = 120
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Radius = fovRadiusVal
fovCircle.Color = Color3.fromRGB(0, 230, 118)
fovCircle.Thickness = 1
fovCircle.Filled = false
fovCircle.Transparency = 0.7
fovCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

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

-- 2. MAIN MENU (Kompakt Boyut)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 380)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
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
local titleLabel = Instance.new("TextButton")
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

-- Menüyü Tamamen Kapatan Çarpı (X) Butonu
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.ZIndex = 1001
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    pcall(function()
        fovCircle:Remove()
    end)
    screenGui:Destroy()
end)

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
    page.CanvasSize = UDim2.new(0, 0, 0, 1300)
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
    return page, btn
end

local pageCombat, combatTabBtn = createTab("Combat")
local pageMovement = createTab("Movement")
local pageVisuals = createTab("Visuals")
local pageTeleport, tpTabBtn = createTab("Teleport")

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
local fovCircleActive = false
local speedActive = false
local speedVal = 16
local flyActive = false
local flySpeedVal = 50
local noclipActive = false
local infJumpActive = false
local espActive = false
local fullbrightActive = false

-- Kaydedilen Konum Değişkeni (Save Position)
local savedCFrame = nil

-- Hariç Tutulacak (Ignored / Blacklist) Oyuncular Tablosu
local ignoredTargets = {}

addToggle(pageCombat, "Aimbot (Auto-Lock)", function(state) aimbotActive = state end)
addToggle(pageCombat, "Wall Check (No Wall Aim)", function(state) wallCheckActive = state end)
addToggle(pageCombat, "FOV Circle (Show Range)", function(state)
    fovCircleActive = state
    fovCircle.Visible = state
end)

-- Custom FOV Slider (Combat Sekmesi)
local fovSliderFrame = Instance.new("Frame")
fovSliderFrame.Size = UDim2.new(0, 345, 0, 45)
fovSliderFrame.BackgroundTransparency = 1
fovSliderFrame.ZIndex = 1000
fovSliderFrame.Parent = pageCombat

local fovLabel = Instance.new("TextLabel")
fovLabel.Size = UDim2.new(1, 0, 0, 18)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = "FOV Range: 120 (Max: 400)"
fovLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
fovLabel.TextSize = 11
fovLabel.Font = Enum.Font.GothamMedium
fovLabel.TextXAlignment = Enum.TextXAlignment.Left
fovLabel.ZIndex = 1000
fovLabel.Parent = fovSliderFrame

local fovTrack = Instance.new("Frame")
fovTrack.Size = UDim2.new(1, 0, 0, 5)
fovTrack.Position = UDim2.new(0, 0, 0, 26)
fovTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
fovTrack.BorderSizePixel = 0
fovTrack.ZIndex = 1000
fovTrack.Parent = fovSliderFrame
Instance.new("UICorner", fovTrack).CornerRadius = UDim.new(1, 0)

local fovFill = Instance.new("Frame")
fovFill.Size = UDim2.new(120/400, 0, 1, 0)
fovFill.BackgroundColor3 = Color3.fromRGB(0, 230, 118)
fovFill.BorderSizePixel = 0
fovFill.ZIndex = 1000
fovFill.Parent = fovTrack
Instance.new("UICorner", fovFill).CornerRadius = UDim.new(1, 0)

local fovBtn = Instance.new("TextButton")
fovBtn.Size = UDim2.new(0, 16, 0, 16)
fovBtn.Position = UDim2.new(120/400, -8, 0, -5.5)
fovBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fovBtn.Text = ""
fovBtn.ZIndex = 1000
fovBtn.Parent = fovTrack
Instance.new("UICorner", fovBtn).CornerRadius = UDim.new(1, 0)

local fovSliding = false
fovBtn.MouseButton1Down:Connect(function() fovSliding = true end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        fovSliding = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if fovSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = input.Position.X
        local absPos = fovTrack.AbsolutePosition.X
        local absSize = fovTrack.AbsoluteSize.X
        local rel = math.clamp((pos - absPos) / absSize, 0, 1)
        fovFill.Size = UDim2.new(rel, 0, 1, 0)
        fovBtn.Position = UDim2.new(rel, -8, 0, -5.5)
        fovRadiusVal = math.floor(rel * 350 + 50)
        fovCircle.Radius = fovRadiusVal
        fovLabel.Text = "FOV Range: " .. fovRadiusVal .. " (Max: 400)"
    end
end)

-- Aimbot Harici Tutma (Ignore / Blacklist) Listesi Başlığı
local targetListLabel = Instance.new("TextLabel")
targetListLabel.Size = UDim2.new(0, 345, 0, 20)
targetListLabel.BackgroundTransparency = 1
targetListLabel.Text = "--- Ignore / Blacklist (Aimbot Exclude) ---"
targetListLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
targetListLabel.TextSize = 11
targetListLabel.Font = Enum.Font.GothamBold
targetListLabel.ZIndex = 1000
targetListLabel.Parent = pageCombat

local combatScrollFrame = Instance.new("ScrollingFrame")
combatScrollFrame.Size = UDim2.new(0, 345, 0, 120)
combatScrollFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
combatScrollFrame.BorderSizePixel = 0
combatScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
combatScrollFrame.ScrollBarThickness = 4
combatScrollFrame.ZIndex = 1000
combatScrollFrame.Parent = pageCombat
Instance.new("UICorner", combatScrollFrame).CornerRadius = UDim.new(0, 6)

local combatListLayout = Instance.new("UIListLayout")
combatListLayout.SortOrder = Enum.SortOrder.LayoutOrder
combatListLayout.Padding = UDim.new(0, 5)
combatListLayout.Parent = combatScrollFrame

local refreshPlayerList, refreshCombatList

refreshCombatList = function()
    for _, v in pairs(combatScrollFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, -10, 0, 32)
            local isIgnored = ignoredTargets[player]
            pBtn.BackgroundColor3 = isIgnored and Color3.fromRGB(180, 40, 40) or Color3.fromRGB(35, 35, 45)
            pBtn.BorderSizePixel = 0
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.TextSize = 11
            pBtn.Font = Enum.Font.GothamMedium
            pBtn.Text = (isIgnored and "[IGNORED] " or "[ ] ") .. player.Name .. " (" .. player.DisplayName .. ")"
            pBtn.ZIndex = 1000
            pBtn.Parent = combatScrollFrame
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 4)

            pBtn.MouseButton1Click:Connect(function()
                if ignoredTargets[player] then
                    ignoredTargets[player] = nil
                    pBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                    pBtn.Text = "[ ] " .. player.Name .. " (" .. player.DisplayName .. ")"
                else
                    ignoredTargets[player] = true
                    pBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                    pBtn.Text = "[IGNORED] " .. player.Name .. " (" .. player.DisplayName .. ")"
                end
            end)
        end
    end
    combatScrollFrame.CanvasSize = UDim2.new(0, 0, 0, combatListLayout.AbsoluteContentSize.Y + 10)
end

addToggle(pageMovement, "Speed Hack", function(state) speedActive = state end)

-- Speed Slider
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

-- Fly Speed Slider
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

-- VISUALS SECTION
addToggle(pageVisuals, "Advanced ESP (Box + Info)", function(state) espActive = state end)
addToggle(pageVisuals, "Fullbright (No Darkness)", function(state)
    fullbrightActive = state
    if fullbrightActive then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
end)

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

local escape2Btn = Instance.new("TextButton")
escape2Btn.Size = UDim2.new(0, 345, 0, 35)
escape2Btn.BackgroundColor3 = Color3.fromRGB(210, 90, 0)
escape2Btn.BorderSizePixel = 0
escape2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
escape2Btn.TextSize = 11
escape2Btn.Font = Enum.Font.GothamBold
escape2Btn.Text = "Escape Prison 2"
escape2Btn.ZIndex = 1000
escape2Btn.Parent = pageTeleport
Instance.new("UICorner", escape2Btn).CornerRadius = UDim.new(0, 6)

escape2Btn.MouseButton1Click:Connect(function()
    pcall(function()
        local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if myRoot then
            myRoot.CFrame = CFrame.new(879.2, 66.4, -1050.1)
        end
    end)
end)

local tpPrisonBtn = Instance.new("TextButton")
tpPrisonBtn.Size = UDim2.new(0, 345, 0, 35)
tpPrisonBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 180)
tpPrisonBtn.BorderSizePixel = 0
tpPrisonBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpPrisonBtn.TextSize = 11
tpPrisonBtn.Font = Enum.Font.GothamBold
tpPrisonBtn.Text = "TP Prison"
tpPrisonBtn.ZIndex = 1000
tpPrisonBtn.Parent = pageTeleport
Instance.new("UICorner", tpPrisonBtn).CornerRadius = UDim.new(0, 6)

tpPrisonBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if myRoot then
            myRoot.CFrame = CFrame.new(1344.3, 137.1, -1047.5)
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

-- KONUM KAYDETME & GERİ IŞINLANMA (Save Position & TP to Saved)
local savePosBtn = Instance.new("TextButton")
savePosBtn.Size = UDim2.new(0, 345, 0, 35)
savePosBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 160)
savePosBtn.BorderSizePixel = 0
savePosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
savePosBtn.TextSize = 11
savePosBtn.Font = Enum.Font.GothamBold
savePosBtn.Text = "Save Position (Konum Kaydet)"
savePosBtn.ZIndex = 1000
savePosBtn.Parent = pageTeleport
Instance.new("UICorner", savePosBtn).CornerRadius = UDim.new(0, 6)

savePosBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if myRoot then
            savedCFrame = myRoot.CFrame
            savePosBtn.Text = "Position Saved! (Kaydedildi)"
            task.delay(1.5, function()
                savePosBtn.Text = "Save Position (Konum Kaydet)"
            end)
        end
    end)
end)

local tpSavedBtn = Instance.new("TextButton")
tpSavedBtn.Size = UDim2.new(0, 345, 0, 35)
tpSavedBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 100)
tpSavedBtn.BorderSizePixel = 0
tpSavedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpSavedBtn.TextSize = 11
tpSavedBtn.Font = Enum.Font.GothamBold
tpSavedBtn.Text = "TP to Saved Position (Kaydedilene Git)"
tpSavedBtn.ZIndex = 1000
tpSavedBtn.Parent = pageTeleport
Instance.new("UICorner", tpSavedBtn).CornerRadius = UDim.new(0, 6)

tpSavedBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if savedCFrame then
            local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myRoot then
                myRoot.CFrame = savedCFrame
            end
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

refreshPlayerList = function()
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

combatTabBtn.MouseButton1Click:Connect(refreshCombatList)
tpTabBtn.MouseButton1Click:Connect(refreshPlayerList)

Players.PlayerAdded:Connect(function()
    refreshPlayerList()
    refreshCombatList()
end)

Players.PlayerRemoving:Connect(function()
    refreshPlayerList()
    refreshCombatList()
end)

task.spawn(refreshPlayerList)
task.spawn(refreshCombatList)

-- Takım Renkleri Fonksiyonu
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

-- Gelişmiş ESP Loop
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local char = player.Character
            local head = char:FindFirstChild("Head")
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            local box = char:FindFirstChild("CleanESPBox")
            local bill = char:FindFirstChild("CleanESPBillboard")
            
            if espActive and head and hum and hum.Health > 0 then
                if not box then
                    box = Instance.new("Highlight")
                    box.Name = "CleanESPBox"
                    box.Adornee = char
                    box.Parent = char
                end
                box.FillColor = getTeamColor(player)
                box.OutlineColor = Color3.fromRGB(255, 255, 255)
                box.Enabled = true

                if not bill then
                    bill = Instance.new("BillboardGui")
                    bill.Name = "CleanESPBillboard"
                    bill.Size = UDim2.new(0, 150, 0, 50)
                    bill.StudsOffset = Vector3.new(0, 3, 0)
                    bill.AlwaysOnTop = true
                    bill.Adornee = head
                    bill.Parent = char

                    local txt = Instance.new("TextLabel")
                    txt.Name = "InfoText"
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                    txt.TextSize = 11
                    txt.Font = Enum.Font.GothamBold
                    txt.TextStrokeTransparency = 0.2
                    txt.Parent = bill
                end
                
                local tName = player.Team and player.Team.Name or "Unknown"
                local txtLabel = bill:FindFirstChild("InfoText")
                if txtLabel then
                    txtLabel.Text = player.Name .. "\nHP: " .. math.floor(hum.Health) .. " | " .. tName
                end
                bill.Enabled = true
            else
                if box then box.Enabled = false end
                if bill then bill.Enabled = false end
            end
        end
    end
end)

-- Fly, Speed, FOV ve Ignore (Blacklist) Aimbot Motoru
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
            if player ~= localPlayer and not ignoredTargets[player] and player.Character then
                local pChar = player.Character
                local head = pChar:FindFirstChild("Head")
                local pHum = pChar:FindFirstChildOfClass("Humanoid")
                
                if head and pHum and pHum.Health > 0 then
                    local pos, onScreen = camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        -- Dinamik FOV Yarıçapı Kontrolü
                        if dist <= fovRadiusVal and dist < minDist then
                            local canSee = true
                            if wallCheckActive then
                                local rayParams = RaycastParams.new()
                                rayParams.FilterType = Enum.RaycastFilterType.Exclude
                                rayParams.FilterDescendantsInstances = {char, camera}
                                local res = workspace:Raycast(camera.CFrame.Position, head.Position - camera.CFrame.Position, rayParams)
                                if res and not res.Instance:IsDescendantOf(pChar) then
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
