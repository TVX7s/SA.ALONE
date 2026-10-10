local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer

local Old = CoreGui:FindFirstChild("TVX_UI")
if Old then
    Old:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "TVX_UI"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = CoreGui

local function Corner(Object, Radius)
    local C = Instance.new("UICorner")
    C.CornerRadius = UDim.new(0, Radius)
    C.Parent = Object
end

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(240, 290)
Main.Position = UDim2.new(0.5, -120, 0.5, -145)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui
Corner(Main, 22)

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "FireBackground"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxthumb://type=Asset&w=420&h=420&id=121009920200905"
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 1
BackgroundImage.Parent = Main
Corner(BackgroundImage, 22)

local CenterImage = Instance.new("ImageLabel")
CenterImage.Name = "CenterImage"
CenterImage.Size = UDim2.fromOffset(140, 140)
CenterImage.Position = UDim2.new(0.5, -70, 0.5, -85)
CenterImage.BackgroundTransparency = 1
CenterImage.Image = "rbxassetid://"
CenterImage.ScaleType = Enum.ScaleType.Fit
CenterImage.ZIndex = 2
CenterImage.Parent = Main

local Top = Instance.new("Frame")
Top.Name = "TopBar"
Top.Size = UDim2.new(1, 0, 0, 40)
Top.BackgroundTransparency = 1
Top.ZIndex = 10
Top.Parent = Main

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Size = UDim2.fromOffset(28, 27)
Close.Position = UDim2.new(1, -34, 0, 8)
Close.BackgroundColor3 = Color3.fromRGB(120, 25, 10)
Close.BorderSizePixel = 0
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 65, 40)
Close.TextSize = 16
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false
Close.ZIndex = 11
Close.Parent = Top
Corner(Close, 8)

local Minimize = Instance.new("TextButton")
Minimize.Name = "Minimize"
Minimize.Size = UDim2.fromOffset(28, 27)
Minimize.Position = UDim2.fromOffset(6, 8)
Minimize.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Minimize.BorderSizePixel = 0
Minimize.Text = "~"
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.TextSize = 18
Minimize.Font = Enum.Font.GothamBold
Minimize.AutoButtonColor = false
Minimize.ZIndex = 11
Minimize.Parent = Top
Corner(Minimize, 8)

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.fromOffset(300, 90)
Logo.Position = UDim2.new(0.5, -150, 0, 6)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://"
Logo.ScaleType = Enum.ScaleType.Fit
Logo.ZIndex = 11
Logo.Parent = Top

local ActionButton = Instance.new("ImageButton")
ActionButton.Name = "ActionButton"
ActionButton.Size = UDim2.fromOffset(190, 58)
ActionButton.AnchorPoint = Vector2.new(0.5, 0.5)
ActionButton.Position = UDim2.new(0.5, 0, 0.5, 43)
ActionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.BorderSizePixel = 0
ActionButton.Image = "rbxthumb://type=Asset&w=420&h=420&id=140450863774043"
ActionButton.ScaleType = Enum.ScaleType.Crop
ActionButton.AutoButtonColor = false
ActionButton.ZIndex = 15
ActionButton.Parent = Main
Corner(ActionButton, 14)

local ButtonTitle = Instance.new("ImageLabel")
ButtonTitle.Name = "ButtonTitle"
ButtonTitle.Size = UDim2.new(1, -8, 1, -6)
ButtonTitle.AnchorPoint = Vector2.new(0.5, 0.5)
ButtonTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
ButtonTitle.BackgroundTransparency = 1
ButtonTitle.Image = "rbxthumb://type=Asset&w=420&h=420&id=85925198534817"
ButtonTitle.ScaleType = Enum.ScaleType.Stretch
ButtonTitle.ZIndex = 16
ButtonTitle.Parent = ActionButton

