--// MODERN ROBLOX MENU - REVISED
--// LocalScript
--// Taruh di StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

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
-- MAIN FRAME
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 620, 0, 400)
Main.Position = UDim2.new(0.5, -310, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BorderSizePixel = 0
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
Header.Size = UDim2.new(1, 0, 0, 70)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 34)
Header.BorderSizePixel = 0
Header.ZIndex = 2
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 0, 32)
Title.Position = UDim2.new(0, 20, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "MODERN MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 23
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = Header

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -40, 0, 20)
Subtitle.Position = UDim2.new(0, 21, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Welcome, " .. player.DisplayName
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 165)
Subtitle.TextSize = 13
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.ZIndex = 3
Subtitle.Parent = Header

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 155, 1, -85)
Sidebar.Position = UDim2.new(0, 15, 0, 80)
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
Content.Size = UDim2.new(1, -185, 1, -85)
Content.Position = UDim2.new(0, 175, 0, 80)
Content.BackgroundColor3 = Color3.fromRGB(23, 23, 31)
Content.BorderSizePixel = 0
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
	Button.Size = UDim2.new(1, -20, 0, 45)
	Button.Position = UDim2.new(
		0,
		10,
		0,
		15 + ((order - 1) * 55)
	)

	Button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	Button.BackgroundTransparency = 1
	Button.BorderSizePixel = 0

	Button.Text = text
	Button.TextColor3 = Color3.fromRGB(160, 160, 175)
	Button.TextSize = 14
	Button.Font = Enum.Font.GothamSemibold

	Button.AutoButtonColor = false
	Button.ZIndex = 4
	Button.Parent = Sidebar

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Button

	Tabs[name] = Button

	return Button
end

-- Tidak memakai simbol Unicode agar tidak muncul kotak
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

	Page.ScrollBarThickness = 4
	Page.ScrollBarImageTransparency = 0.5

	Page.CanvasSize = UDim2.new(0, 0, 0, 0)

	Page.Visible = false
	Page.ZIndex = 3
	Page.Parent = Content

	local Layout = Instance.new("UIListLayout")

	Layout.Padding = UDim.new(0, 10)
	Layout.SortOrder = Enum.SortOrder.LayoutOrder

	Layout.Parent = Page

	Pages[name] = Page

	return Page
end

local MainPage = CreatePage("MainPage")
local PlayerPage = CreatePage("PlayerPage")
local FunPage = CreatePage("FunPage")

--==================================================
-- PAGE TITLE
--==================================================

local function AddTitle(Page, text)

	local Label = Instance.new("TextLabel")

	Label.Size = UDim2.new(1, -10, 0, 40)
	Label.BackgroundTransparency = 1

	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.TextSize = 20
	Label.Font = Enum.Font.GothamBold

	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.ZIndex = 4

	Label.Parent = Page

	return Label
end

--==================================================
-- BUTTON
--==================================================

local function AddButton(Page, text, callback)

	local Button = Instance.new("TextButton")

	Button.Size = UDim2.new(1, -10, 0, 48)

	Button.BackgroundColor3 = Color3.fromRGB(32, 32, 43)
	Button.BorderSizePixel = 0

	Button.Text = text
	Button.TextColor3 = Color3.fromRGB(235, 235, 240)
	Button.TextSize = 14
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
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Color3.fromRGB(50, 50, 65)
			}
		):Play()

	end)

	Button.MouseLeave:Connect(function()

		TweenService:Create(
			Button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Color3.fromRGB(32, 32, 43)
			}
		):Play()

	end)

	-- Click
	Button.MouseButton1Click:Connect(function()

		if callback then
			callback()
		end

	end)

	return Button
end

--==================================================
-- MAIN MENU
--==================================================

AddTitle(
	MainPage,
	"Main Menu"
)

AddButton(
	MainPage,
	"secret rarity",
	function()

		local Players = game:GetService("Players") -- 1. game.Player harusnya Players
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local rootPart = char:WaitForChild("HumanoidRootPart") -- 2. nunggu character ke load

rootPart.CFrame = CFrame.new(-129.535553, 58.8707581, -7859.33984, -1, 0, 0, 0, 1, 0, 0, 0, -1) 


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

rootPart.CFrame = CFrame.new(-93.2106934, 55.2619057, 27.3969727, -1, 0, -0, 0, 0, -1, 0, -1, -0) 


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
-- PLAYER
--==================================================

AddTitle(
	PlayerPage,
	"Player"
)

AddButton(
	PlayerPage,
	"Player Information",
	function()

		print("Player information")

	end
)

AddButton(
	PlayerPage,
	"Reset Character",
	function()

		if player.Character then
			player.Character:BreakJoints()
		end

	end
)

--==================================================
-- FUN FUNCTION
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
-- SELECT TAB
--==================================================

local function SelectTab(tabName, pageName)

	-- Matikan semua tab
	for _, button in pairs(Tabs) do

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(160, 160, 175)
			}
		):Play()

	end

	-- Sembunyikan semua page
	for _, page in pairs(Pages) do
		page.Visible = false
	end

	-- Tab yang dipilih
	local SelectedButton = Tabs[tabName]

	TweenService:Create(
		SelectedButton,
		TweenInfo.new(0.15),
		{
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.fromRGB(45, 45, 60),
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}
	):Play()

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

-- Default
SelectTab(
	"MainTab",
	"MainPage"
)

--==================================================
-- OPEN ANIMATION
--==================================================

Main.Size = UDim2.new(0, 0, 0, 0)

TweenService:Create(
	Main,
	TweenInfo.new(
		0.35,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	),
	{
		Size = UDim2.new(0, 620, 0, 400)
	}
)
--==================================================
-- EXIT BUTTON
--==================================================

local ExitButton = Instance.new("TextButton")
ExitButton.Name = "ExitButton"
ExitButton.Size = UDim2.new(0, 40, 0, 40)
ExitButton.Position = UDim2.new(1, -50, 0, 15)

ExitButton.BackgroundColor3 = Color3.fromRGB(180, 45, 45)
ExitButton.BackgroundTransparency = 0
ExitButton.BorderSizePixel = 0

ExitButton.Text = "X"
ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitButton.TextSize = 18
ExitButton.Font = Enum.Font.GothamBold

ExitButton.ZIndex = 5
ExitButton.Parent = Header

local ExitCorner = Instance.new("UICorner")
ExitCorner.CornerRadius = UDim.new(0, 8)
ExitCorner.Parent = ExitButton

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

ExitButton.MouseButton1Click:Connect(function()
	ScreenGui.Enabled = false
end)
