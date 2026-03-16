--[[
    URIEL XITER ANDROID 1.108.X
    Script 100% independente - Sem bibliotecas externas
]]

-- Criar GUI principal
local UrielGUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local TabHolder = Instance.new("Frame")
local Tab1 = Instance.new("TextButton")
local Tab2 = Instance.new("TextButton")
local Tab3 = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")

-- Configurar GUI
UrielGUI.Name = "UrielXiterGUI"
UrielGUI.Parent = game.CoreGui
UrielGUI.ResetOnSpawn = false
UrielGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = UrielGUI
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true

-- Barra de título
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 30)

TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Size = UDim2.new(0, 150, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "Uriel Xiter Android 1.108.X"
TitleText.TextColor3 = Color3.fromRGB(255, 100, 100)
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeButton.Position = UDim2.new(1, -55, 0, 5)
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 12
MinimizeButton.MouseButton1Click:Connect(function() ContentFrame.Visible = not ContentFrame.Visible end)

-- Abas
TabHolder.Name = "TabHolder"
TabHolder.Parent = MainFrame
TabHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabHolder.BorderSizePixel = 0
TabHolder.Position = UDim2.new(0, 0, 0, 30)
TabHolder.Size = UDim2.new(1, 0, 0, 40)

Tab1.Name = "Tab1"
Tab1.Parent = TabHolder
Tab1.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
Tab1.Position = UDim2.new(0, 5, 0, 5)
Tab1.Size = UDim2.new(0, 80, 0, 30)
Tab1.Font = Enum.Font.Gotham
Tab1.Text = "Aimbot"
Tab1.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1.TextSize = 12

Tab2.Name = "Tab2"
Tab2.Parent = TabHolder
Tab2.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Tab2.Position = UDim2.new(0, 90, 0, 5)
Tab2.Size = UDim2.new(0, 80, 0, 30)
Tab2.Font = Enum.Font.Gotham
Tab2.Text = "Visuals"
Tab2.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab2.TextSize = 12

Tab3.Name = "Tab3"
Tab3.Parent = TabHolder
Tab3.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Tab3.Position = UDim2.new(0, 175, 0, 5)
Tab3.Size = UDim2.new(0, 80, 0, 30)
Tab3.Font = Enum.Font.Gotham
Tab3.Text = "Settings"
Tab3.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab3.TextSize = 12

-- Conteúdo
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ContentFrame.BorderSizePixel = 0
ContentFrame.Position = UDim2.new(0, 0, 0, 70)
ContentFrame.Size = UDim2.new(1, 0, 1, -70)

-- Criar botão flutuante
local FloatButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

FloatButton.Name = "FloatButton"
FloatButton.Parent = UrielGUI
FloatButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FloatButton.Position = UDim2.new(0, 50, 0, 300)
FloatButton.Size = UDim2.new(0, 70, 0, 70)
FloatButton.Font = Enum.Font.GothamBold
FloatButton.Text = "Uriel.Xiter"
FloatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatButton.TextSize = 10
FloatButton.Draggable = true
FloatButton.Active = true

UICorner.CornerRadius = UDim.new(0, 35)
UICorner.Parent = FloatButton

FloatButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Variáveis globais
local Settings = {
    Aimbot = false,
    FOV = 150,
    ShowFOV = true,
    TargetPart = "Head",
    ESP = false,
    TeamCheck = true
}

-- Função para criar toggle
function CreateToggle(parent, text, yPos, setting)
    local toggle = Instance.new("TextButton")
    local bg = Instance.new("Frame")
    local indicator = Instance.new("Frame")
    
    toggle.Name = "Toggle" .. text
    toggle.Parent = parent
    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    toggle.Position = UDim2.new(0, 10, 0, yPos)
    toggle.Size = UDim2.new(1, -20, 0, 35)
    toggle.Font = Enum.Font.Gotham
    toggle.Text = ""
    
    bg.Name = "BG"
    bg.Parent = toggle
    bg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    bg.Position = UDim2.new(1, -50, 0, 7)
    bg.Size = UDim2.new(0, 50, 0, 20)
    
    indicator.Name = "Indicator"
    indicator.Parent = bg
    indicator.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    indicator.Position = UDim2.new(0, 2, 0, 2)
    indicator.Size = UDim2.new(0, 20, 1, -4)
    
    local label = Instance.new("TextLabel")
    label.Parent = toggle
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local state = false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        if state then
            indicator.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            indicator.Position = UDim2.new(1, -22, 0, 2)
        else
            indicator.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            indicator.Position = UDim2.new(0, 2, 0, 2)
        end
        Settings[setting] = state
    end)
    
    return toggle
