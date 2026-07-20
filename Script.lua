# local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local WS = workspace
local Cam = WS.CurrentCamera
local Lighting = game:GetService("Lighting")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = "Vex"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

local Toggle = Instance.new("TextButton")
Toggle.Parent = ScreenGui
Toggle.Size = UDim2.new(0, 50, 0, 50)
Toggle.Position = UDim2.new(1, -60, 0, 20)
Toggle.Text = "VM"
Toggle.BackgroundColor3 = Color3.new(0.08, 0.08, 0.1)
Toggle.TextColor3 = Color3.new(0, 1, 0.7)
Toggle.Font = Enum.Font.SourceSansBold
Toggle.TextSize = 18
Toggle.ZIndex = 99
Toggle.BorderSizePixel = 0
Toggle.AutoButtonColor = false
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", Toggle).Color = Color3.new(0, 1, 0.7)

local Menu = Instance.new("Frame")
Menu.Parent = ScreenGui
Menu.Size = UDim2.new(0, 260, 0, 360)
Menu.Position = UDim2.new(0.5, -130, 0.5, -180)
Menu.BackgroundColor3 = Color3.new(0.06, 0.06, 0.08)
Menu.Visible = false
Menu.ZIndex = 98
Menu.BorderSizePixel = 0
Menu.Active = true
Menu.ClipsDescendants = true
Instance.new("UICorner", Menu).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", Menu).Color = Color3.new(0, 1, 0.7)

local TopBar = Instance.new("Frame", Menu)
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.new(0.1, 0.1, 0.12)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "By Vex_Mods"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(0, 1, 0.7)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 102

local Close = Instance.new("TextButton", TopBar)
Close.Size = UDim2.new(0, 24, 0, 24)
Close.Position = UDim2.new(1, -30, 0, 4)
Close.Text = "X"
Close.BackgroundColor3 = Color3.new(0.9, 0.2, 0.2)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.SourceSansBold
Close.TextSize = 12
Close.BorderSizePixel = 0
Close.AutoButtonColor = false
Close.ZIndex = 103
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)

local TabFrame = Instance.new("Frame", Menu)
TabFrame.Size = UDim2.new(1, 0, 0, 30)
TabFrame.Position = UDim2.new(0, 0, 0, 34)
TabFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.1)
TabFrame.BorderSizePixel = 0

local Tab1 = Instance.new("TextButton", TabFrame)
Tab1.Size = UDim2.new(0.33, -2, 1, 0)
Tab1.Text = "Ana"
Tab1.BackgroundColor3 = Color3.new(0, 0.7, 0.6)
Tab1.TextColor3 = Color3.new(1, 1, 1)
Tab1.Font = Enum.Font.SourceSansBold
Tab1.TextSize = 12
Tab1.BorderSizePixel = 0
Tab1.AutoButtonColor = false

local Tab2 = Instance.new("TextButton", TabFrame)
Tab2.Size = UDim2.new(0.33, -2, 1, 0)
Tab2.Position = UDim2.new(0.33, 3, 0, 0)
Tab2.Text = "ESP"
Tab2.BackgroundColor3 = Color3.new(0.12, 0.12, 0.14)
Tab2.TextColor3 = Color3.new(0.5, 0.5, 0.5)
Tab2.Font = Enum.Font.SourceSansBold
Tab2.TextSize = 12
Tab2.BorderSizePixel = 0
Tab2.AutoButtonColor = false

local Tab3 = Instance.new("TextButton", TabFrame)
Tab3.Size = UDim2.new(0.34, -2, 1, 0)
Tab3.Position = UDim2.new(0.66, 3, 0, 0)
Tab3.Text = "Fun"
Tab3.BackgroundColor3 = Color3.new(0.12, 0.12, 0.14)
Tab3.TextColor3 = Color3.new(0.5, 0.5, 0.5)
Tab3.Font = Enum.Font.SourceSansBold
Tab3.TextSize = 12
Tab3.BorderSizePixel = 0
Tab3.AutoButtonColor = false

local Page1 = Instance.new("ScrollingFrame", Menu)
Page1.Size = UDim2.new(1, -4, 1, -70)
Page1.Position = UDim2.new(0, 2, 0, 66)
Page1.BackgroundTransparency = 1
Page1.CanvasSize = UDim2.new(0, 0, 0, 500)
Page1.ScrollBarThickness = 4
Page1.ScrollBarImageColor3 = Color3.new(0, 0.7, 0.6)
Page1.BorderSizePixel = 0
Page1.ZIndex = 100
Page1.ScrollingEnabled = true
Page1.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
Page1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
Page1.ScrollingDirection = Enum.ScrollingDirection.Y
Page1.ClipsDescendants = true

