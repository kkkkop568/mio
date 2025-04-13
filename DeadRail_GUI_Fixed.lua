
-- SpiderXHub Dead Rail GUI (Fixed & Enhanced)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "DeadRail_GUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 500, 0, 350)
main.Position = UDim2.new(0.3, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "SpiderXHub | Dead Rail"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 40, 0, 40)
close.Position = UDim2.new(1, -40, 0, 0)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 100, 100)
close.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local minimize = Instance.new("TextButton", main)
minimize.Size = UDim2.new(0, 40, 0, 40)
minimize.Position = UDim2.new(1, -80, 0, 0)
minimize.Text = "-"
minimize.TextColor3 = Color3.fromRGB(255, 255, 100)
minimize.BackgroundColor3 = Color3.fromRGB(40, 40, 0)

local contentFrame = Instance.new("Frame", main)
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1

-- 채권 자동 수집 (고침)
local bondBtn = Instance.new("TextButton", contentFrame)
bondBtn.Size = UDim2.new(0, 200, 0, 40)
bondBtn.Position = UDim2.new(0, 20, 0, 20)
bondBtn.Text = "채권 자동 수집"
bondBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
bondBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local bondCollecting = false
bondBtn.MouseButton1Click:Connect(function()
	bondCollecting = not bondCollecting
	bondBtn.Text = bondCollecting and "채권 수집 중..." or "채권 자동 수집"
	task.spawn(function()
		while bondCollecting do
			task.wait(1)
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and v.Name == "Bond" then
					char:PivotTo(v.CFrame + Vector3.new(0, 3, 0))
					task.wait(0.5)
				end
			end
		end
	end)
end)

-- 아이템 생성 버튼
local spawnItem = Instance.new("TextButton", contentFrame)
spawnItem.Size = UDim2.new(0, 200, 0, 40)
spawnItem.Position = UDim2.new(0, 20, 0, 80)
spawnItem.Text = "아이템 생성"
spawnItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
spawnItem.TextColor3 = Color3.fromRGB(255, 255, 255)

spawnItem.MouseButton1Click:Connect(function()
	local items = {"Bandage", "Bullet", "Plant", "Newspaper", "Paint", "Cigarette"}
	for _, itemName in ipairs(items) do
		local args = {[1] = "SpawnItem", [2] = itemName}
		game:GetService("ReplicatedStorage"):FindFirstChildWhichIsA("RemoteFunction", true):InvokeServer(unpack(args))
	end
end)

-- 채권 소환 버튼
local summonBond = Instance.new("TextButton", contentFrame)
summonBond.Size = UDim2.new(0, 200, 0, 40)
summonBond.Position = UDim2.new(0, 20, 0, 140)
summonBond.Text = "채권 소환"
summonBond.BackgroundColor3 = Color3.fromRGB(80, 60, 60)
summonBond.TextColor3 = Color3.fromRGB(255, 255, 255)

summonBond.MouseButton1Click:Connect(function()
	local args = {[1] = "SpawnItem", [2] = "Bond"}
	game:GetService("ReplicatedStorage"):FindFirstChildWhichIsA("RemoteFunction", true):InvokeServer(unpack(args))
end)

-- 메뉴 토글
local isMinimized = false
minimize.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	for _, obj in ipairs(contentFrame:GetChildren()) do
		if obj:IsA("GuiObject") then
			obj.Visible = not isMinimized
		end
	end
end)
