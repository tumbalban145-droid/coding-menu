--==================================================
-- MODERN ROBLOX MENU
-- FULL REVISED VERSION
-- LocalScript
-- StarterPlayer > StarterPlayerScripts
--==================================================

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

--==================================================
-- PLAYER
--==================================================

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

--==================================================
-- RESPONSIVE SCALE
--==================================================

local UIScale = Instance.new("UIScale")
UIScale.Parent = ScreenGui

local camera = workspace.CurrentCamera

local function UpdateScale()

	if not camera then
		return
	end

	local viewport = camera.ViewportSize

	local scaleX = viewport.X / 640
	local scaleY = viewport.Y / 430

	local scale = math.min(scaleX, scaleY)

	scale = math.clamp(scale, 0.55, 1)

	UIScale.Scale = scale
end

UpdateScale()

if camera then
	camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
end

--==================================================
-- MAIN FRAME
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"
Main.Size = UDim2.new(0, 560, 0, 360)
Main.Position = UDim2.new(0.5, -280, 0.5, -180)

Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BorderSizePixel = 0

Main.ClipsDescendants = true
Main.ZIndex = 1

Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")

Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 65)
Header.Position = UDim2.new(0, 0, 0, 0)

Header.BackgroundColor3 = Color3.fromRGB(25, 25, 34)
Header.BorderSizePixel = 0

Header.ZIndex = 2
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")

Title.Name = "Title"

Title.Size = UDim2.new(1, -110, 0, 30)
Title.Position = UDim2.new(0, 20, 0, 8)

Title.BackgroundTransparency = 1

Title.Text = "MODERN MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

Title.TextSize = 21
Title.Font = Enum.Font.GothamBold

Title.TextXAlignment = Enum.TextXAlignment.Left

Title.ZIndex = 4
Title.Parent = Header

--==================================================
-- SUBTITLE
--==================================================

local Subtitle = Instance.new("TextLabel")

Subtitle.Name = "Subtitle"

Subtitle.Size = UDim2.new(1, -110, 0, 18)
Subtitle.Position = UDim2.new(0, 21, 0, 38)

Subtitle.BackgroundTransparency = 1

Subtitle.Text = "Welcome, " .. player.DisplayName
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 165)

Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham

Subtitle.TextXAlignment = Enum.TextXAlignment.Left

Subtitle.ZIndex = 4
Subtitle.Parent = Header

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")

Sidebar.Name = "Sidebar"

Sidebar.Size = UDim2.new(0, 140, 1, -80)
Sidebar.Position = UDim2.new(0, 12, 0, 75)

Sidebar.BackgroundColor3 = Color3.fromRGB(23, 23, 31)
Sidebar.BorderSizePixel = 0

Sidebar.ZIndex = 2
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")

Content.Name = "Content"

Content.Size = UDim2.new(1, -165, 1, -80)
Content.Position = UDim2.new(0, 155, 0, 75)

Content.BackgroundColor3 = Color3.fromRGB(23, 23, 31)
Content.BorderSizePixel = 0

Content.ClipsDescendants = true
Content.ZIndex = 2
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = Content

--==================================================
-- TAB SYSTEM
--==================================================

local Tabs = {}

local function CreateTab(name, text, order)

	local Button = Instance.new("TextButton")

	Button.Name = name

	Button.Size = UDim2.new(1, -16, 0, 42)
	Button.Position = UDim2.new(
		0,
		8,
		0,
		10 + ((order - 1) * 50)
	)

	Button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	Button.BackgroundTransparency = 1

	Button.BorderSizePixel = 0

	Button.Text = text
	Button.TextColor3 = Color3.fromRGB(160, 160, 175)

	Button.TextSize = 13
	Button.Font = Enum.Font.GothamSemibold

	Button.AutoButtonColor = false
	Button.ZIndex = 5

	Button.Parent = Sidebar

	local Corner = Instance.new("UICorner")

	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Button

	Tabs[name] = Button

	-- Hover
	Button.MouseEnter:Connect(function()

		if Button:GetAttribute("Selected") then
			return
		end

		TweenService:Create(
			Button,
			TweenInfo.new(0.15),
			{
				BackgroundTransparency = 0.4,
				BackgroundColor3 = Color3.fromRGB(40, 40, 52)
			}
		):Play()

	end)

	Button.MouseLeave:Connect(function()

		if Button:GetAttribute("Selected") then
			return
		end

		TweenService:Create(
			Button,
			TweenInfo.new(0.15),
			{
				BackgroundTransparency = 1
			}
		):Play()

	end)

	return Button