local Page2 = Instance.new("ScrollingFrame", Menu)
Page2.Size = UDim2.new(1, -4, 1, -70)
Page2.Position = UDim2.new(0, 2, 0, 66)
Page2.BackgroundTransparency = 1
Page2.CanvasSize = UDim2.new(0, 0, 0, 400)
Page2.ScrollBarThickness = 4
Page2.ScrollBarImageColor3 = Color3.new(0, 0.7, 0.6)
Page2.BorderSizePixel = 0
Page2.Visible = false
Page2.ZIndex = 100
Page2.ScrollingEnabled = true
Page2.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
Page2.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
Page2.ScrollingDirection = Enum.ScrollingDirection.Y
Page2.ClipsDescendants = true

local Page3 = Instance.new("ScrollingFrame", Menu)
Page3.Size = UDim2.new(1, -4, 1, -70)
Page3.Position = UDim2.new(0, 2, 0, 66)
Page3.BackgroundTransparency = 1
Page3.CanvasSize = UDim2.new(0, 0, 0, 300)
Page3.ScrollBarThickness = 4
Page3.ScrollBarImageColor3 = Color3.new(0, 0.7, 0.6)
Page3.BorderSizePixel = 0
Page3.Visible = false
Page3.ZIndex = 100
Page3.ScrollingEnabled = true
Page3.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
Page3.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
Page3.ScrollingDirection = Enum.ScrollingDirection.Y
Page3.ClipsDescendants = true

local Layout1 = Instance.new("UIListLayout", Page1); Layout1.Padding = UDim.new(0, 6); Layout1.HorizontalAlignment = Enum.HorizontalAlignment.Center; Layout1.SortOrder = Enum.SortOrder.LayoutOrder
local Layout2 = Instance.new("UIListLayout", Page2); Layout2.Padding = UDim.new(0, 6); Layout2.HorizontalAlignment = Enum.HorizontalAlignment.Center; Layout2.SortOrder = Enum.SortOrder.LayoutOrder
local Layout3 = Instance.new("UIListLayout", Page3); Layout3.Padding = UDim.new(0, 6); Layout3.HorizontalAlignment = Enum.HorizontalAlignment.Center; Layout3.SortOrder = Enum.SortOrder.LayoutOrder

Layout1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Page1.CanvasSize = UDim2.new(0, 0, 0, Layout1.AbsoluteContentSize.Y + 10)
end)
Layout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Page2.CanvasSize = UDim2.new(0, 0, 0, Layout2.AbsoluteContentSize.Y + 10)
end)
Layout3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Page3.CanvasSize = UDim2.new(0, 0, 0, Layout3.AbsoluteContentSize.Y + 10)
end)

local function makeDraggable(gui)
    local dragging, dragStart, startPos = false, nil, nil
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(Toggle)
makeDraggable(Menu)

Tab1.Activated:Connect(function()
    Page1.Visible = true; Page2.Visible = false; Page3.Visible = false
    Tab1.BackgroundColor3 = Color3.new(0, 0.7, 0.6); Tab1.TextColor3 = Color3.new(1, 1, 1)
    Tab2.BackgroundColor3 = Color3.new(0.12, 0.12, 0.14); Tab2.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    Tab3.BackgroundColor3 = Color3.new(0.12, 0.12, 0.14); Tab3.TextColor3 = Color3.new(0.5, 0.5, 0.5)
end)
Tab2.Activated:Connect(function()
    Page1.Visible = false; Page2.Visible = true; Page3.Visible = false
    Tab1.BackgroundColor3 = Color3.new(0.12, 0.12, 0.14); Tab1.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    Tab2.BackgroundColor3 = Color3.new(0, 0.7, 0.6); Tab2.TextColor3 = Color3.new(1, 1, 1)
    Tab3.BackgroundColor3 = Color3.new(0.12, 0.12, 0.14); Tab3.TextColor3 = Color3.new(0.5, 0.5, 0.5)
end)
Tab3.Activated:Connect(function()
    Page1.Visible = false; Page2.Visible = false; Page3.Visible = true
    Tab1.BackgroundColor3 = Color3.new(0.12, 0.12, 0.14); Tab1.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    Tab2.BackgroundColor3 = Color3.new(0.12, 0.12, 0.14); Tab2.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    Tab3.BackgroundColor3 = Color3.new(0, 0.7, 0.6); Tab3.TextColor3 = Color3.new(1, 1, 1)
end)

