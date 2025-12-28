local old = game.Players.LocalPlayer.PlayerGui:FindFirstChild("XenoFinal")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XenoFinal"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- ==========================================
-- 1. TOMBOL BUKA (LOGO KECIL DI KANAN BAWAH)
-- ==========================================
local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "OpenButton"
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(1, -70, 1, -70) -- Posisi Kanan Bawah
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenBtn.Text = "X" -- Bisa diganti logo lain
OpenBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 25
OpenBtn.Visible = false -- Sembunyi saat menu utama buka
OpenBtn.Parent = screenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 10)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(0, 255, 150)
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

-- ==========================================
-- 2. MAIN FRAME (MENU UTAMA)
-- ==========================================
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true 
Main.Parent = screenGui

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 255, 150) 
MainStroke.Thickness = 2
MainStroke.Parent = Main

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

-- FUNGSI BUKA/TUTUP (TOGGLE)
local function ToggleUI(state)
    if state == "hide" then
        Main.Visible = false
        OpenBtn.Visible = true
    else
        Main.Visible = true
        OpenBtn.Visible = false
    end
end

OpenBtn.MouseButton1Click:Connect(function()
    ToggleUI("show")
end)

-- ==========================================
-- 3. SIDEBAR & HALAMAN (Sama Seperti Sebelumnya)
-- ==========================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Sidebar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "Mugen DotLord"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Sidebar

local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -130, 1, -10)
PageContainer.Position = UDim2.new(0, 125, 0, 5)
PageContainer.BackgroundTransparency = 1
PageContainer.ClipsDescendants = true
PageContainer.Parent = Main

local Pages = {}

local function CreatePage(name)
    local Page = Instance.new("Frame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Position = UDim2.new(2, 0, 0, 0)
    Page.BackgroundTransparency = 1
    Page.Parent = PageContainer
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0, 8)
    Pages[name] = Page
    return Page
end

local function ShowPage(name)
    for i, v in pairs(Pages) do v.Position = UDim2.new(2, 0, 0, 0) end
    Pages[name].Position = UDim2.new(0, 0, 0, 0)
end

local tabCount = 0
local function AddTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, 60 + (tabCount * 40))
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = Sidebar
    Instance.new("UICorner").Parent = btn
    btn.MouseButton1Click:Connect(function() ShowPage(name) end)
    tabCount = tabCount + 1
end

local function AddButton(parent, text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 40)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Gotham
    b.Parent = parent
    Instance.new("UICorner").Parent = b
    b.MouseButton1Click:Connect(callback)
end

local function Notify(title, text, duration)
    local sg = game.Players.LocalPlayer.PlayerGui:FindFirstChild("XenoFinal") or game.Players.LocalPlayer.PlayerGui:FindFirstChildOfClass("ScreenGui")
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 200, 0, 60)
    NotifFrame.Position = UDim2.new(1, 0, 0.8, 0) -- Mulai dari luar layar kanan
    NotifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    NotifFrame.BorderSizePixel = 0
    NotifFrame.Parent = sg
    
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", NotifFrame)
    Stroke.Color = Color3.fromRGB(0, 255, 150)
    Stroke.Thickness = 2

    local Ttl = Instance.new("TextLabel", NotifFrame)
    Ttl.Size = UDim2.new(1, 0, 0.4, 0)
    Ttl.Text = title
    Ttl.TextColor3 = Color3.fromRGB(0, 255, 150)
    Ttl.BackgroundTransparency = 1
    Ttl.Font = Enum.Font.GothamBold
    Ttl.TextSize = 14

    local Msg = Instance.new("TextLabel", NotifFrame)
    Msg.Size = UDim2.new(1, 0, 0.6, 0)
    Msg.Position = UDim2.new(0, 0, 0.4, 0)
    Msg.Text = text
    Msg.TextColor3 = Color3.new(1, 1, 1)
    Msg.BackgroundTransparency = 1
    Msg.Font = Enum.Font.Gotham
    Msg.TextSize = 12

    -- Animasi Masuk
    NotifFrame:TweenPosition(UDim2.new(1, -210, 0.8, 0), "Out", "Quart", 0.5, true)
    
    -- Tunggu lalu Hilang
    task.delay(duration or 3, function()
        NotifFrame:TweenPosition(UDim2.new(1, 0, 0.8, 0), "In", "Quart", 0.5, true)
        task.wait(0.5)
        NotifFrame:Destroy()
    end)
end

-- SETUP TAB
AddTab("ESP")
AddTab("System")
AddTab("Exploit")

local PageESP = CreatePage("ESP")
local PageSystem = CreatePage("System")
local pageExploit = CreatePage("Exploit")

local NameTagActive = false
local HighlightActive = false