end

-- Função para criar slider
function CreateSlider(parent, text, yPos, min, max, setting)
    local slider = Instance.new("Frame")
    slider.Parent = parent
    slider.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    slider.Position = UDim2.new(0, 10, 0, yPos)
    slider.Size = UDim2.new(1, -20, 0, 45)
    
    local label = Instance.new("TextLabel")
    label.Parent = slider
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 5)
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = slider
    valueLabel.BackgroundTransparency = 1
    valueLabel.Position = UDim2.new(1, -60, 0, 5)
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.Text = tostring(Settings[setting])
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.TextSize = 14
    
    local bar = Instance.new("Frame")
    bar.Parent = slider
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    bar.Position = UDim2.new(0, 10, 0, 30)
    bar.Size = UDim2.new(1, -20, 0, 5)
    
    local fill = Instance.new("Frame")
    fill.Parent = bar
    fill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    fill.Size = UDim2.new((Settings[setting] - min) / (max - min), 0, 1, 0)
    
    local drag = Instance.new("TextButton")
    drag.Parent = bar
    drag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    drag.Position = UDim2.new((Settings[setting] - min) / (max - min), -5, -0.5, 0)
    drag.Size = UDim2.new(0, 15, 0, 15)
    drag.Text = ""
    drag.Active = true
    drag.Draggable = true
    
    drag.MouseButton1Down:Connect(function()
        local moveConn
        local releaseConn
        moveConn = game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                local barPos = bar.AbsolutePosition
                local barSize = bar.AbsoluteSize.X
                local percent = math.clamp((mousePos.X - barPos.X) / barSize, 0, 1)
                local value = math.floor(min + (max - min) * percent)
                
                fill.Size = UDim2.new(percent, 0, 1, 0)
                drag.Position = UDim2.new(percent, -7, -0.5, 0)
                valueLabel.Text = tostring(value)
                Settings[setting] = value
            end
        end)
        
        releaseConn = game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                moveConn:Disconnect()
                releaseConn:Disconnect()
            end
        end)
    end)
    
    return slider
end

