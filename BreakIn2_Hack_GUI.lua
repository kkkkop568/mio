
-- Break In 2 핵 GUI 허브 (강화버전)
-- 포함 기능: 아이템 소환, 자동사냥, 문 열기, 고드모드, 적 얼리기, 자동 줍기, 밝기 설정, 플라이, 스피드핵 등

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "BreakIn2_GUI_Hub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 500)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.1
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local function makeButton(txt, func)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, -10, 0, 30)
    b.Position = UDim2.new(0, 5, 0, 0)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.Text = txt
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

-- 아이템 소환
local itemNames = {"Pizza", "Apple", "TeddyBloxpin", "BloxyCola", "MedKit", "TeddyBear", "Crowbar", "Bat"}
for _, itemName in pairs(itemNames) do
    makeButton(itemName.." 소환", function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj.Name == itemName then
                local cloned = obj:Clone()
                cloned.Parent = LocalPlayer.Backpack
                break
            end
        end
    end)
end

-- 자동사냥
makeButton("자동사냥", function()
    getgenv().AutoHunt = true
    while getgenv().AutoHunt do
        for _, npc in pairs(workspace:GetDescendants()) do
            if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") and npc.Name ~= LocalPlayer.Name then
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - npc.HumanoidRootPart.Position).magnitude < 50 then
                    hrp.CFrame = CFrame.new(npc.HumanoidRootPart.Position + Vector3.new(0, 0, 3))
                    local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                    wait(0.3)
                end
            end
        end
        wait(0.1)
    end
end)

-- 문 열기
makeButton("모든 문 열기", function()
    for _, door in pairs(workspace:GetDescendants()) do
        if door:IsA("Part") and door.Name:lower():find("door") then
            door.CanCollide = false
            door.Transparency = 0.5
        end
    end
end)

-- 고드모드
makeButton("Godmode", function()
    local h = LocalPlayer.Character:FindFirstChild("Humanoid")
    if h then
        h:GetPropertyChangedSignal("Health"):Connect(function()
            h.Health = h.MaxHealth
        end)
    end
end)

-- 적 얼리기
makeButton("적 얼리기", function()
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:FindFirstChild("Humanoid") and npc.Name ~= LocalPlayer.Name then
            npc.HumanoidRootPart.Anchored = true
        end
    end
end)

-- 모든 아이템 줍기
makeButton("모든 아이템 줍기", function()
    for _, tool in pairs(workspace:GetDescendants()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, tool.Handle, 0)
            wait(0.1)
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, tool.Handle, 1)
        end
    end
end)

-- 밝기 설정
makeButton("Full Bright", function()
    local lighting = game:GetService("Lighting")
    lighting.Brightness = 3
    lighting.FogEnd = 100000
    lighting.ClockTime = 12
end)

-- 스피드
makeButton("스피드 50", function()
    LocalPlayer.Character.Humanoid.WalkSpeed = 50
end)

-- 플라이 (F키 작동)
makeButton("플라이", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/torosaur/roblox-scripts/main/simplefly.lua"))()
end)

-- 닫기 버튼
makeButton("GUI 닫기", function()
    gui:Destroy()
end)
