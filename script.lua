local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local DISCORD_LINK = "https://discord.gg/QaAa3qBdSX"

-- MENU TOGGLE KEY
local menuToggleKey = Enum.KeyCode.LeftControl
local waitingForKeybind = false

-- SETTINGS
local flySpeed = 70
local walkSpeed = 16
local flying = false
local noclip = false
local espEnabled = false

local BV
local BG

local keys = {W=false,A=false,S=false,D=false,Space=false,Ctrl=false}

-- COLORS
local bg = Color3.fromRGB(25,25,25)
local accent = Color3.fromRGB(0,0,0)
local buttonColor = Color3.fromRGB(40,40,55)
local buttonHover = Color3.fromRGB(65,65,95)

-- TEXT OUTLINE FUNCTION
local function outlineText(obj)
	obj.TextStrokeTransparency = 0
	obj.TextStrokeColor3 = Color3.new(0,0,0)
end

-- BUTTON CREATOR
local function makeButton(text,x,y,parent)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,180,0,35)
	b.Position = UDim2.new(0,x,0,y)
	b.Text = text
	b.BackgroundColor3 = buttonColor
	b.TextColor3 = Color3.new(1,1,1)

	-- TEXT OUTLINE
	b.TextStrokeTransparency = 0
	b.TextStrokeColor3 = Color3.new(0,0,0)

	b.Parent = parent

	-- ROUNDED EDGES
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,8) -- smooth roundness
	corner.Parent = b

b.MouseEnter:Connect(function()
	TweenService:Create(b,TweenInfo.new(0.15),{
		BackgroundColor3 = buttonHover
	}):Play()
end)

b.MouseLeave:Connect(function()
	TweenService:Create(b,TweenInfo.new(0.15),{
		BackgroundColor3 = buttonColor
	}):Play()
end)

	return b
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BLACK FLAG"
gui.Parent = game.CoreGui

-- BLUR BACKGROUND
if game.Lighting:FindFirstChildOfClass("BlurEffect") then
	game.Lighting:FindFirstChildOfClass("BlurEffect"):Destroy()
end

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game.Lighting

local main = Instance.new("Frame")
main.Size = UDim2.new(0,440,0,340)
main.Position = UDim2.new(0.5,-220,0.5,-170)
main.BackgroundColor3 = bg
main.Active = true
main.Draggable = true
main.Parent = gui

local TweenService = game:GetService("TweenService")

-- KEY SYSTEM
local MENU_KEY = "1234"

-- hide main hub initially
main.Position = UDim2.new(-1,-440,0.5,-170)

-- KEY PANEL
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0,320,0,220)
keyFrame.Position = UDim2.new(0.5,-160,0.5,-110)
keyFrame.BackgroundColor3 = bg
keyFrame.Parent = gui

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1,0,0,40)
keyTitle.Text = "BLACK FLAG Key System"
keyTitle.TextScaled = true
keyTitle.BackgroundTransparency = 1
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.Parent = keyFrame
outlineText(keyTitle)

-- RAINBOW ANIMATION FOR TITLE
RunService.RenderStepped:Connect(function()
	local hue = (tick() % 5) / 5
	local rainbow = Color3.fromHSV(hue,1,1)

	if keyTitle then
		keyTitle.TextColor3 = rainbow
	end
end)

local keyInfo = Instance.new("TextLabel")
keyInfo.Size = UDim2.new(1,-20,0,30)
keyInfo.Position = UDim2.new(0,10,0,35)
keyInfo.Text = "Get the key from our Discord server"
keyInfo.TextScaled = true
keyInfo.BackgroundTransparency = 1
keyInfo.TextColor3 = Color3.fromRGB(200,200,200)
keyInfo.Parent = keyFrame
outlineText(keyInfo)

-- DISCORD BUTTON
local discordButton = Instance.new("TextButton")
discordButton.Size = UDim2.new(0,200,0,35)
discordButton.Position = UDim2.new(0.5,-100,0,70)
discordButton.Text = "  Copy Discord Invite"
discordButton.BackgroundColor3 = accent
discordButton.TextColor3 = Color3.new(1,1,1)
discordButton.TextScaled = true
discordButton.Parent = keyFrame
outlineText(discordButton)