-- Função para criar dropdown
function CreateDropdown(parent, text, yPos, options, setting)
    local dropdown = Instance.new("TextButton")
    dropdown.Parent = parent
    dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    dropdown.Position = UDim2.new(0, 10, 0, yPos)
    dropdown.Size = UDim2.new(1, -20, 0, 35)
    dropdown.Font = Enum.Font.Gotham
    dropdown.Text = ""
    
    local label = Instance.new("TextLabel")
    label.Parent = dropdown
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text .. ":"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local value = Instance.new("TextLabel")
    value.Parent = dropdown
    value.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    value.Position = UDim2.new(1, -110, 0, 5)
    value.Size = UDim2.new(0, 100, 0, 25)
    value.Font = Enum.Font.Gotham
    value.Text = Settings[setting]
    value.TextColor3 = Color3.fromRGB(255, 255, 255)
    value.TextSize = 12
    
    local open = false
    local optionsFrame = Instance.new("Frame")
    
    dropdown.MouseButton1Click:Connect(function()
        if open then
            optionsFrame:Destroy()
            open = false
        else
            optionsFrame.Parent = parent
            optionsFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            optionsFrame.Position = UDim2.new(0, 10, 0, yPos + 40)
            optionsFrame.Size = UDim2.new(1, -20, 0, #options * 30)
            optionsFrame.BorderSizePixel = 0
            optionsFrame.ZIndex = 10
            
            for i, option in ipairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Parent = optionsFrame
                optBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                optBtn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
                optBtn.Size = UDim2.new(1, 0, 0, 30)
                optBtn.Font = Enum.Font.Gotham
                optBtn.Text = option
                optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                optBtn.TextSize = 12
                optBtn.ZIndex = 11
                
                optBtn.MouseButton1Click:Connect(function()
                    value.Text = option
                    Settings[setting] = option
                    optionsFrame:Destroy()
                    open = false
                end)
            end
            open = true
        end
    end)
end

-- Preencher abas
local aimbotContent = Instance.new("Frame")
aimbotContent.Parent = ContentFrame
aimbotContent.BackgroundTransparency = 1
aimbotContent.Size = UDim2.new(1, 0, 1, 0)

CreateToggle(aimbotContent, "Ativar Aimbot", 10, "Aimbot")
CreateToggle(aimbotContent, "Exibir FOV", 60, "ShowFOV")
CreateSlider(aimbotContent, "Tamanho FOV", 110, 50, 300, "FOV")
CreateDropdown(aimbotContent, "Target", 170, {"Head", "Torso", "HumanoidRootPart"}, "TargetPart")

local visualsContent = Instance.new("Frame")
visualsContent.Parent = ContentFrame
visualsContent.BackgroundTransparency = 1
visualsContent.Size = UDim2.new(1, 0, 1, 0)
visualsContent.Visible = false

CreateToggle(visualsContent, "ESP Box", 10, "ESP")
CreateToggle(visualsContent, "Team Check", 60, "TeamCheck")

local settingsContent = Instance.new("Frame")
settingsContent.Parent = ContentFrame
settingsContent.BackgroundTransparency = 1
settingsContent.Size = UDim2.new(1, 0, 1, 0)
settingsContent.Visible = false

-- Controle das abas
Tab1.MouseButton1Click:Connect(function()
    aimbotContent.Visible = true
    visualsContent.Visible = false
    settingsContent.Visible = false
    Tab1.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
    Tab2.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Tab3.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
end)

Tab2.MouseButton1Click:Connect(function()
    aimbotContent.Visible = false
    visualsContent.Visible = true
    settingsContent.Visible = false
    Tab1.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Tab2.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
    Tab3.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
end)

Tab3.MouseButton1Click:Connect(function()
    aimbotContent.Visible = false
    visualsContent.Visible = false
    settingsContent.Visible = true
    Tab1.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Tab2.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Tab3.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
end)

-- FOV Circle
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 2
fovCircle.NumSides = 64
fovCircle.Color = Color3.new(1, 0, 0)
fovCircle.Filled = false
fovCircle.Visible = false

-- ESP
local espFolder = Instance.new("Folder")
espFolder.Name = "UrielESP"
espFolder.Parent = game.CoreGui

-- Loop principal
game:GetService("RunService").RenderStepped:Connect(function()
    -- FOV
    if Settings.ShowFOV then
        fovCircle.Visible = true
        fovCircle.Radius = Settings.FOV
        fovCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
    else
        fovCircle.Visible = false
    end
    
    -- Aimbot
    if Settings.Aimbot then
        local mouse = game.Players.LocalPlayer:GetMouse()
        local closest = nil
        local dist = Settings.FOV
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                
                if Settings.TeamCheck and player.Team == game.Players.LocalPlayer.Team then
                    continue
                end
                
                local target = player.Character:FindFirstChild(Settings.TargetPart) or player.Character:FindFirstChild("Head")
                if target then
                    local pos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(target.Position)
                    if onScreen then
                        local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                        if magnitude < dist then
                            dist = magnitude
                            closest = target
                        end
                    end
                end
            end
        end
        
        if closest then
            game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, closest.Position)
        end
    end
    
    -- ESP
    if Settings.ESP then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                if not espFolder:FindFirstChild(player.Name) then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = player.Name
                    box.Size = Vector3.new(4, 5, 2)
                    box.AlwaysOnTop = true
                    box.ZIndex = 5
                    box.Adornee = player.Character
                    box.Transparency = 0.5
                    box.Parent = espFolder
                end
                
                local box = espFolder:FindFirstChild(player.Name)
                if box then
                    box.Adornee = player.Character
                    if Settings.TeamCheck then
                        box.Color3 = player.Team == game.Players.LocalPlayer.Team and Color3.new(0,1,0) or Color3.new(1,0,0)
                    else
                        box.Color3 = Color3.new(1,1,0)
                    end
                    box.Visible = true
                end
            end
        end
    else
        for _, v in pairs(espFolder:GetChildren()) do
            v:Destroy()
        end
    end
end)

-- Notificação
game.StarterGui:SetCore("SendNotification", {
    Title = "Uriel Xiter",
    Text = "Script carregado com sucesso!",
    Duration = 3
})

print("Uriel Xiter Android 1.108.X - Carregado!")
