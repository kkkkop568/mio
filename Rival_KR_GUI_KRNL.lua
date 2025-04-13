-- KRNL 전용 GUI 허브 (라이벌용)
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyBtn = Instance.new("TextButton")
local ESPBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

-- GUI 속성 설정
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "RivalKR_GUI"

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Position = UDim2.new(0.3, 0, 0.3, 0)
Main.Size = UDim2.new(0, 250, 0, 200)
Main.Active = true
Main.Draggable = true

Title.Name = "Title"
Title.Parent = Main
Title.Text = "라이벌 핵 허브"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

FlyBtn.Name = "FlyBtn"
FlyBtn.Parent = Main
FlyBtn.Text = "비행 켜기/끄기"
FlyBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
FlyBtn.Size = UDim2.new(0.8, 0, 0, 40)
FlyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.SourceSans
FlyBtn.TextScaled = true

ESPBtn.Name = "ESPBtn"
ESPBtn.Parent = Main
ESPBtn.Text = "ESP 켜기/끄기"
ESPBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
ESPBtn.Size = UDim2.new(0.8, 0, 0, 40)
ESPBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.Font = Enum.Font.SourceSans
ESPBtn.TextScaled = true

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = Main
CloseBtn.Text = "X"
CloseBtn.Position = UDim2.new(0.9, -25, 0, 5)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextScaled = true

-- 기능
local flying = false
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7yh/NamelessAdmin/main/FEFly.lua"))()
end)

local espEnabled = false
ESPBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "알림",
            Text = "ESP 비활성화는 아직 지원되지 않음",
            Duration = 3
        })
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