local discordIcon = Instance.new("ImageLabel")
discordIcon.Size = UDim2.new(0,22,0,22)
discordIcon.Position = UDim2.new(0,6,0.5,-11)
discordIcon.BackgroundTransparency = 1
discordIcon.Parent = discordButton

discordButton.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(DISCORD_LINK)
	end
end)

-- KEY INPUT BOX
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8,0,0,35)
keyBox.Position = UDim2.new(0.1,0,0,115)
keyBox.PlaceholderText = "Enter Key..."
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.BackgroundColor3 = buttonColor
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.Parent = keyFrame
outlineText(keyBox)

-- SUBMIT BUTTON
local submit = Instance.new("TextButton")
submit.Size = UDim2.new(0.6,0,0,35)
submit.Position = UDim2.new(0.2,0,0,160)
submit.Text = "Submit"
submit.TextScaled = true
submit.BackgroundColor3 = accent
submit.TextColor3 = Color3.new(1,1,1)
submit.Parent = keyFrame
outlineText(submit)

-- STATUS TEXT
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0,20)
status.Position = UDim2.new(0,0,1,-20)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(255,80,80)
status.TextScaled = true
status.Text = ""
status.Parent = keyFrame
outlineText(status)

-- KEY CHECK
submit.MouseButton1Click:Connect(function()
	if keyBox.Text == MENU_KEY then
		for _,v in pairs(keyFrame:GetChildren()) do
			if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
				TweenService:Create(v,TweenInfo.new(0.35),{
					TextTransparency = 1,
					BackgroundTransparency = 1
				}):Play()
			end
		end

		TweenService:Create(keyFrame,TweenInfo.new(0.35),{
			BackgroundTransparency = 1
		}):Play()

		task.wait(0.35)
		keyFrame:Destroy()

		local openTween = TweenService:Create(
			main,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Position = UDim2.new(0.5,-220,0.5,-170)}
		)

		openTween:Play()
		TweenService:Create(blur, TweenInfo.new(0.3), {Size = 14}):Play()
	else
		status.Text = "Invalid Key"
	end
end)

-- TOP BAR
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,35)
topBar.BackgroundColor3 = accent
topBar.Parent = main
local topbarCorner = Instance.new("UICorner")
topbarCorner.CornerRadius = UDim.new(0,12)
topbarCorner.Parent = topBar

-- TITLE CONTAINER
local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.new(0,200,1,0)
titleContainer.Position = UDim2.new(0,10,0,0)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = topBar
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0,12)
titleCorner.Parent = titleContainer

-- BLACK TEXT
local blackText = Instance.new("TextLabel")
blackText.Size = UDim2.new(0,80,0.8,0)
blackText.Position = UDim2.new(0,0,0.1,0)
blackText.Text = "BLACK"
blackText.TextScaled = true
blackText.TextColor3 = Color3.new(0,0,0)
blackText.BackgroundColor3 = Color3.new(1,1,1)
blackText.BorderSizePixel = 0
blackText.Parent = titleContainer
local blackCorner = Instance.new("UICorner")
blackCorner.CornerRadius = UDim.new(0,7)
blackCorner.Parent = blackText


-- FLAG TEXT
local flagText = Instance.new("TextLabel")
flagText.Size = UDim2.new(0,70,0.8,0)
flagText.Position = UDim2.new(0,85,0.1,0)
flagText.Text = "FLAG"
flagText.TextScaled = true
flagText.TextColor3 = Color3.new(1,1,1)
flagText.BackgroundColor3 = Color3.new(0,0,0)
flagText.BorderSizePixel = 0
flagText.Parent = titleContainer

local close = Instance.new("TextButton")
close.Size = UDim2.new(0,35,1,0)
close.Position = UDim2.new(1,-35,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(1000,1000,1000)
close.TextColor3 = Color3.new(1,1,1)
close.Parent = topBar
outlineText(close)
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0,12)
closeCorner.Parent = close


close.MouseButton1Click:Connect(function()

	-- remove blur effect completely
	if blur and blur.Parent then
		blur:Destroy()
	end

	gui:Destroy()
end)

