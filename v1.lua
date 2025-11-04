-- Spiffy v1 Full Script (Fixed ESP & NoClip)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpiffyGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 750)
MainFrame.Position = UDim2.new(0.5, -225, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0,15)
UICorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Spiffy v1"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 26
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0,35,0,35)
CloseButton.Position = UDim2.new(1,-45,0,5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Text = "X"
CloseButton.Parent = MainFrame
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1,0)
CloseCorner.Parent = CloseButton
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Tab Bar
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1,0,0,40)
TabBar.Position = UDim2.new(0,0,0,45)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local function createTabButton(name,pos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,160,0,35)
	btn.Position = pos
	btn.BackgroundColor3 = Color3.fromRGB(255,140,0)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 18
	btn.Text = name
	btn.Parent = TabBar
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,10)
	corner.Parent = btn
	return btn
end

local VisualsTabButton = createTabButton("Visuals", UDim2.new(0,40,0,0))
local MainTabButton = createTabButton("Main", UDim2.new(0,220,0,0))

-- Frames
local VisualsFrame = Instance.new("Frame")
VisualsFrame.Size = UDim2.new(1,0,1,-90)
VisualsFrame.Position = UDim2.new(0,0,0,90)
VisualsFrame.BackgroundTransparency = 1
VisualsFrame.Parent = MainFrame

local MainFrameTab = Instance.new("Frame")
MainFrameTab.Size = UDim2.new(1,0,1,-90)
MainFrameTab.Position = UDim2.new(0,0,0,90)
MainFrameTab.BackgroundTransparency = 1
MainFrameTab.Visible = false
MainFrameTab.Parent = MainFrame

-- Switch Tabs
local function switchTab(tab)
	VisualsTabButton.BackgroundColor3 = Color3.fromRGB(255,140,0)
	MainTabButton.BackgroundColor3 = Color3.fromRGB(255,140,0)
	VisualsFrame.Visible = false
	MainFrameTab.Visible = false
	if tab=="Visuals" then
		VisualsTabButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
		VisualsFrame.Visible = true
	elseif tab=="Main" then
		MainTabButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
		MainFrameTab.Visible = true
	end
end
VisualsTabButton.MouseButton1Click:Connect(function() switchTab("Visuals") end)
MainTabButton.MouseButton1Click:Connect(function() switchTab("Main") end)
switchTab("Visuals")

-- Helper for creating buttons
local function createButton(parent,text,y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,240,0,45)
	btn.Position = UDim2.new(0.5,-120,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(255,140,0)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 20
	btn.Text = text
	btn.Parent = parent
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,10)
	corner.Parent = btn
	return btn
end

-- Visuals Buttons
local MurderButton = createButton(VisualsFrame,"Murderer ESP: OFF",20)
local SheriffButton = createButton(VisualsFrame,"Sheriff ESP: OFF",90)
local InnocentButton = createButton(VisualsFrame,"Innocent ESP: OFF",160)

-- Main tab info (optional, can leave blank since ESP above heads)
-- Main tab buttons
local NoclipButton = createButton(MainFrameTab,"NoClip: OFF",120)
local WalkButton = createButton(MainFrameTab,"WalkSpeed",180)
local JumpButton = createButton(MainFrameTab,"JumpPower",240)
local TPButton = createButton(MainFrameTab,"Teleport Player",300)
local GrabGunButton = createButton(MainFrameTab,"Grab Gun",360)
local AutoFarmButton = createButton(MainFrameTab,"Auto Farm",420)
local InvincibleButton = createButton(MainFrameTab,"Invincibility: OFF",480)

-- Variables
local noclipEnabled=false
local originalCanCollide = {}
local walkToggled=false
local jumpToggled=false
local autoFarmEnabled=false
local invincibleEnabled=false
local MurderESP=false
local SheriffESP=false
local InnocentESP=false
local defaultSpeed=16
local defaultJump=50