local flySpeed = 50
local walkSpeed = 16
local jumpPower = 50
local fov = 70
local flying, noclip, esp, infJump, aimbot, spinbot, fullBright, lowGrav, hitbox, speedHack, jumpHack = false, false, false, false, false, false, false, false, false, false, false
local defaultAmbient = Lighting.Ambient
local defaultBrightness = Lighting.Brightness
local defaultShadows = Lighting.GlobalShadows
local defaultClock = Lighting.ClockTime

local function makeBtn(parent, text)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = text
    btn.BackgroundColor3 = Color3.new(0.14, 0.14, 0.16)
    btn.TextColor3 = Color3.new(1, 0.3, 0.3)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    return btn
end

local function makeBox(parent, text)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(1, -10, 0, 28)
    box.Text = text
    box.BackgroundColor3 = Color3.new(0.14, 0.14, 0.16)
    box.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 12
    box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", box).Color = Color3.new(0, 0.7, 0.6)
    return box
end

local FlyBtn = makeBtn(Page1, "Fly [KAPALI]")
local FlyBox = makeBox(Page1, "Fly Hizi: 50")
local SpeedBtn = makeBtn(Page1, "Hiz Hack [KAPALI]")
local SpeedBox = makeBox(Page1, "Hiz: 16")
local JumpBtn = makeBtn(Page1, "Ziplama Hack [KAPALI]")
local JumpBox = makeBox(Page1, "Ziplama: 50")
local NoclipBtn = makeBtn(Page1, "Noclip [KAPALI]")
local InfJumpBtn = makeBtn(Page1, "Inj Jump [KAPALI]")
local GravBtn = makeBtn(Page1, "Dusuk Gravity [KAPALI]")

local ESPBtn = makeBtn(Page2, "ESP [KAPALI]")
local AimBtn = makeBtn(Page2, "Aimbot [KAPALI]")
local FovBox = makeBox(Page2, "FOV: 70")
local FullBrightBtn = makeBtn(Page2, "FullBright [KAPALI]")
local HitboxBtn = makeBtn(Page2, "Genis Hitbox [KAPALI]")

local SpinBtn = makeBtn(Page3, "Spinbot [KAPALI]")

local Crosshair = Instance.new("Frame", ScreenGui)
Crosshair.Size = UDim2.new(0, 40, 0, 40)
Crosshair.Position = UDim2.new(0.5, -20, 0.5, -20)
Crosshair.BackgroundTransparency = 1
Crosshair.ZIndex = 200
Crosshair.Visible = false
for _, v in ipairs({"Left","Right","Top","Bot"}) do
    local f = Instance.new("Frame", Crosshair)
    f.BorderSizePixel = 0; f.BackgroundColor3 = Color3.new(1, 0, 0)
    if v == "Left" then f.Size = UDim2.new(0, 14, 0, 2); f.Position = UDim2.new(0, 0, 0.5, -1)
    elseif v == "Right" then f.Size = UDim2.new(0, 14, 0, 2); f.Position = UDim2.new(1, -14, 0.5, -1)
    elseif v == "Top" then f.Size = UDim2.new(0, 2, 0, 14); f.Position = UDim2.new(0.5, -1, 0, 0)
    elseif v == "Bot" then f.Size = UDim2.new(0, 2, 0, 14); f.Position = UDim2.new(0.5, -1, 1, -14) end
end
local cd = Instance.new("Frame", Crosshair)
cd.Size = UDim2.new(0, 4, 0, 4); cd.Position = UDim2.new(0.5, -2, 0.5, -2)
cd.BackgroundColor3 = Color3.new(1, 1, 1); cd.BorderSizePixel = 0
Instance.new("UICorner", cd).CornerRadius = UDim.new(1, 0)

Toggle.Activated:Connect(function() Menu.Visible = not Menu.Visible end)
Close.Activated:Connect(function() Menu.Visible = false end)

FlyBox.FocusLost:Connect(function()
    local n = tonumber(FlyBox.Text:match("%d+"))
    if n then flySpeed = math.clamp(n, 1, 500); FlyBox.Text = "Fly Hizi: " .. flySpeed end
end)
SpeedBox.FocusLost:Connect(function()
    local n = tonumber(SpeedBox.Text:match("%d+"))
    if n then walkSpeed = math.clamp(n, 1, 500); SpeedBox.Text = "Hiz: " .. walkSpeed end
end)
JumpBox.FocusLost:Connect(function()
    local n = tonumber(JumpBox.Text:match("%d+"))
    if n then jumpPower = math.clamp(n, 1, 500); JumpBox.Text = "Ziplama: " .. jumpPower end
end)
FovBox.FocusLost:Connect(function()
    local n = tonumber(FovBox.Text:match("%d+"))
    if n then fov = math.clamp(n, 30, 120); Cam.FieldOfView = fov; FovBox.Text = "FOV: " .. fov end
end)