-- TAB BAR
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1,0,0,30)
tabBar.Position = UDim2.new(0,0,0,35)
tabBar.BackgroundColor3 = Color3.fromRGB(20,20,30)
tabBar.Parent = main
local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0,12)
tabCorner.Parent = tabBar

local function createTabButton(name,pos)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.2,0,1,0)
	b.Position = pos
	b.Text = name
	b.BackgroundColor3 = buttonColor
	b.TextColor3 = Color3.new(1,1,1)
	b.Parent = tabBar
	outlineText(b)

	b.MouseEnter:Connect(function()
		b.BackgroundColor3 = buttonHover
	end)

	b.MouseLeave:Connect(function()
		b.BackgroundColor3 = buttonColor
	end)

	return b
end

-- Create Tab Buttons
local mainTabButton = createTabButton("Main", UDim2.new(0, 0, 0, 0))
local playerTabButton = createTabButton("Player", UDim2.new(0.2, 0, 0, 0))
local viewTabButton = createTabButton("View", UDim2.new(0.4, 0, 0, 0))
local serverTabButton = createTabButton("Server", UDim2.new(0.6, 0, 0, 0))
local settingsTabButton = createTabButton("Settings", UDim2.new(0.8, 0, 0, 0))

-- Debug: Print buttons to check if they are created
print(mainTabButton, playerTabButton, viewTabButton, serverTabButton, settingsTabButton)

-- CONTAINER
local container = Instance.new("Frame")
container.Size = UDim2.new(1,0,1,-65)
container.Position = UDim2.new(0,0,0,65)
container.BackgroundTransparency = 1
container.Parent = main
local cCorner = Instance.new("UICorner")
cCorner.CornerRadius = UDim.new(0,12)
cCorner.Parent = container

-- MAIN TAB
local mainTab = Instance.new("Frame")
mainTab.Size = UDim2.new(1,0,1,0)
mainTab.BackgroundTransparency = 1
mainTab.Parent = container
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0,0,0)
stroke.Thickness = 4
stroke.Parent = main
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0,12)
mainCorner.Parent = main

local owner = Instance.new("TextLabel")
owner.Size = UDim2.new(1,0,0,35)
owner.Position = UDim2.new(0,0,0,20)
owner.Text = "Owner: ssxge"
owner.TextScaled = true
owner.BackgroundTransparency = 1
owner.Parent = mainTab
outlineText(owner)

local support = Instance.new("TextLabel")
support.Size = UDim2.new(1,0,0,25)
support.Position = UDim2.new(0,0,0,60)
support.Text = "Staff: Junior"
support.TextScaled = true
support.BackgroundTransparency = 1
support.TextColor3 = Color3.fromRGB(170,0,255)
support.Parent = mainTab
outlineText(support)

local discordInfo = Instance.new("TextLabel")
discordInfo.Size = UDim2.new(1,0,0,25)
discordInfo.Position = UDim2.new(0,0,0,95)
discordInfo.Text = "Press button to copy Discord invite"
discordInfo.BackgroundTransparency = 1
discordInfo.TextColor3 = Color3.fromRGB(200,200,200)
discordInfo.Parent = mainTab
discordInfo.TextScaled = true
outlineText(discordInfo)

local discordButton = Instance.new("TextButton")
discordButton.Size = UDim2.new(0,220,0,40)
discordButton.Position = UDim2.new(0.5,-110,0,130)
discordButton.Text = "  Copy Discord Invite"
discordButton.BackgroundColor3 = accent
discordButton.TextColor3 = Color3.new(1,133,1)
discordButton.Parent = mainTab
outlineText(discordButton)

-- DISCORD ICON
local discordIcon = Instance.new("ImageLabel")
discordIcon.Size = UDim2.new(0,24,0,24)
discordIcon.Position = UDim2.new(0,8,0.5,-12)
discordIcon.BackgroundTransparency = 1
discordIcon.Image = "rbxassetid://6031075938"
discordIcon.Parent = discordButton

discordButton.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(DISCORD_LINK)
	end
end)

