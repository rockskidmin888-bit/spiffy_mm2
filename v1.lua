-- Spiffy v1 Ultimate Working Script
-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "SpiffyGUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0,450,0,650)
MainFrame.Position = UDim2.new(0.5,-225,0.4,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,15)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,30)
Title.Position = UDim2.new(0,0,0,0)
Title.Text = "Spiffy v1"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.BackgroundTransparency = 1

local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Size = UDim2.new(0,30,0,30)
CloseButton.Position = UDim2.new(1,-35,0,0)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(1,0)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Tab System
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1,0,0,30)
TabBar.Position = UDim2.new(0,0,0,35)
TabBar.BackgroundTransparency = 1

local function createTabButton(name,pos)
	local btn = Instance.new("TextButton", TabBar)
	btn.Size = UDim2.new(0,200,0,25)
	btn.Position = pos
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(255,140,0)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
	return btn
end

local VisualsTabButton = createTabButton("Visuals", UDim2.new(0,20,0,0))
local MainTabButton = createTabButton("Main", UDim2.new(0,230,0,0))

local VisualsFrame = Instance.new("Frame", MainFrame)
VisualsFrame.Size = UDim2.new(1,0,1,-70)
VisualsFrame.Position = UDim2.new(0,0,0,70)
VisualsFrame.BackgroundTransparency = 1

local MainFrameTab = Instance.new("Frame", MainFrame)
MainFrameTab.Size = UDim2.new(1,0,1,-70)
MainFrameTab.Position = UDim2.new(0,0,0,70)
MainFrameTab.BackgroundTransparency = 1
MainFrameTab.Visible = false

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

-- Button Helper
local function createButton(parent,text,y)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0,200,0,35)
	btn.Position = UDim2.new(0.5,-100,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(255,140,0)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Text = text
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
	return btn
end

-- Visuals Buttons
local MurderHighlightBtn = createButton(VisualsFrame,"Murderer Highlight",20)
local SheriffHighlightBtn = createButton(VisualsFrame,"Sheriff Highlight",70)
local InnocentHighlightBtn = createButton(VisualsFrame,"Innocent Highlight",120)
local MurderNameBtn = createButton(VisualsFrame,"Murderer Name ESP",170)
local SheriffNameBtn = createButton(VisualsFrame,"Sheriff Name ESP",220)
local InnocentNameBtn = createButton(VisualsFrame,"Innocent Name ESP",270)
local DistanceESPBtn = createButton(VisualsFrame,"Distance ESP",320)
local BoxESPBtn = createButton(VisualsFrame,"Box ESP",370)
local TracerESPBtn = createButton(VisualsFrame,"Tracers",420)
local SkeletonESPBtn = createButton(VisualsFrame,"Skeleton ESP",470)

-- Main Buttons
local NoclipButton = createButton(MainFrameTab,"NoClip: OFF",50)
local FlyButton = createButton(MainFrameTab,"Fly: OFF",100)
local WalkButton = createButton(MainFrameTab,"WalkSpeed: OFF",150)
local JumpButton = createButton(MainFrameTab,"JumpPower: OFF",200)
local TPButton = createButton(MainFrameTab,"Teleport Player",250)
local AutoFarmButton = createButton(MainFrameTab,"Auto Farm: OFF",300)
local InvincibleButton = createButton(MainFrameTab,"Invincibility: OFF",350)
local HitboxButton = createButton(MainFrameTab,"Hitbox Expander: OFF",400)

-- Role Labels
local MurderText = Instance.new("TextLabel", MainFrameTab)
MurderText.Size = UDim2.new(0,430,0,25)
MurderText.Position = UDim2.new(0,10,0,10)
MurderText.BackgroundTransparency = 1
MurderText.TextColor3 = Color3.fromRGB(255,0,0)
MurderText.Font = Enum.Font.GothamBold
MurderText.TextSize = 16
MurderText.Text = "Murderer:"

local SheriffText = Instance.new("TextLabel", MainFrameTab)
SheriffText.Size = UDim2.new(0,430,0,25)
SheriffText.Position = UDim2.new(0,10,0,35)
SheriffText.BackgroundTransparency = 1
SheriffText.TextColor3 = Color3.fromRGB(0,0,255)
SheriffText.Font = Enum.Font.GothamBold
SheriffText.TextSize = 16
SheriffText.Text = "Sheriff:"

-- Variables
local noclipEnabled=false
local flyEnabled=false
local walkEnabled=false
local jumpEnabled=false
local autoFarmEnabled=false
local invincibleEnabled=false
local hitboxEnabled=false
local skeletonEnabled=false
local flySpeed = 50
local velocity = Vector3.new(0,0,0)
local originalSizes={}
local ESPSettings = {
	Murderer={Highlight=false,Name=false,Distance=false,Box=false,Tracer=false,Skeleton=false,Color=Color3.fromRGB(255,0,0)},
	Sheriff={Highlight=false,Name=false,Distance=false,Box=false,Tracer=false,Skeleton=false,Color=Color3.fromRGB(0,0,255)},
	Innocent={Highlight=false,Name=false,Distance=false,Box=false,Tracer=false,Skeleton=false,Color=Color3.fromRGB(0,255,0)}
}

-- Function to get role
local function getRole(player)
	if player.Character then
		for _, tool in ipairs(player.Character:GetChildren()) do
			if tool:IsA("Tool") then
				if tool.Name:lower():find("knife") then return "Murderer" end
				if tool.Name:lower():find("gun") then return "Sheriff" end
			end
		end
	end
	return "Innocent"
end

-- Update Role Labels
RunService.RenderStepped:Connect(function()
	local murderers, sheriffs = {}, {}
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local role = getRole(p)
			if role=="Murderer" then table.insert(murderers,p.Name)
			elseif role=="Sheriff" then table.insert(sheriffs,p.Name) end
		end
	end
	MurderText.Text = "Murderer: "..table.concat(murderers,", ")
	SheriffText.Text = "Sheriff: "..table.concat(sheriffs,", ")
end)

-- WalkSpeed Button
WalkButton.MouseButton1Click:Connect(function()
	walkEnabled = not walkEnabled
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = walkEnabled and 30 or 16 end
	WalkButton.Text = "WalkSpeed: "..(walkEnabled and "ON" or "OFF")
end)

-- JumpPower Button
JumpButton.MouseButton1Click:Connect(function()
	jumpEnabled = not jumpEnabled
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then hum.JumpPower = jumpEnabled and 70 or 50 end
	JumpButton.Text = "JumpPower: "..(jumpEnabled and "ON" or "OFF")
end)

-- Noclip Button
NoclipButton.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	NoclipButton.Text = "NoClip: "..(noclipEnabled and "ON" or "OFF")
end)
RunService.Stepped:Connect(function()
	if noclipEnabled and LocalPlayer.Character then
		for _,part in ipairs(LocalPlayer.Character:GetChildren()) do
			if part:IsA("BasePart") then part.CanCollide=false end
		end
	end
end)

