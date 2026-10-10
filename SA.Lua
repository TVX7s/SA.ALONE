local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

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
Main.Size = UDim2.fromOffset(220, 270)
Main.Position = UDim2.new(0.5, -110, 0.5, -135)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui
Corner(Main, 22)

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "FireBackground"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxthumb://type=Asset&w=420&h=420&id=137972128814884"
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 1
BackgroundImage.Parent = Main
Corner(BackgroundImage, 22)

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
Logo.Image = "rbxthumb://type=Asset&w=420&h=420&id=106392588203843"
Logo.ScaleType = Enum.ScaleType.Fit
Logo.ZIndex = 11
Logo.Parent = Top

local Toggle = Instance.new("ImageButton")
Toggle.Name = "Toggle"
Toggle.Size = UDim2.fromOffset(45, 45)
Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
Toggle.Position = UDim2.new(1, -30, 0.5, -10)
Toggle.BackgroundTransparency = 1
Toggle.BorderSizePixel = 0
Toggle.Image = "rbxthumb://type=Asset&w=420&h=420&id=133828656514275"
Toggle.ScaleType = Enum.ScaleType.Crop
Toggle.Visible = false
Toggle.ZIndex = 20
Toggle.Parent = Gui
Corner(Toggle, 22.5)

local function SmoothShow()
    Main.Visible = true
    Main.Size = UDim2.fromOffset(190, 230)
    Main.Position = UDim2.new(0.5, -95, 0.5, -115)

    TweenService:Create(
        Main,
        TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {
            Size = UDim2.fromOffset(220, 270),
            Position = UDim2.new(0.5, -110, 0.5, -135)
        }
    ):Play()

    Toggle.Visible = false
end

Minimize.Activated:Connect(function()
    local T = TweenService:Create(
        Main,
        TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
        {
            Size = UDim2.fromOffset(0, 0),
            Position = UDim2.new(0.5, 110, 0.5, 135)
        }
    )

    T:Play()
    T.Completed:Once(function()
        Main.Visible = false
        Main.Size = UDim2.fromOffset(220, 270)
        Main.Position = UDim2.new(0.5, -110, 0.5, -135)
        Toggle.Visible = true
    end)
end)

Toggle.Activated:Connect(SmoothShow)

Close.Activated:Connect(function()
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

local Dragging = false
local DragStart
local StartPosition

Top.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then
        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
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