-- PLAYER TAB
local playerTab = Instance.new("ScrollingFrame")
playerTab.Size = UDim2.new(1,0,1,0)
playerTab.Visible = false
playerTab.Active = true
playerTab.CanvasSize = UDim2.new(0,0,0,0)
playerTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
playerTab.ScrollBarThickness = 6
playerTab.BackgroundTransparency = 1
playerTab.Parent = container
playerTab.ScrollingEnabled = true
playerTab.ScrollBarImageTransparency = 0

-- VIEW TAB
local viewTab = Instance.new("ScrollingFrame")
viewTab.Size = UDim2.new(1,0,1,0)
viewTab.Visible = false
viewTab.Active = true
viewTab.CanvasSize = UDim2.new(0,0,0,0)
viewTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
viewTab.ScrollBarThickness = 6
viewTab.BackgroundTransparency = 1
viewTab.Parent = container
viewTab.ScrollingEnabled = true
viewTab.ScrollBarImageTransparency = 0

-- SERVER TAB
local serverTab = Instance.new("ScrollingFrame")
serverTab.Size = UDim2.new(1,0,1,0)
serverTab.Visible = false
serverTab.Active = true
serverTab.BackgroundTransparency = 1
serverTab.CanvasSize = UDim2.new(0,0,0,0)
serverTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
serverTab.ScrollBarThickness = 6
serverTab.Parent = container
serverTab.ScrollingEnabled = true
serverTab.ScrollBarImageTransparency = 0

-- SETTINGS TAB
local settingsTab = Instance.new("ScrollingFrame")
settingsTab.Size = UDim2.new(1,0,1,0)
settingsTab.Visible = false
settingsTab.Active = true
settingsTab.CanvasSize = UDim2.new(0,0,0,0)
settingsTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
settingsTab.ScrollBarThickness = 6
settingsTab.BackgroundTransparency = 1
settingsTab.Parent = container
settingsTab.ScrollingEnabled = true
settingsTab.ScrollBarImageTransparency = 0

local menuOpen = true

local function toggleMenu()
	menuOpen = not menuOpen

	if menuOpen then
	main.Visible = true
	main.Size = UDim2.new(0,0,0,0)

	TweenService:Create(main,
		TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Size = UDim2.new(0,440,0,340)}
	):Play()

	TweenService:Create(blur,TweenInfo.new(0.3),{Size = 14}):Play()

else
	local tween = TweenService:Create(main,
		TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Size = UDim2.new(0,0,0,0)}
	)

	tween:Play()
	tween.Completed:Wait()

	main.Visible = false
	TweenService:Create(blur,TweenInfo.new(0.3),{Size = 0}):Play()
end
end

-- Keybind Button
local keybindButton = makeButton("Set Open/Close Keybind", 20, 20, settingsTab)

keybindButton.MouseButton1Click:Connect(function()
	keybindButton.Text = "Press any key..."
	waitingForKeybind = true
end)

-- KEY INPUT
UIS.InputBegan:Connect(function(input, gp)
	if gp then return end

	-- KEYBIND CHANGE MODE
if waitingForKeybind then
	waitingForKeybind = false
	menuToggleKey = input.KeyCode
	keybindButton.Text = "Menu Key: " .. input.KeyCode.Name
	task.wait() -- prevents instant toggle
	return
end

	-- MENU TOGGLE
	if input.KeyCode == menuToggleKey then
		toggleMenu()
	end

	-- MOVEMENT KEYS
	if input.KeyCode == Enum.KeyCode.W then keys.W = true end
	if input.KeyCode == Enum.KeyCode.A then keys.A = true end
	if input.KeyCode == Enum.KeyCode.S then keys.S = true end
	if input.KeyCode == Enum.KeyCode.D then keys.D = true end
	if input.KeyCode == Enum.KeyCode.Space then keys.Space = true end
	if input.KeyCode == Enum.KeyCode.LeftControl then keys.Ctrl = true end
end)

local viewing = false
local viewedPlayer = nil