-- Check if player has tool
local function hasTool(player,toolName)
	local tname=string.lower(toolName)
	local backpack=player:FindFirstChild("Backpack")
	if backpack then
		for _,item in ipairs(backpack:GetChildren()) do
			if string.lower(item.Name)==tname then return true end
		end
	end
	local char=player.Character
	if char then
		for _,item in ipairs(char:GetChildren()) do
			if item:IsA("Tool") and string.lower(item.Name)==tname then return true end
		end
	end
	return false
end

-- Create ESP text above head
local function updateESPText(player, role)
	local char = player.Character
	if char and char:FindFirstChild("Head") then
		local head = char.Head
		local billboard = head:FindFirstChild("SpiffyESP") or Instance.new("BillboardGui")
		billboard.Name = "SpiffyESP"
		billboard.Size = UDim2.new(0,200,0,50)
		billboard.Adornee = head
		billboard.AlwaysOnTop = true
		billboard.Parent = head

		local label = billboard:FindFirstChild("TextLabel") or Instance.new("TextLabel")
		label.Name = "TextLabel"
		label.Size = UDim2.new(1,0,1,0)
		label.BackgroundTransparency = 1
		label.TextSize = 18
		label.Font = Enum.Font.GothamBold
		label.TextColor3 = role=="Murderer" and Color3.fromRGB(255,0,0) or role=="Sheriff" and Color3.fromRGB(0,0,255) or Color3.fromRGB(0,255,0)
		label.Text = player.Name
		label.Parent = billboard
	end
end

-- Update Loop
RunService.RenderStepped:Connect(function()
	-- NoClip
	if noclipEnabled and LocalPlayer.Character then
		for _,p in ipairs(LocalPlayer.Character:GetChildren()) do
			if p:IsA("BasePart") then
				if originalCanCollide[p]==nil then originalCanCollide[p]=p.CanCollide end
				p.CanCollide=false
			end
		end
	elseif not noclipEnabled and LocalPlayer.Character then
		for part,canCollide in pairs(originalCanCollide) do
			if part and part.Parent then
				part.CanCollide = canCollide
			end
		end
		originalCanCollide = {}
	end

	-- Invincibility
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if invincibleEnabled and hum then
		hum.Health = hum.MaxHealth
	end

	-- Update ESP for all players
	for _,p in ipairs(Players:GetPlayers()) do
		local knife = hasTool(p,"Knife")
		local gun = hasTool(p,"Gun")
		if knife then
			updateESPText(p,"Murderer")
			if MurderESP then
				-- optional Highlight code here
			end
		elseif gun then
			updateESPText(p,"Sheriff")
			if SheriffESP then
				-- optional Highlight code here
			end
		else
			updateESPText(p,"Innocent")
			if InnocentESP then
				-- optional Highlight code here
			end
		end
	end
end)

-- Button Functions

-- NoClip
NoclipButton.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	NoclipButton.Text = noclipEnabled and "NoClip: ON" or "NoClip: OFF"
	NoclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,140,0)
end)

-- WalkSpeed
WalkButton.MouseButton1Click:Connect(function()
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
	if hum then
		walkToggled = not walkToggled
		hum.WalkSpeed = walkToggled and 30 or defaultSpeed
		WalkButton.BackgroundColor3 = walkToggled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,140,0)
	end
end)

-- JumpPower
JumpButton.MouseButton1Click:Connect(function()
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
	if hum then
		jumpToggled = not jumpToggled
		hum.JumpPower = jumpToggled and 70 or defaultJump
		JumpButton.BackgroundColor3 = jumpToggled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,140,0)
	end
end)

-- Invincibility
InvincibleButton.MouseButton1Click:Connect(function()
	invincibleEnabled = not invincibleEnabled
	InvincibleButton.Text = invincibleEnabled and "Invincibility: ON" or "Invincibility: OFF"
	InvincibleButton.BackgroundColor3 = invincibleEnabled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,140,0)
end)

-- ESP Toggles
MurderButton.MouseButton1Click:Connect(function()
	MurderESP = not MurderESP
	MurderButton.Text = MurderESP and "Murderer ESP: ON" or "Murderer ESP: OFF"
	MurderButton.BackgroundColor3 = MurderESP and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,140,0)