-- Fly Button
FlyButton.MouseButton1Click:Connect(function()
	flyEnabled = not flyEnabled
	FlyButton.Text = "Fly: "..(flyEnabled and "ON" or "OFF")
end)

-- Teleport Player Button
TPButton.MouseButton1Click:Connect(function()
	local tpGui = Instance.new("ScreenGui", CoreGui)
	tpGui.Name = "TPGui"
	local frame = Instance.new("Frame", tpGui)
	frame.Size = UDim2.new(0,200,0,300)
	frame.Position = UDim2.new(0.5,-100,0.5,-150)
	frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
	for i,p in ipairs(Players:GetPlayers()) do
		if p~=LocalPlayer then
			local btn = Instance.new("TextButton", frame)
			btn.Size = UDim2.new(0,180,0,30)
			btn.Position = UDim2.new(0,10,0,(i-1)*35 + 10)
			btn.Text = p.Name
			btn.BackgroundColor3 = Color3.fromRGB(255,140,0)
			btn.TextColor3 = Color3.fromRGB(255,255,255)
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0,5)
			btn.MouseButton1Click:Connect(function()
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
				end
				tpGui:Destroy()
			end)
		end
	end
end)

-- AutoFarm
local autoFarmConnection
AutoFarmButton.MouseButton1Click:Connect(function()
	autoFarmEnabled = not autoFarmEnabled
	AutoFarmButton.Text = "Auto Farm: "..(autoFarmEnabled and "ON" or "OFF")
	if autoFarmEnabled then
		autoFarmConnection = RunService.Heartbeat:Connect(function()
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				for _,part in ipairs(Workspace:GetDescendants()) do
					if part:IsA("Part") and part.Name=="Coin_Server" and part:FindFirstChild("CoinVisual") and part:FindFirstChildOfClass("TouchTransmitter") then
						LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0,3,0)
						wait(2.8)
						break
					end
				end
			end
		end)
	else
		if autoFarmConnection then autoFarmConnection:Disconnect() end
	end
end)

-- Invincibility (simple)
InvincibleButton.MouseButton1Click:Connect(function()
	invincibleEnabled = not invincibleEnabled
	InvincibleButton.Text = "Invincibility: "..(invincibleEnabled and "ON" or "OFF")
	if invincibleEnabled then
		LocalPlayer.CharacterAdded:Connect(function(char)
			for _,v in ipairs(char:GetDescendants()) do
				if v:IsA("Humanoid") then v.HealthChanged:Connect(function()
					v.Health = v.MaxHealth
				end) end
			end
		end)
	end
end)

-- Hitbox Expander
HitboxButton.MouseButton1Click:Connect(function()
	hitboxEnabled = not hitboxEnabled
	for _,p in ipairs(Players:GetPlayers()) do
		if p~=LocalPlayer and p.Character then
			local hum = p.Character:FindFirstChildOfClass("Humanoid")
			if hum then hum.HipHeight = hitboxEnabled and 5 or 2
		end
	end
	HitboxButton.Text = "Hitbox Expander: "..(hitboxEnabled and "ON" or "OFF")
end)