-- USERNAME INPUT
local flingInput = Instance.new("TextBox")
flingInput.Size = UDim2.new(0,220,0,35)
flingInput.Position = UDim2.new(0.5,-110,0,20)
flingInput.PlaceholderText = "Enter username or 'all'"
flingInput.Text = ""
flingInput.TextScaled = true
flingInput.BackgroundColor3 = buttonColor
flingInput.TextColor3 = Color3.new(1,1,1)
flingInput.Parent = serverTab
outlineText(flingInput)

-- FLING BUTTON
local flingButton = makeButton("Fling Player",20,70,serverTab)

-- TELEPORT BUTTON (right column)
local teleportButton = makeButton("Teleport To Player",240,70,serverTab)

-- VIEW PLAYER BUTTON
local viewPlayerButton = makeButton("View Player",20,120,serverTab)

-- BETTER TAB SYSTEM
local tabs = {
	Main = mainTab,
	Player = playerTab,
	View = viewTab,
	Server = serverTab,
	Settings = settingsTab
}

local function switchTab(tabName)
	for name, frame in pairs(tabs) do
		frame.Visible = (name == tabName)
	end
end

mainTabButton.MouseButton1Click:Connect(function()
	print("Switching to Main Tab") -- Debug
	switchTab("Main")
end)

playerTabButton.MouseButton1Click:Connect(function()
	print("Switching to Player Tab") -- Debug
	switchTab("Player")
end)

viewTabButton.MouseButton1Click:Connect(function()
	print("Switching to View Tab") -- Debug
	switchTab("View")
end)

serverTabButton.MouseButton1Click:Connect(function()
	print("Switching to Server Tab") -- Debug
	switchTab("Server")
end)

settingsTabButton.MouseButton1Click:Connect(function()
	print("Switching to Settings Tab") -- Debug
	switchTab("Settings")
end)

-- default tab
task.wait()
switchTab("Main")

-- PLAYER TAB LAYOUT
local col1 = 20
local col2 = 240
local y = 20

local flyButton = makeButton("Fly",col1,y,playerTab)
local noclipButton = makeButton("Noclip",col2,y,playerTab)

y = y + 40

-- FLY SPEED
local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Size = UDim2.new(0,180,0,25)
flySpeedLabel.Position = UDim2.new(0,col1,0,y)
flySpeedLabel.Text = "Fly Speed: "..flySpeed
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.TextColor3 = Color3.new(1,1,1)
flySpeedLabel.Parent = playerTab
outlineText(flySpeedLabel)

local flyMinus = makeButton("-",col1,y+25,playerTab)
flyMinus.Size = UDim2.new(0,80,0,30)

local flyPlus = makeButton("+",col1+90,y+25,playerTab)
flyPlus.Size = UDim2.new(0,80,0,30)

-- FLING
local function getPlayerFromName(name)
	name = name:lower()

	for _,plr in pairs(Players:GetPlayers()) do
		if plr.Name:lower():sub(1,#name) == name then
			return plr
		end
	end
end

local function flingPlayer(target)
	if not target.Character then return end
	if not player.Character then return end

	local myHRP = player.Character:FindFirstChild("HumanoidRootPart")
	local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")

	if not myHRP or not targetHRP then return end

	-- SAVE ORIGINAL POSITION
	local originalCFrame = myHRP.CFrame

	-- BODY VELOCITY
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e10,1e10,1e10)
	bv.Parent = myHRP

	-- BODY GYRO (SPIN)
	local bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	bg.P = 9e4
	bg.Parent = myHRP

	for i = 1,140 do
		if not target.Character then break end

		targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
		if not targetHRP then break end

		-- lock directly inside player
		myHRP.CFrame = targetHRP.CFrame

		-- insane spin in random directions
		myHRP.AssemblyAngularVelocity = Vector3.new(
			math.random(-5000,5000),
			math.random(-5000,5000),
			math.random(-5000,5000)
		)

		-- extremely strong fling force
		bv.Velocity = Vector3.new(
			math.random(-2500,2500),
			math.random(800,1600),
			math.random(-2500,2500)
		)

		RunService.Heartbeat:Wait()
	end

	bv:Destroy()
	bg:Destroy()

	-- stop momentum
	myHRP.AssemblyLinearVelocity = Vector3.zero
	myHRP.AssemblyAngularVelocity = Vector3.zero

	task.wait()

	-- teleport back
	myHRP.CFrame = originalCFrame