end

--==================================================
-- CREATE TABS
--==================================================

local MainTab = CreateTab(
	"MainTab",
	"Main Menu",
	1
)

local PlayerTab = CreateTab(
	"PlayerTab",
	"Player",
	2
)

local FunTab = CreateTab(
	"FunTab",
	"Fun Function",
	3
)

--==================================================
-- PAGE SYSTEM
--==================================================

local Pages = {}

local function CreatePage(name)

	local Page = Instance.new("ScrollingFrame")

	Page.Name = name

	Page.Size = UDim2.new(1, -20, 1, -20)
	Page.Position = UDim2.new(0, 10, 0, 10)

	Page.BackgroundTransparency = 1
	Page.BorderSizePixel = 0

	Page.ScrollBarThickness = 3
	Page.ScrollBarImageTransparency = 0.3

	Page.AutomaticCanvasSize = Enum.AutomaticSize.Y

	Page.ScrollingDirection = Enum.ScrollingDirection.Y

	Page.Visible = false

	Page.ZIndex = 3

	Page.Parent = Content

	local Layout = Instance.new("UIListLayout")

	Layout.Padding = UDim.new(0, 8)
	Layout.SortOrder = Enum.SortOrder.LayoutOrder

	Layout.Parent = Page

	Pages[name] = Page

	return Page
end

--==================================================
-- CREATE PAGES
--==================================================

local MainPage = CreatePage("MainPage")
local PlayerPage = CreatePage("PlayerPage")
local FunPage = CreatePage("FunPage")

--==================================================
-- PAGE TITLE
--==================================================

local function AddTitle(Page, text)

	local Label = Instance.new("TextLabel")

	Label.Size = UDim2.new(1, -5, 0, 35)

	Label.BackgroundTransparency = 1

	Label.Text = text

	Label.TextColor3 = Color3.fromRGB(255, 255, 255)

	Label.TextSize = 19
	Label.Font = Enum.Font.GothamBold

	Label.TextXAlignment = Enum.TextXAlignment.Left

	Label.ZIndex = 4

	Label.Parent = Page

	return Label
end

--==================================================
-- BUTTON FUNCTION
--==================================================

local function AddButton(Page, text, callback)

	local Button = Instance.new("TextButton")

	Button.Size = UDim2.new(1, -5, 0, 45)

	Button.BackgroundColor3 = Color3.fromRGB(32, 32, 43)

	Button.BorderSizePixel = 0

	Button.Text = text

	Button.TextColor3 = Color3.fromRGB(235, 235, 240)

	Button.TextSize = 13
	Button.Font = Enum.Font.GothamSemibold

	Button.AutoButtonColor = false

	Button.ZIndex = 4

	Button.Parent = Page

	local Corner = Instance.new("UICorner")

	Corner.CornerRadius = UDim.new(0, 8)

	Corner.Parent = Button

	-- Hover
	Button.MouseEnter:Connect(function()

		TweenService:Create(
			Button,
			TweenInfo.new(0.12),
			{
				BackgroundColor3 = Color3.fromRGB(48, 48, 62)
			}
		):Play()

	end)

	Button.MouseLeave:Connect(function()

		TweenService:Create(
			Button,
			TweenInfo.new(0.12),
			{
				BackgroundColor3 = Color3.fromRGB(32, 32, 43)
			}
		):Play()

	end)

	-- Click
	Button.MouseButton1Click:Connect(function()

		if callback then
			callback(Button)
		end

	end)

	return Button
end

--==================================================
-- MAIN PAGE
--==================================================

AddTitle(
	MainPage,
	"Main Menu"
)

AddButton(
	MainPage,
	"Dashboard",
	function()

		print("Dashboard clicked")

	end
)

AddButton(
	MainPage,
	"base",
	function()

		local Players = game:GetService("Players") -- 1. game.Player harusnya Players
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local rootPart = char:WaitForChild("HumanoidRootPart") -- 2. nunggu character ke load

rootPart.CFrame = CFrame.new(-129.535553, 58.8707581, -7859.33984, -1, 0, 0, 0, 1, 0, 0, 0, -1) 
-- Cframe.new harusnya CFrame.new. F nya gede

	end
)

AddButton(
	MainPage,
	"Settings",
	function()

		print("Settings clicked")

	end
)

--==================================================
-- PLAYER PAGE
--==================================================