local Flying = false
local FlySpeed = 50
local FlyConnection
local InfJumpEnabled = false
local JumpConnection

local SpeedActive = false
local NormalSpeed = 16
local CustomSpeed = 100
local AutoHealthActive = false

-- ==========================================
--                  esp
-- ==========================================
AddButton(PageESP, "NAME TAG", function()
    NameTagActive = not NameTagActive
    
    local function ApplyNameTag(v)
        if not NameTagActive then return end
        if v.Character and v.Character:FindFirstChild("Head") then
            if v.Character.Head:FindFirstChild("XenoESP") then v.Character.Head.XenoESP:Destroy() end
            
            local head = v.Character.Head
            local hum = v.Character:FindFirstChild("Humanoid")
            local billboard = Instance.new("BillboardGui", head)
            billboard.Name = "XenoESP"
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true

            local nameLabel = Instance.new("TextLabel", billboard)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
            nameLabel.Text = v.Name
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.TextSize = 14
            nameLabel.TextStrokeTransparency = 0.5

            local healthLabel = Instance.new("TextLabel", billboard)
            healthLabel.BackgroundTransparency = 1
            healthLabel.Position = UDim2.new(0, 0, 0.5, 0)
            healthLabel.Size = UDim2.new(1, 0, 0.5, 0)
            healthLabel.Text = "HP: " .. math.floor(hum.Health)
            healthLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
            healthLabel.TextSize = 12
            
            hum.HealthChanged:Connect(function()
                healthLabel.Text = "HP: " .. math.floor(hum.Health)
            end)
        end
    end

    if NameTagActive then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then 
                ApplyNameTag(p)
                p.CharacterAdded:Connect(function()
                    task.wait(1)
                    if NameTagActive then ApplyNameTag(p) end
                end)
            end
        end
    else
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") then
                local tag = p.Character.Head:FindFirstChild("XenoESP")
                if tag then tag:Destroy() end
            end
        end
    end
end)

AddButton(PageESP, "HIGHLIGHT ESP", function()
    HighlightActive = not HighlightActive
    
    local function ApplyHighlight(p)
        if not HighlightActive or not p.Character then return end
        if not p.Character:FindFirstChild("XenoHighlight") then
            local hl = Instance.new("Highlight", p.Character)
            hl.Name = "XenoHighlight"
            hl.FillColor = Color3.fromRGB(255, 0, 0)
            hl.OutlineColor = Color3.new(1, 1, 1)
            hl.FillTransparency = 0.5
        end
    end

    if HighlightActive then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                ApplyHighlight(p)
                p.CharacterAdded:Connect(function()
                    task.wait(1)
                    if HighlightActive then ApplyHighlight(p) end
                end)
            end
        end
    else
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character then
                local hl = p.Character:FindFirstChild("XenoHighlight")
                if hl then hl:Destroy() end
            end
        end
    end
end)

-- ==========================================
--                  systems
-- ==========================================

AddButton(PageSystem, "RECONNECT SERVER", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)

AddButton(PageSystem, "HIDE MENU", function()
    ToggleUI("hide")
end)

AddButton(PageSystem, "Disable Script", function()
    screenGui:Destroy()
end)

-- ==========================================
--                  esp
-- ==========================================
AddButton(pageExploit, "TELEPORT", function()
    local sg = game.Players.LocalPlayer.PlayerGui:FindFirstChild("XenoFinal") or game.Players.LocalPlayer.PlayerGui:FindFirstChildOfClass("ScreenGui")
    if sg:FindFirstChild("TPMenu") then sg.TPMenu:Destroy() end

    local TPMenu = Instance.new("Frame")
    TPMenu.Name = "TPMenu"
    TPMenu.Size = UDim2.new(0, 250, 0, 150)
    TPMenu.Position = UDim2.new(0.5, -125, 0.5, -75)
    TPMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TPMenu.Active = true
    TPMenu.Draggable = true
    TPMenu.Parent = sg

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = TPMenu

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 255, 150)
    Stroke.Thickness = 2
    Stroke.Parent = TPMenu

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "TELEPORT TO PLAYER"
    Title.TextColor3 = Color3.fromRGB(0, 255, 150)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.Parent = TPMenu

    local InputName = Instance.new("TextBox")
    InputName.Size = UDim2.new(0.9, 0, 0, 35)
    InputName.Position = UDim2.new(0.05, 0, 0.35, 0)
    InputName.PlaceholderText = "Ketik Nama Player..."
    InputName.Text = ""
    InputName.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    InputName.TextColor3 = Color3.new(1, 1, 1)
    InputName.Font = Enum.Font.Gotham
    InputName.Parent = TPMenu
    Instance.new("UICorner", InputName)

    local GoBtn = Instance.new("TextButton")
    GoBtn.Size = UDim2.new(0.9, 0, 0, 35)
    GoBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
    GoBtn.Text = "TELEPORT"
    GoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    GoBtn.TextColor3 = Color3.new(1, 1, 1)
    GoBtn.Font = Enum.Font.GothamBold
    GoBtn.Parent = TPMenu
    Instance.new("UICorner", GoBtn)

    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.Position = UDim2.new(1, -35, 0, 5)
    Close.Text = "X"
    Close.TextColor3 = Color3.new(1, 0, 0)
    Close.BackgroundTransparency = 1
    Close.Parent = TPMenu
    Close.MouseButton1Click:Connect(function() TPMenu:Destroy() end)

    GoBtn.MouseButton1Click:Connect(function()
        local targetName = string.lower(InputName.Text)
        local found = false
        
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                if string.find(string.lower(v.Name), targetName) or string.find(string.lower(v.DisplayName), targetName) then
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                        GoBtn.Text = "SUCCESS!"
                        GoBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                        found = true
                        wait(1)
                        GoBtn.Text = "TELEPORT"
                        GoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
                        break
                    end
                end
            end
        end
        
        if not found then
            GoBtn.Text = "PLAYER TIDAK ADA"
            GoBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            wait(1)
            GoBtn.Text = "TELEPORT"
            GoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        end
    end)