end

-- Player teleport
local function teleportToPlayer(target)
	if not target.Character then return end
	if not player.Character then return end

	local myHRP = player.Character:FindFirstChild("HumanoidRootPart")
	local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")

	if not myHRP or not targetHRP then return end

	-- teleport slightly behind player
	myHRP.CFrame = targetHRP.CFrame * CFrame.new(0,0,-3)
end

flingButton.MouseButton1Click:Connect(function()
	local text = flingInput.Text

	if text == "" then return end

	if text:lower() == "all" then
		for _,plr in pairs(Players:GetPlayers()) do
			if plr ~= player then
				flingPlayer(plr)
				task.wait(0.3)
			end
		end
	else
		local target = getPlayerFromName(text)

		if target and target ~= player then
			flingPlayer(target)
		end
	end
end)

teleportButton.MouseButton1Click:Connect(function()
	local text = flingInput.Text

	if text == "" then return end

	if text:lower() == "all" then
		for _,plr in pairs(Players:GetPlayers()) do
			if plr ~= player then
				teleportToPlayer(plr)
				task.wait(0.4)
			end
		end
	else
		local target = getPlayerFromName(text)

		if target and target ~= player then
			teleportToPlayer(target)
		end
	end
end)

local camera = workspace.CurrentCamera

viewPlayerButton.MouseButton1Click:Connect(function()
	if viewing then
		-- RETURN TO YOURSELF
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			camera.CameraSubject = player.Character.Humanoid
		end

		viewing = false
		viewedPlayer = nil
		viewPlayerButton.Text = "View Player"
		return
	end

	local text = flingInput.Text
	if text == "" then return end

	local target = getPlayerFromName(text)

	if target and target.Character then
		local hum = target.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			camera.CameraSubject = hum
			viewing = true
			viewedPlayer = target
			viewPlayerButton.Text = "Stop Viewing"
		end
	end
end)

-- WALKSPEED
local wsLabel = Instance.new("TextLabel")
wsLabel.Size = UDim2.new(0,180,0,25)
wsLabel.Position = UDim2.new(0,col2,0,y)
wsLabel.Text = "WalkSpeed: "..walkSpeed
wsLabel.BackgroundTransparency = 1
wsLabel.TextColor3 = Color3.new(1,1,1)
wsLabel.Parent = playerTab
outlineText(wsLabel)

local wsMinus = makeButton("-",col2,y+25,playerTab)
wsMinus.Size = UDim2.new(0,80,0,30)

local wsPlus = makeButton("+",col2+90,y+25,playerTab)
wsPlus.Size = UDim2.new(0,80,0,30)

-- SPEED CHANGERS
flyPlus.MouseButton1Click:Connect(function()
	flySpeed += 20
	flySpeedLabel.Text = "Fly Speed: "..flySpeed
end)

flyMinus.MouseButton1Click:Connect(function()
	flySpeed = math.max(10,flySpeed-20)
	flySpeedLabel.Text = "Fly Speed: "..flySpeed
end)

wsPlus.MouseButton1Click:Connect(function()
	walkSpeed += 5
	wsLabel.Text = "WalkSpeed: "..walkSpeed
	local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if h then h.WalkSpeed = walkSpeed end
end)

wsMinus.MouseButton1Click:Connect(function()
	walkSpeed = math.max(5,walkSpeed-5)
	wsLabel.Text = "WalkSpeed: "..walkSpeed
	local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if h then h.WalkSpeed = walkSpeed end
end)

RunService.RenderStepped:Connect(function()
	-- rainbow color
	local hue = (tick() % 5) / 5
	local rainbow = Color3.fromHSV(hue,1,1)

	-- owner text rainbow
	if owner then
		owner.TextColor3 = rainbow
	end

	-- ESP rainbow
	if espEnabled then
		for _,esp in pairs(espObjects) do
			if esp then
				esp.OutlineColor = rainbow
			end
		end
	end
end)

-- ESP
local espObjects = {}