AddTitle(
	PlayerPage,
	"Player"
)

-- SPEED SYSTEM

local SpeedEnabled = false

local SpeedButton

SpeedButton = AddButton(
	PlayerPage,
	"Speed: OFF",
	function(Button)

		SpeedEnabled = not SpeedEnabled

		local character = player.Character
		local humanoid = character
			and character:FindFirstChildOfClass("Humanoid")

		if humanoid then

			if SpeedEnabled then

				humanoid.WalkSpeed = 50

				Button.Text = "Speed: ON"

			else

				humanoid.WalkSpeed = 16

				Button.Text = "Speed: OFF"

			end

		end

	end
)

-- PLAYER INFORMATION

AddButton(
	PlayerPage,
	"Player Information",
	function()

		print("Player:", player.Name)
		print("Display Name:", player.DisplayName)

	end
)

-- RESET

AddButton(
	PlayerPage,
	"Reset Character",
	function()

		if player.Character then

			local humanoid =
				player.Character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.Health = 0
			end

		end

	end
)

--==================================================
-- FUN PAGE
--==================================================

AddTitle(
	FunPage,
	"Fun Function"
)

AddButton(
	FunPage,
	"Fun Function 1",
	function()

		print("Fun Function 1")

	end
)

AddButton(
	FunPage,
	"Fun Function 2",
	function()

		print("Fun Function 2")

	end
)

AddButton(
	FunPage,
	"Fun Function 3",
	function()

		print("Fun Function 3")

	end
)

--==================================================
-- TAB SELECTOR
--==================================================

local function SelectTab(tabName, pageName)

	-- Reset semua tab
	for name, button in pairs(Tabs) do

		button:SetAttribute("Selected", false)

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(160, 160, 175)
			}
		):Play()

	end

	-- Hide semua page
	for name, page in pairs(Pages) do

		page.Visible = false

	end

	-- Selected tab
	local SelectedButton = Tabs[tabName]

	SelectedButton:SetAttribute("Selected", true)

	TweenService:Create(
		SelectedButton,
		TweenInfo.new(0.15),
		{
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.fromRGB(45, 45, 60),
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}
	):Play()

	-- Show page
	Pages[pageName].Visible = true

end

--==================================================
-- TAB EVENTS
--==================================================

MainTab.MouseButton1Click:Connect(function()

	SelectTab(
		"MainTab",
		"MainPage"
	)

end)

PlayerTab.MouseButton1Click:Connect(function()

	SelectTab(
		"PlayerTab",
		"PlayerPage"
	)

end)

FunTab.MouseButton1Click:Connect(function()

	SelectTab(
		"FunTab",
		"FunPage"
	)

end)

--==================================================
-- DEFAULT PAGE
--==================================================

SelectTab(
	"MainTab",
	"MainPage"
)

--==================================================
-- EXIT BUTTON
--==================================================

local ExitButton = Instance.new("TextButton")

ExitButton.Name = "ExitButton"

ExitButton.Size = UDim2.new(0, 75, 0, 38)

ExitButton.Position = UDim2.new(
	1,
	-90,
	1,
	-50
)

ExitButton.BackgroundColor3 = Color3.fromRGB(180, 45, 45)

ExitButton.BorderSizePixel = 0

ExitButton.Text = "EXIT"

ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ExitButton.TextSize = 13
ExitButton.Font = Enum.Font.GothamBold

ExitButton.AutoButtonColor = false

ExitButton.ZIndex = 20

ExitButton.Parent = Main

local ExitCorner = Instance.new("UICorner")

ExitCorner.CornerRadius = UDim.new(0, 8)

ExitCorner.Parent = ExitButton

-- Exit hover
ExitButton.MouseEnter:Connect(function()

	TweenService:Create(
		ExitButton,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 = Color3.fromRGB(220, 60, 60)
		}
	):Play()

end)

ExitButton.MouseLeave:Connect(function()

	TweenService:Create(
		ExitButton,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 = Color3.fromRGB(180, 45, 45)
		}
	):Play()

end)

-- Exit click
ExitButton.MouseButton1Click:Connect(function()

	ScreenGui.Enabled = false

end)

--==================================================
-- OPEN ANIMATION
--==================================================

Main.Size = UDim2.new(0, 0, 0, 0)

TweenService:Create(
	Main,
	TweenInfo.new(
		0.4,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	),
	{
		Size = UDim2.new(0, 560, 0, 360)
	}
):Play()