end)

AddButton(pageExploit, "FLY MODE", function(btn)
    Flying = not Flying
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera
    
    if Flying then
        -- === JIKA NYALA ===
        Notify("Fly Mode", "ON", 2)
        local bv = Instance.new("BodyVelocity")
        bv.Name = "XenoFlyBV"
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Parent = root
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "XenoFlyBG"
        bg.CFrame = root.CFrame
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.Parent = root
        
        FlyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if Flying and character and root then
                local direction = Vector3.new(0, 0, 0)
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local moveDir = humanoid.MoveDirection
                bv.Velocity = moveDir * FlySpeed
                bg.CFrame = camera.CFrame
                if moveDir.Magnitude > 0 then
                    bv.Velocity = camera.CFrame.LookVector * (moveDir.Magnitude * FlySpeed)
                else
                    bv.Velocity = Vector3.new(0, 0.1, 0)
                end
            else
                if FlyConnection then FlyConnection:Disconnect() end
            end
        end)
    else
        Notify("FLY MODE", "OFF", 2)
        if FlyConnection then FlyConnection:Disconnect() end
        if root:FindFirstChild("XenoFlyBV") then root.XenoFlyBV:Destroy() end
        if root:FindFirstChild("XenoFlyBG") then root.XenoFlyBG:Destroy() end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
        end
    end
end)

AddButton(pageExploit, "INFINITY JUMP", function()
    InfJumpEnabled = not InfJumpEnabled
    if InfJumpEnabled then
        Notify("Infinity Jump", " ON", 2)
        if not JumpConnection then
            JumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                if InfJumpEnabled then
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                end
            end)
        end
    else
        Notify("Infinity Jump", " OFF", 2)
    end
end)

AddButton(pageExploit, "SPEED HACK", function()
    SpeedActive = not SpeedActive
    local player = game.Players.LocalPlayer
    local function SetSpeed(char)
        local hum = char:WaitForChild("Humanoid")
        if SpeedActive then
            hum.WalkSpeed = CustomSpeed
        else
            hum.WalkSpeed = NormalSpeed
        end
    end

    if SpeedActive then
        Notify("Speed Hack", "ON", 2)
        if player.Character then SetSpeed(player.Character) end
        _G.SpeedLoop = player.CharacterAdded:Connect(function(char)
            task.wait(1)
            if SpeedActive then SetSpeed(char) end
        end)
    else
        Notify("Speed Hack", " OFF", 2)
        if player.Character then SetSpeed(player.Character) end
        if _G.SpeedLoop then 
            _G.SpeedLoop:Disconnect() 
            _G.SpeedLoop = nil
        end
    end
end)

AddButton(pageExploit, "AUTO HEALTH", function()
    AutoHealthActive = not AutoHealthActive
    local player = game.Players.LocalPlayer
    if AutoHealthActive then
        Notify("Auto Health", " ON", 2)
        task.spawn(function()
            while AutoHealthActive do
                task.wait(0.1)
                if player.Character then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        if humanoid.Health < humanoid.MaxHealth and humanoid.Health > 0 then
                            humanoid.Health = humanoid.Health + 100
                            humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
                        end
                    end
                end
            end
        end)
    else
        Notify("Auto Health", " OFF", 2)
    end
end)
-- ==========================================
-- ==========================================
ShowPage("Home")