end)

SheriffButton.MouseButton1Click:Connect(function()
	SheriffESP = not SheriffESP
	SheriffButton.Text = SheriffESP and "Sheriff ESP: ON" or "Sheriff ESP: OFF"
	SheriffButton.BackgroundColor3 = SheriffESP and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,140,0)
end)

InnocentButton.MouseButton1Click:Connect(function()
	InnocentESP = not InnocentESP
	InnocentButton.Text = InnocentESP and "Innocent ESP: ON" or "Innocent ESP: OFF"
	InnocentButton.BackgroundColor3 = InnocentESP and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,140,0)
end)

-- Auto Farm
AutoFarmButton.MouseButton1Click:Connect(function()
	autoFarmEnabled = not autoFarmEnabled
	AutoFarmButton.BackgroundColor3 = autoFarmEnabled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,140,0)
	AutoFarmButton.Text = autoFarmEnabled and "Auto Farm: ON" or "Auto Farm: OFF"

	spawn(function()
		while autoFarmEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do
			local hrp = LocalPlayer.Character.HumanoidRootPart
			for _,part in ipairs(workspace:GetDescendants()) do
				if not autoFarmEnabled then break end
				if part.Name=="Coin_Server" and part:FindFirstChild("CoinVisual") and part:FindFirstChild("TouchInterest") then
					hrp.CFrame = part.CFrame + Vector3.new(0,3,0)
					wait(2.8)
				end
			end
			wait(0.1)
		end
	end)
end)

-- Teleport Player GUI
TPButton.MouseButton1Click:Connect(function()
	local TPGui = Instance.new("Frame")
	TPGui.Size = UDim2.new(0,250,0,400)
	TPGui.Position = UDim2.new(0.5,-125,0.5,-200)
	TPGui.BackgroundColor3 = Color3.fromRGB(0,0,0)
	TPGui.Parent = ScreenGui
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,15)
	corner.Parent = TPGui

	local close = Instance.new("TextButton")
	close.Size = UDim2.new(0,35,0,35)
	close.Position = UDim2.new(1,-40,0,5)
	close.BackgroundColor3 = Color3.fromRGB(255,50,50)
	close.Text = "X"
	close.TextColor3 = Color3.fromRGB(255,255,255)
	close.Font = Enum.Font.GothamBold
	close.TextSize = 18
	close.Parent = TPGui
	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(1,0)
	closeCorner.Parent = close
	close.MouseButton1Click:Connect(function()
		TPGui:Destroy()
	end)

	local y = 50
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(0,200,0,35)
			btn.Position = UDim2.new(0.5,-100,0,y)
			btn.BackgroundColor3 = Color3.fromRGB(255,140,0)
			btn.TextColor3 = Color3.fromRGB(255,255,255)
			btn.Text = p.Name
			btn.Font = Enum.Font.GothamBold
			btn.TextSize = 18
			btn.Parent = TPGui
			local c = Instance.new("UICorner")
			c.CornerRadius = UDim.new(0,8)
			c.Parent = btn

			btn.MouseButton1Click:Connect(function()
				local char = LocalPlayer.Character
				local target = p.Character
				if char and target and target:FindFirstChild("HumanoidRootPart") then
					char:WaitForChild("HumanoidRootPart").CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
				end
			end)
			y = y + 50
		end
	end
end)

-- Grab Gun
GrabGunButton.MouseButton1Click:Connect(function()
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local char = p.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				local hasGun = false
				local backpack = p:FindFirstChild("Backpack")
				if backpack then
					for _,item in ipairs(backpack:GetChildren()) do
						if item.Name:lower()=="gun" then hasGun=true break end
					end
				end
				for _,tool in ipairs(char:GetChildren()) do
					if tool:IsA("Tool") and tool.Name:lower()=="gun" then hasGun=true break end
				end
				if hasGun then
					local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
					end
					break
				end
			end
		end
	end
end)
