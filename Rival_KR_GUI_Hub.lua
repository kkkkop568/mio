-- 라이벌 핵 허브 (모바일 최적화, 고스트 허브 스타일)
-- 제작: ChatGPT

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 260, 0, 300)
Frame.Position = UDim2.new(0.7, 0, 0.2, 0)
Frame.BackgroundTransparency = 0.3
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 6)

-- 버튼 생성 함수
local function 버튼생성(텍스트, 실행함수)
	local 버튼 = Instance.new("TextButton", Frame)
	버튼.Size = UDim2.new(1, -12, 0, 35)
	버튼.Text = 텍스트
	버튼.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	버튼.TextColor3 = Color3.fromRGB(255, 255, 255)
	버튼.Font = Enum.Font.GothamBold
	버튼.TextSize = 14
	버튼.AutoButtonColor = true
	Instance.new("UICorner", 버튼).CornerRadius = UDim.new(0, 8)
	버튼.MouseButton1Click:Connect(실행함수)
end

-- ESP
버튼생성("ESP (적 위치 표시)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/zaptosis/ESP/main/ESP.lua"))()
end)

-- 에임봇
버튼생성("에임봇 (적 자동 조준)", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/4HqXaG8b"))()
end)

-- 빠른 이동
버튼생성("빠른 이동 (이동 속도 + 점프력)", function()
	local 플레이어 = game.Players.LocalPlayer
	local 캐릭터 = 플레이어.Character or 플레이어.CharacterAdded:Wait()
	캐릭터.Humanoid.WalkSpeed = 50
	캐릭터.Humanoid.JumpPower = 100
end)

-- 노 리코일
버튼생성("노 리코일 (총기 반동 제거)", function()
	for _, v in pairs(getgc(true)) do
		if typeof(v) == "table" and rawget(v, "Recoil") then
			v.Recoil = 0
		end
	end
end)

-- 닫기 버튼
local 닫기 = Instance.new("TextButton", Frame)
닫기.Text = "X"
닫기.Size = UDim2.new(0, 30, 0, 30)
닫기.Position = UDim2.new(1, -35, 0, 5)
닫기.BackgroundColor3 = Color3.fromRGB(100, 20, 20)
닫기.TextColor3 = Color3.new(1, 1, 1)
닫기.Parent = Frame
닫기.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)