local function addESP(plr)
	if plr == player then return end

	local function create(char)
		if espObjects[plr] then
			espObjects[plr]:Destroy()
		end

		local h = Instance.new("Highlight")
		h.FillTransparency = 1
		h.OutlineTransparency = 0
		h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		h.Adornee = char

		-- set initial rainbow color
		local hue = (tick() % 5) / 5
		h.OutlineColor = Color3.fromHSV(hue,1,1)

		h.Parent = char
		espObjects[plr] = h
	end

	if plr.Character then
		create(plr.Character)
	end

	plr.CharacterAdded:Connect(create)
end

local function removeESP()
	for _,plr in pairs(Players:GetPlayers()) do
		if plr.Character then
			for _,v in pairs(plr.Character:GetChildren()) do
				if v:IsA("Highlight") then
					v:Destroy()
				end
			end
		end
	end
	espObjects = {}
end

local espButton = makeButton("Toggle ESP",120,40,viewTab)

espButton.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled

	if espEnabled then
		for _,plr in pairs(Players:GetPlayers()) do
			addESP(plr)
		end
		espButton.Text = "ESP: ON"
	else
		removeESP()
		espButton.Text = "Toggle ESP"
	end
end)

RunService.RenderStepped:Connect(function()
	local hue = (tick() % 5) / 5
	local rainbow = Color3.fromHSV(hue,1,1)

	-- rainbow owner text
	if owner then
		owner.TextColor3 = rainbow
	end

	-- rainbow esp
	if espEnabled then
		for _,highlight in pairs(espObjects) do
			if highlight then
				highlight.OutlineColor = rainbow
			end
		end
	end
end)

-- APPLY WALKSPEED ON RESPAWN
player.CharacterAdded:Connect(function(char)
	local hum = char:WaitForChild("Humanoid")
	hum.WalkSpeed = walkSpeed
end)

-- NOCLIP SYSTEM
RunService.Stepped:Connect(function()
	if noclip and player.Character then
		for _,part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

noclipButton.MouseButton1Click:Connect(function()
	noclip = not noclip

	if noclip then
		noclipButton.Text = "Noclip: ON"
	else
		noclipButton.Text = "Noclip"
	end
end)

-- FLY FUNCTIONS
local function startFly()
	local char = player.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	BV = Instance.new("BodyVelocity")
	BV.MaxForce = Vector3.new(9e9,9e9,9e9)
	BV.Velocity = Vector3.zero
	BV.Parent = hrp

	BG = Instance.new("BodyGyro")
	BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
	BG.CFrame = hrp.CFrame
	BG.Parent = hrp

	flying = true
end

local function stopFly()
	flying = false

	if BV then
		BV:Destroy()
		BV = nil
	end

	if BG then
		BG:Destroy()
		BG = nil
	end
end

flyButton.MouseButton1Click:Connect(function()
	if flying then
		stopFly()
		flyButton.Text = "Fly"
	else
		startFly()
		flyButton.Text = "Fly: ON"
	end
end)



UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W then keys.W = false end
	if input.KeyCode == Enum.KeyCode.A then keys.A = false end
	if input.KeyCode == Enum.KeyCode.S then keys.S = false end
	if input.KeyCode == Enum.KeyCode.D then keys.D = false end
	if input.KeyCode == Enum.KeyCode.Space then keys.Space = false end
	if input.KeyCode == Enum.KeyCode.LeftControl then keys.Ctrl = false end
end)

-- FLY MOVEMENT
RunService.RenderStepped:Connect(function()
	if flying and player.Character then
		local hrp = player.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end

		local cam = workspace.CurrentCamera

		if BG then
			BG.CFrame = cam.CFrame
		end

		local direction = Vector3.zero

		if keys.W then direction += cam.CFrame.LookVector end
		if keys.S then direction -= cam.CFrame.LookVector end
		if keys.A then direction -= cam.CFrame.RightVector end
		if keys.D then direction += cam.CFrame.RightVector end
		if keys.Space then direction += cam.CFrame.UpVector end
		if keys.Ctrl then direction -= cam.CFrame.UpVector end

		if BV then
			BV.Velocity = direction * flySpeed
		end
	end
end)