local Toggle = Instance.new("ImageButton")
Toggle.Name = "Toggle"
Toggle.Size = UDim2.fromOffset(45, 45)
Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
Toggle.Position = UDim2.new(1, -30, 0.5, -10)
Toggle.BackgroundTransparency = 1
Toggle.BorderSizePixel = 0
Toggle.Image = "rbxthumb://type=Asset&w=420&h=420&id=90595100569140"
Toggle.ScaleType = Enum.ScaleType.Crop
Toggle.Visible = false
Toggle.ZIndex = 20
Toggle.Parent = Gui
Corner(Toggle, 22.5)

local function PlaySound()
    pcall(function()
        local S = Instance.new("Sound")
        S.SoundId = "rbxassetid://102936990343624"
        S.Volume = 1
        S.Parent = SoundService
        S:Play()
        S.Ended:Connect(function()
            S:Destroy()
        end)
    end)
    pcall(function()
        local S2 = Instance.new("Sound")
        S2.SoundId = "https://files.catbox.moe/hiwbwp.mp3"
        S2.Volume = 1
        S2.Parent = SoundService
        S2:Play()
        S2.Ended:Connect(function()
            S2:Destroy()
        end)
    end)
end

local AntiRagdollEnabled = false

ActionButton.Activated:Connect(function()
    PlaySound()
    AntiRagdollEnabled = not AntiRagdollEnabled
    
    if AntiRagdollEnabled then
        BackgroundImage.ImageColor3 = Color3.fromRGB(255, 40, 40)
        ActionButton.ImageColor3 = Color3.fromRGB(255, 40, 40)
    else
        BackgroundImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
        ActionButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    local pulseTween1 = TweenService:Create(
        ActionButton,
        TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.fromOffset(204, 64)}
    )
    local pulseTween2 = TweenService:Create(
        ActionButton,
        TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.fromOffset(190, 58)}
    )
    
    pulseTween1:Play()
    pulseTween1.Completed:Once(function()
        pulseTween2:Play()
    end)
end)

Close.Activated:Connect(function()
    PlaySound()
    local T = TweenService:Create(
        Main,
        TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
        {
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(0, 0)
        }
    )

    T:Play()
    T.Completed:Once(function()
        Gui:Destroy()
    end)
end)

Minimize.Activated:Connect(function()
    PlaySound()
    local T = TweenService:Create(
        Main,
        TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
        {
            Size = UDim2.fromOffset(0, 0),
            Position = UDim2.new(0.5, 120, 0.5, 145)
        }
    )

    T:Play()
    T.Completed:Once(function()
        Main.Visible = false
        Main.Size = UDim2.fromOffset(240, 290)
        Main.Position = UDim2.new(0.5, -120, 0.5, -145)
        Toggle.Visible = true
    end)
end)

local function SmoothShow()
    PlaySound()
    Main.Visible = true
    Main.Size = UDim2.fromOffset(200, 240)
    Main.Position = UDim2.new(0.5, -100, 0.5, -120)

    TweenService:Create(
        Main,
        TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {
            Size = UDim2.fromOffset(240, 290),
            Position = UDim2.new(0.5, -120, 0.5, -145)
        }
    ):Play()

    Toggle.Visible = false
end

Toggle.Activated:Connect(SmoothShow)

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and AntiRagdollEnabled then
            if hum:GetState() == Enum.HumanoidStateType.Physics or hum:GetState() == Enum.HumanoidStateType.Ragdoll then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
    end
end)

local Dragging = false
local DragStart = Vector3.new()
local StartPosition = UDim2.new()
local CurrentPos = Main.Position
local TargetPos = Main.Position

Top.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position
        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then
        local Delta = Input.Position - DragStart

        TargetPos = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

RunService.RenderStepped:Connect(function(dt)
    CurrentPos = UDim2.new(
        CurrentPos.X.Scale,
        CurrentPos.X.Offset + (TargetPos.X.Offset - CurrentPos.X.Offset) * math.clamp(dt * 12, 0, 1),
        CurrentPos.Y.Scale,
        CurrentPos.Y.Offset + (TargetPos.Y.Offset - CurrentPos.Y.Offset) * math.clamp(dt * 12, 0, 1)
    )
    if Dragging then
        Main.Position = CurrentPos
    else
        TargetPos = Main.Position
    end
end)