FlyBtn.Activated:Connect(function()
    flying = not flying
    FlyBtn.Text = "Fly: " .. (flying and "ACIK" or "KAPALI")
    FlyBtn.TextColor3 = flying and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
    local c = Player.Character; local h = c and c:FindFirstChildOfClass("Humanoid")
    if c and c:FindFirstChild("HumanoidRootPart") and h then
        if flying then
            h.PlatformStand = true
            local bg = Instance.new("BodyGyro", c.HumanoidRootPart); bg.P = 9e4; bg.MaxTorque = Vector3.new(9e9,9e9,9e9); bg.CFrame = c.HumanoidRootPart.CFrame
            local bv = Instance.new("BodyVelocity", c.HumanoidRootPart); bv.MaxForce = Vector3.new(9e9,9e9,9e9)
            task.spawn(function()
                while flying and c:FindFirstChild("HumanoidRootPart") and h do
                    RS.RenderStepped:Wait()
                    local md = h.MoveDirection; local vel = Vector3.zero
                    if md.Magnitude > 0 then
                        local fl = Vector3.new(Cam.CFrame.LookVector.X, 0, Cam.CFrame.LookVector.Z).Unit
                        local fr = Vector3.new(Cam.CFrame.RightVector.X, 0, Cam.CFrame.RightVector.Z).Unit
                        vel = (Cam.CFrame.LookVector * md:Dot(fl)) + (Cam.CFrame.RightVector * md:Dot(fr))
                    end
                    if h.Jump then vel += Vector3.new(0,1,0) end
                    bv.Velocity = vel.Magnitude > 0 and vel.Unit * flySpeed or Vector3.zero
                    bg.CFrame = Cam.CFrame
                end
                bg:Destroy(); bv:Destroy(); if h then h.PlatformStand = false end
            end)
        else h.PlatformStand = false end
    end
end)

SpeedBtn.Activated:Connect(function()
    speedHack = not speedHack
    SpeedBtn.Text = "Hiz Hack: " .. (speedHack and "ACIK" or "KAPALI")
    SpeedBtn.TextColor3 = speedHack and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
    if not speedHack and Player.Character then
        local h = Player.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
    end
end)

JumpBtn.Activated:Connect(function()
    jumpHack = not jumpHack
    JumpBtn.Text = "Ziplama Hack: " .. (jumpHack and "ACIK" or "KAPALI")
    JumpBtn.TextColor3 = jumpHack and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
    if not jumpHack and Player.Character then
        local h = Player.Character:FindFirstChildOfClass("Humanoid")
        if h then h.JumpPower = 50; h.UseJumpPower = false end
    end
end)

