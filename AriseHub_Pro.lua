local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local mouse = LocalPlayer:GetMouse()

local Islands = {
    ["Leveling City"] = CFrame.new(100,10,100),
    ["Grass Village"] = CFrame.new(200,10,200),
    ["Brum Island"] = CFrame.new(300,10,300),
    ["Faceheal Town"] = CFrame.new(400,10,400),
    ["Lucky Kingdom"] = CFrame.new(500,10,500),
    ["Nipon City"] = CFrame.new(600,10,600),
    ["Mori Town"] = CFrame.new(700,10,700),
    ["Winter Raid"] = CFrame.new(800,10,800),
    ["Infernal Castle"] = CFrame.new(900,10,900)
}

local MountsFolder = Workspace:WaitForChild("Mounts")

local function GetAvailableMount()
    for _, mount in pairs(MountsFolder:GetChildren()) do
        if (mount.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 100 then
            return mount
        end
    end
    return nil
end

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "AriseHub"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 460, 0, 520)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(75, 75, 85)
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "AriseHub Script"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 26
Title.TextColor3 = Color3.fromRGB(200, 200, 230)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 10)
Title.Size = UDim2.new(1, -30, 0, 40)
Title.TextXAlignment = Enum.TextXAlignment.Left

local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 48, 0, 48)
ToggleButton.Position = UDim2.new(0, 15, 0, 15)
ToggleButton.Image = "rbxassetid://117370952363353"
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.BackgroundColor3 = Color3.fromRGB(30,30,35)
ToggleButton.BorderSizePixel = 0
ToggleButton.AnchorPoint = Vector2.new(0,0)
ToggleButton.AutoButtonColor = false
ToggleButton.ImageColor3 = Color3.fromRGB(220,220,255)

local function TweenColor(object, color, time)
    local tween = TweenService:Create(object, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = color})
    tween:Play()
end

ToggleButton.MouseEnter:Connect(function()
    TweenColor(ToggleButton, Color3.fromRGB(45,45,50))
end)
ToggleButton.MouseLeave:Connect(function()
    TweenColor(ToggleButton, Color3.fromRGB(30,30,35))
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local TabsFrame = Instance.new("Frame", MainFrame)
TabsFrame.Size = UDim2.new(1, -30, 1, -70)
TabsFrame.Position = UDim2.new(0, 15, 0, 55)
TabsFrame.BackgroundTransparency = 1
TabsFrame.ClipsDescendants = true

local Tabs = {}
local Pages = {}

local TabNames = {"AutoFarm", "Winter", "Castle", "Raid", "Misc", "Info"}

local selectedTab = nil

local TabButtonContainer = Instance.new("Frame", MainFrame)
TabButtonContainer.Size = UDim2.new(1, -30, 0, 40)
TabButtonContainer.Position = UDim2.new(0, 15, 0, 45)
TabButtonContainer.BackgroundTransparency = 1

for i, name in ipairs(TabNames) do
    local btn = Instance.new("TextButton", TabButtonContainer)
    btn.Text = name
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(180, 180, 220)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(0, 70, 1, 0)
    btn.Position = UDim2.new(0, (i-1)*75, 0, 0)
    btn.AutoButtonColor = false
    btn.Name = name.."Tab"

    local function SetActive()
        for _, v in pairs(Tabs) do
            v.TextColor3 = Color3.fromRGB(180, 180, 220)
            v.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[name].Visible = true
        selectedTab = name
    end

    btn.MouseEnter:Connect(function()
        if selectedTab ~= name then
            TweenColor(btn, Color3.fromRGB(55, 55, 70))
        end
    end)
    btn.MouseLeave:Connect(function()
        if selectedTab ~= name then
            TweenColor(btn, Color3.fromRGB(40, 40, 50))
        end
    end)

    btn.MouseButton1Click:Connect(SetActive)

    Tabs[name] = btn

    local page = Instance.new("ScrollingFrame", TabsFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Position = UDim2.new(0, 0, 0, 0)
    page.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    page.BorderSizePixel = 0
    page.CanvasSize = UDim2.new(0, 0, 2, 0)
    page.ScrollBarThickness = 5
    page.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 180)
    page.Visible = false
    page.Name = name.."Page"

    Pages[name] = page
end

Tabs["AutoFarm"].TextColor3 = Color3.fromRGB(255, 255, 255)
Tabs["AutoFarm"].BackgroundColor3 = Color3.fromRGB(70, 70, 90)
Pages["AutoFarm"].Visible = true
selectedTab = "AutoFarm"

local function CreateSection(parent, title, y)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Text = title
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 20
    lbl.TextColor3 = Color3.fromRGB(210, 210, 240)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0, 10, 0, y)
    lbl.Size = UDim2.new(1, -20, 0, 25)
    return lbl
end

local function CreateToggle(parent, text, posY, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -20, 0, 30)
    frame.Position = UDim2.new(0, 10, 0, posY)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(220, 220, 255)
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", frame)
    toggle.Size = UDim2.new(0, 50, 0, 25