NoclipBtn.Activated:Connect(function()
    noclip = not noclip
    NoclipBtn.Text = "Noclip: " .. (noclip and "ACIK" or "KAPALI")
    NoclipBtn.TextColor3 = noclip and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
    if not noclip and Player.Character then
        for _, p in ipairs(Player.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end
    end
end)

InfJumpBtn.Activated:Connect(function()
    infJump = not infJump
    InfJumpBtn.Text = "Inj Jump: " .. (infJump and "ACIK" or "KAPALI")
    InfJumpBtn.TextColor3 = infJump and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
end)

GravBtn.Activated:Connect(function()
    lowGrav = not lowGrav
    GravBtn.Text = "Dusuk Gravity: " .. (lowGrav and "ACIK" or "KAPALI")
    GravBtn.TextColor3 = lowGrav and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
    WS.Gravity = lowGrav and 50 or 196.2
end)

ESPBtn.Activated:Connect(function()
    esp = not esp
    ESPBtn.Text = "ESP: " .. (esp and "ACIK" or "KAPALI")
    ESPBtn.TextColor3 = esp and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
    if not esp then
        for _, pl in ipairs(game.Players:GetPlayers()) do
            if pl.Character and pl.Character:FindFirstChild("Head") then
                local bb = pl.Character.Head:FindFirstChild("VexESPBB")
                if bb then bb:Destroy() end
            end
        end
    end
end)

AimBtn.Activated:Connect(function()
    aimbot = not aimbot
    AimBtn.Text = "Aimbot: " .. (aimbot and "ACIK" or "KAPALI")
    AimBtn.TextColor3 = aimbot and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
    Crosshair.Visible = aimbot
end)

FullBrightBtn.Activated:Connect(function()
    fullBright = not fullBright
    FullBrightBtn.Text = "FullBright: " .. (fullBright and "ACIK" or "KAPALI")
    FullBrightBtn.TextColor3 = fullBright and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
    if fullBright then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.ClockTime = 14
    else
        Lighting.Ambient = defaultAmbient
        Lighting.Brightness = defaultBrightness
        Lighting.GlobalShadows = defaultShadows
        Lighting.ClockTime = defaultClock
    end
end)

HitboxBtn.Activated:Connect(function()
    hitbox = not hitbox
    HitboxBtn.Text = "Genis Hitbox: " .. (hitbox and "ACIK" or "KAPALI")
    HitboxBtn.TextColor3 = hitbox and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
    if not hitbox then
        for _, pl in ipairs(game.Players:GetPlayers()) do
            if pl ~= Player and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                pl.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                pl.Character.HumanoidRootPart.Transparency = 1
            end
        end
    end
end)

SpinBtn.Activated:Connect(function()
    spinbot = not spinbot
    SpinBtn.Text = "Spinbot: " .. (spinbot and "ACIK" or "KAPALI")
    SpinBtn.TextColor3 = spinbot and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
end)

RS.Stepped:Connect(function()
    local c = Player.Character
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then
            if speedHack then h.WalkSpeed = walkSpeed end
            if jumpHack then h.UseJumpPower = true; h.JumpPower = jumpPower end
        end
        if noclip then for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
    end
end)

UIS.JumpRequest:Connect(function()
    if infJump and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

RS.RenderStepped:Connect(function()
    if aimbot then
        local t, md = nil, math.huge
        local c = Player.Character
        local mp = c and c:FindFirstChild("HumanoidRootPart") and c.HumanoidRootPart.Position
        if mp then
            for _, pl in ipairs(game.Players:GetPlayers()) do
                if pl ~= Player and pl.Character and pl.Character:FindFirstChild("Head") and pl.Character:FindFirstChildOfClass("Humanoid") and pl.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                    local pos = pl.Character.Head.Position
                    local d = (mp - pos).Magnitude
                    local _, vis = Cam:WorldToViewportPoint(pos)
                    if vis and d < md then md = d; t = pl end
                end
            end
            if t and t.Character and t.Character:FindFirstChild("Head") then
                local targetPos = t.Character.Head.Position
                Cam.CFrame = CFrame.new(Cam.CFrame.Position, targetPos)
                if c and c:FindFirstChild("HumanoidRootPart") then
                    c.HumanoidRootPart.CFrame = CFrame.new(c.HumanoidRootPart.Position, Vector3.new(targetPos.X, c.HumanoidRootPart.Position.Y, targetPos.Z))
                end
            end
        end
    end
    
    if spinbot and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)
    end
    
    if hitbox then
        for _, pl in ipairs(game.Players:GetPlayers()) do
            if pl ~= Player and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                pl.Character.HumanoidRootPart.Size = Vector3.new(15,15,15)
                pl.Character.HumanoidRootPart.Transparency = 0.6
                pl.Character.HumanoidRootPart.CanCollide = false
            end
        end
    end
    
    if esp then
        local mp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.HumanoidRootPart.Position
        for _, pl in ipairs(game.Players:GetPlayers()) do
            if pl ~= Player and pl.Character and pl.Character:FindFirstChild("Head") and pl.Character:FindFirstChildOfClass("Humanoid") and mp then
                local head = pl.Character.Head; local hum = pl.Character:FindFirstChildOfClass("Humanoid")
                local bb = head:FindFirstChild("VexESPBB")
                if not bb then
                    bb = Instance.new("BillboardGui", head); bb.Name = "VexESPBB"
                    bb.Size = UDim2.new(0, 200, 0, 55); bb.StudsOffset = Vector3.new(0, 2.5, 0); bb.AlwaysOnTop = true
                    local tl = Instance.new("TextLabel", bb); tl.Size = UDim2.new(1,0,1,0); tl.BackgroundTransparency = 1
                    tl.TextColor3 = Color3.new(1,1,1); tl.Font = Enum.Font.SourceSansBold; tl.TextSize = 13
                    tl.TextStrokeTransparency = 0; tl.TextStrokeColor3 = Color3.new(0,0,0)
                end
                bb.TextLabel.Text = pl.Name .. "\nCan: " .. math.floor(hum.Health) .. "\nMesafe: " .. math.floor((mp - head.Position).Magnitude) .. "m"
            end
        end
    end
end)

Player.CharacterAdded:Connect(function(c)
    local h = c:WaitForChildOfClass("Humanoid")
    if walkSpeed ~= 16 then h.WalkSpeed = walkSpeed end
    if noclip then task.wait(0.1); for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
    if jumpHack then h.UseJumpPower = true; h.JumpPower = jumpPower end
end)
