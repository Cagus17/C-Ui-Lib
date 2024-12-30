local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local tween = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local tweeninfo = TweenInfo.new
local Mouse = LocalPlayer:GetMouse()
local function DraggingEnabled(topbarobject, object)
	local function CustomPos(topbarobject, object)
		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function UpdatePos(inputtext)
			local Delta = inputtext.Position - DragStart
			local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
			local Tween = tween:Create(object, TweenInfo.new(0.2), {Position = pos})
			Tween:Play()
		end

		topbarobject.InputBegan:Connect(function(inputtext)
			if inputtext.UserInputType == Enum.UserInputType.MouseButton1 or inputtext.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = inputtext.Position
				StartPosition = object.Position

				inputtext.Changed:Connect(function()
					if inputtext.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		topbarobject.InputChanged:Connect(function(inputtext)
			if inputtext.UserInputType == Enum.UserInputType.MouseMovement or inputtext.UserInputType == Enum.UserInputType.Touch then
				DragInput = inputtext
			end
		end)

		input.InputChanged:Connect(function(inputtext)
			if inputtext == DragInput and Dragging then
				UpdatePos(inputtext)
			end
		end)
	end
	local function CustomSize(object)
		local Dragging = false
		local DragInput = nil
		local DragStart = nil
		local StartSize = nil
		local maxSizeX = object.Size.X.Offset
		if maxSizeX < 400 then
			maxSizeX = 400
		end
		local maxSizeY = maxSizeX - 100
		object.Size = UDim2.new(0, maxSizeX, 0, maxSizeY)
		local changesizeobject = Instance.new("Frame");

		changesizeobject.AnchorPoint = Vector2.new(1, 1)
		changesizeobject.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		changesizeobject.BackgroundTransparency = 0.9990000128746033
		changesizeobject.BorderColor3 = Color3.fromRGB(0, 0, 0)
		changesizeobject.BorderSizePixel = 0
		changesizeobject.Position = UDim2.new(1, 20, 1, 20)
		changesizeobject.Size = UDim2.new(0, 40, 0, 40)
		changesizeobject.Name = "changesizeobject"
		changesizeobject.Parent = object

		local function UpdateSize(inputtext)
			local Delta = input.Position - DragStart
			local newWidth = StartSize.X.Offset + Delta.X
			local newHeight = StartSize.Y.Offset + Delta.Y
			newWidth = math.max(newWidth, maxSizeX)
			newHeight = math.max(newHeight, maxSizeY)
			local Tween = tween:Create(object, TweenInfo.new(0.2), {Size = UDim2.new(0, newWidth, 0, newHeight)})
			Tween:Play()
		end

		changesizeobject.InputBegan:Connect(function(inputtext)
			if inputtext.UserInputType == Enum.UserInputType.MouseButton1 or inputtext.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = inputtext.Position
				StartSize = object.Size
				inputtext.Changed:Connect(function()
					if inputtext.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		changesizeobject.InputChanged:Connect(function(inputtext)
			if inputtext.UserInputType == Enum.UserInputType.MouseMovement or inputtext.UserInputType == Enum.UserInputType.Touch then
				DragInput = inputtext
			end
		end)

		input.InputChanged:Connect(function(inputtext)
			if inputtext == DragInput and Dragging then
				UpdateSize(inputtext)
			end
		end)
	end
	CustomSize(object)
	CustomPos(topbarobject, object)
end

function CircleClick(Button, X, Y)
	spawn(function()
		Button.ClipsDescendants = true
		local Circle = Instance.new("ImageLabel")
		Circle.Image = "rbxassetid://266543268"
		Circle.ImageColor3 = Color3.fromRGB(80, 80, 80)
		Circle.ImageTransparency = 0.8999999761581421
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 1
		Circle.ZIndex = 10
		Circle.Name = "Circle"
		Circle.Parent = Button

		local NewX = X - Circle.AbsolutePosition.X
		local NewY = Y - Circle.AbsolutePosition.Y
		Circle.Position = UDim2.new(0, NewX, 0, NewY)
		local Size = 0
		if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.X*1.5
		elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.Y*1.5
		elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.X*1.5
		end

		local Time = 0.5
		Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
		for i=1,10 do
			Circle.ImageTransparency = Circle.ImageTransparency + 0.01
			wait(Time/10)
		end
		Circle:Destroy()
	end)
end

local ArcHub = {}
function ArcHub:Create(GuiConfig)
	local GuiConfig = GuiConfig or {}
	GuiConfig.NameHub = GuiConfig.NameHub or "Arc Hub"
	GuiConfig.Color = GuiConfig.Color or Color3.fromRGB(0, 85, 0)
	GuiConfig.Color1 = GuiConfig.Color1 or Color3.fromRGB(170, 255, 255)


	local nightmarefun = Instance.new("ScreenGui")
	local Shadow = Instance.new("ImageLabel")
	local mainFrame = Instance.new("Frame")
	local mainCorner = Instance.new("UICorner")
	local mainSide = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local nightmares = Instance.new("TextLabel")
	local LogoServer = Instance.new("ImageLabel")
	local LogoCorner = Instance.new("UICorner")
	local fun = Instance.new("TextLabel")
	local cover = Instance.new("Frame")
	local allTabs = Instance.new("Frame")
	local tabList = Instance.new("UIListLayout")
	local Close = Instance.new("TextButton");
	local ImageLabel1 = Instance.new("ImageLabel");
	local Min = Instance.new("TextButton");
	local ImageLabel2 = Instance.new("ImageLabel");
	local allPages = Instance.new("Frame")
	local pages = Instance.new("Folder")

	DraggingEnabled(mainFrame, Shadow)
	nightmarefun.Name = "nightmarefun"
	nightmarefun.Parent = LocalPlayer.PlayerGui
	nightmarefun.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	nightmarefun.ResetOnSpawn = false

	Shadow.Name = "Shadow"
	Shadow.Parent = nightmarefun
	Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(0.349795759, 0, 0.071759665, 0)
	Shadow.Size = UDim2.new(0, 525, 0, 468)
	Shadow.Image = "http://www.roblox.com/asset/?id=6105530152"
	Shadow.ImageColor3 = Color3.fromRGB(18, 18, 18)

	mainFrame.Name = "mainFrame"
	mainFrame.Parent = Shadow
	mainFrame.BackgroundColor3 = Color3.fromRGB(47, 47, 56)
	mainFrame.Position = UDim2.new(0.0500000007, 0, 0.0780000016, 0)
	mainFrame.Size = UDim2.new(0, 475, 0, 396)

	mainCorner.CornerRadius = UDim.new(0, 6)
	mainCorner.Name = "mainCorner"
	mainCorner.Parent = mainFrame

	mainSide.Name = "mainSide"
	mainSide.Parent = mainFrame
	mainSide.BackgroundColor3 = Color3.fromRGB(37, 37, 44)
	mainSide.Size = UDim2.new(0, 166, 0, 396)

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = mainSide

	game:GetService("UserInputService").InputBegan:connect(function(current) 
		if current.KeyCode.Name == Enum.KeyCode.LeftAlt.Name then 
			if nightmarefun.Enabled == true then
				nightmarefun.Enabled = false
			else
				nightmarefun.Enabled = true
			end
		end
	end)

	nightmares.Name = "nightmares"
	nightmares.Parent = mainSide
	nightmares.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	nightmares.BackgroundTransparency = 1.000
	nightmares.Position = UDim2.new(0.3299999262, 0, 0.0128203665, 0)
	nightmares.Size = UDim2.new(0, 103, 0, 28)
	nightmares.TextXAlignment = Enum.TextXAlignment.Left
	nightmares.Font = Enum.Font.Gotham
	nightmares.Text = GuiConfig.NameHub
	nightmares.TextColor3 = GuiConfig.Color
	nightmares.TextSize = 20.000
	nightmares.TextWrapped = true

	LogoServer.Image = "rbxassetid://91846793749573"
	LogoServer.AnchorPoint = Vector2.new(0.5, 0.5)
	LogoServer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoServer.BackgroundTransparency = 0.9990000128746033
	LogoServer.ImageTransparency = 0.2
	LogoServer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoServer.BorderSizePixel = 0
	LogoServer.Position = UDim2.new(0.1499999262, 0, 0.0528203665, 0)
	LogoServer.Size = UDim2.new(0, 30, 0, 30)
	LogoServer.Parent = mainSide

	LogoCorner.CornerRadius = UDim.new(0, 1000)
	LogoCorner.Parent = LogoServer

	fun.Name = "fun"
	fun.Parent = mainSide
	fun.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	fun.BackgroundTransparency = 1.000
	fun.Position = UDim2.new(0.622289062, 0, 0.0228203665, 0)
	fun.Size = UDim2.new(0, 54, 0, 27)
	fun.Font = Enum.Font.Gotham
	fun.Text = ""
	fun.TextColor3 = Color3.fromRGB(255, 255, 255)
	fun.TextSize = 20.000
	fun.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	fun.TextWrapped = true

	cover.Name = "cover"
	cover.Parent = mainSide
	cover.BackgroundColor3 = Color3.fromRGB(37, 37, 44)
	cover.BorderSizePixel = 0
	cover.Position = UDim2.new(0.949999988, 0, 0, 0)
	cover.Size = UDim2.new(0, 9, 0, 396)

	allTabs.Name = "allTabs"
	allTabs.Parent = mainSide
	allTabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	allTabs.BackgroundTransparency = 1.000
	allTabs.Position = UDim2.new(0.0499999262, 0, 0.108294941, 0)
	allTabs.Size = UDim2.new(0, 149, 0, 344)

	tabList.Name = "tabList"
	tabList.Parent = allTabs
	tabList.SortOrder = Enum.SortOrder.LayoutOrder

	Close.Font = Enum.Font.SourceSans
	Close.Text = ""
	Close.TextColor3 = Color3.fromRGB(0, 0, 0)
	Close.TextSize = 14
	Close.AnchorPoint = Vector2.new(1, 0.5)
	Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Close.BackgroundTransparency = 0.9990000128746033
	Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Close.BorderSizePixel = 0
	Close.Position = UDim2.new(1, 0, 0.017676767, 5)
	Close.Size = UDim2.new(0, 25, 0, 25)
	Close.Name = "Close"
	Close.Parent = mainFrame

	ImageLabel1.Image = "rbxassetid://9886659671"
	ImageLabel1.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel1.BackgroundTransparency = 0.9990000128746033
	ImageLabel1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel1.BorderSizePixel = 0
	ImageLabel1.Position = UDim2.new(0.366315782, 0, 0.5, 0)
	ImageLabel1.Size = UDim2.new(1, -8, 1, -8)
	ImageLabel1.Parent = Close

	Min.Font = Enum.Font.SourceSans
	Min.Text = ""
	Min.TextColor3 = Color3.fromRGB(0, 0, 0)
	Min.TextSize = 14
	Min.AnchorPoint = Vector2.new(1, 0.5)
	Min.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Min.BackgroundTransparency = 0.9990000128746033
	Min.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Min.BorderSizePixel = 0
	Min.Position = UDim2.new(0.9, 0, 0.037676767, 0)
	Min.Size = UDim2.new(0, 25, 0, 25)
	Min.Name = "Min"
	Min.Parent = mainFrame

	ImageLabel2.Image = "rbxassetid://9886659276"
	ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel2.BackgroundTransparency = 0.9990000128746033
	ImageLabel2.ImageTransparency = 0.2
	ImageLabel2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel2.BorderSizePixel = 0
	ImageLabel2.Position = UDim2.new(0.366315782, 0, 0.5, 0)
	ImageLabel2.Size = UDim2.new(1, -9, 1, -9)
	ImageLabel2.Parent = Min

	allPages.Name = "allPages"
	allPages.Parent = mainFrame
	allPages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	allPages.BackgroundTransparency = 1.000
	allPages.Position = UDim2.new(0.366315782, 0, 0.017676767, 20)
	allPages.Size = UDim2.new(0, 295, 0, 361)

	pages.Name = "pages"
	pages.Parent = allPages

	Close.Activated:Connect(function()
		CircleClick(Close, Mouse.X, Mouse.Y)
		Shadow.Visible = false
	end)
	local isMinimized = false
	Min.Activated:Connect(function()
		CircleClick(Min, Mouse.X, Mouse.Y)
		Shadow.Visible = false
	end)

	local Tabs = {}
	function Tabs:TabCreate(TabConfig)
		--------------------------
		local TabConfig = TabConfig or {}
		TabConfig.Name = TabConfig.Name or "Tab"
		TabConfig.Color = TabConfig.Color or  Color3.fromRGB(255, 0, 255)
		--------------------------
		local tabButton = Instance.new("TextButton")
		tabButton.Name = ""
		tabButton.Parent = allTabs
		tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tabButton.BackgroundTransparency = 1.000
		tabButton.Size = UDim2.new(0, 149, 0, 35)
		tabButton.Font = Enum.Font.Gotham
		tabButton.Text = TabConfig.Name
		tabButton.TextColor3 = Color3.fromRGB(87, 87, 104)
		tabButton.TextSize = 16.000

		local newPage = Instance.new("ScrollingFrame")
		newPage.Name = TabConfig.Name .. "Page"
		newPage.Parent = pages
		newPage.Active = true
		newPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		newPage.BackgroundTransparency = 1.000
		newPage.BorderSizePixel = 0
		newPage.Size = UDim2.new(1, 0, 1, 0)
		newPage.ScrollBarThickness = 6
		newPage.ScrollBarImageColor3 = TabConfig.Color
		newPage.Visible = false

		local sectionListing = Instance.new("UIListLayout")    
		sectionListing.Name = "sectionListing"
		sectionListing.Parent = newPage
		sectionListing.SortOrder = Enum.SortOrder.LayoutOrder
		sectionListing.Padding = UDim.new(0, 3)


		local function UpdateSize()
			local cS = sectionListing.AbsoluteContentSize

			game.TweenService:Create(newPage, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
			}):Play()
		end
		UpdateSize()
		newPage.ChildAdded:Connect(UpdateSize)
		newPage.ChildRemoved:Connect(UpdateSize)

		tabButton.MouseButton1Click:Connect(function()
			--Tab Button Functioning
			UpdateSize()
			for i,v in next, allTabs:GetChildren() do
				if v:IsA("TextButton") then
					game.TweenService:Create(v, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
						TextColor3 = Color3.fromRGB(87, 87, 104)
					}):Play()
					UpdateSize()
				end
			end
			game.TweenService:Create(tabButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
				TextColor3 = TabConfig.Color
			}):Play()
			----------------------
			--Page Functioning
			for i,v in next, pages:GetChildren() do
				v.Visible = false
				UpdateSize()
			end
			newPage.Visible = true
			----------------------
			return tabButton
		end)

		local sectionHandling = {}
		local isDropped = false

		function sectionHandling:Section(sectionName)
			local sectionName = sectionName or {}
			sectionName.Name = sectionName.Name or "Section"
			sectionName.Color = sectionName.Color or  Color3.fromRGB(255, 0, 255)

			local sectionFrame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local sectionListLayout = Instance.new("UIListLayout")
			local sectionFrameHead = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local sectionCircle = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local closeSection = Instance.new("ImageButton")

			sectionFrame.Name = "sectionFrame"
			sectionFrame.Parent = newPage
			sectionFrame.BackgroundColor3 = Color3.fromRGB(37, 37, 44)
			sectionFrame.Position = UDim2.new(0, 0, -8.009863e-08, 0)
			sectionFrame.Size = UDim2.new(0.9559322, 0, 0, 36)
			sectionFrame.ClipsDescendants = true

			UICorner.Parent = sectionFrame

			sectionListLayout.Parent = sectionFrame
			sectionListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			sectionListLayout.Padding = UDim.new(0, 3)
			sectionListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

			sectionFrameHead.Name = "sectionFrameHead"
			sectionFrameHead.Parent = sectionFrame
			sectionFrameHead.BackgroundColor3 = Color3.fromRGB(37, 37, 44)
			sectionFrameHead.Position = UDim2.new(0, 0, -8.009863e-08, 0)
			sectionFrameHead.Size = UDim2.new(1, 0, 0, 36)

			UICorner_2.Parent = sectionFrameHead

			sectionCircle.Name = "sectionCircle"
			sectionCircle.Parent = sectionFrameHead
			sectionCircle.BackgroundColor3 = Color3.fromRGB(82, 82, 98)
			sectionCircle.Position = UDim2.new(0.0354609936, 0, 0.388888896, 0)
			sectionCircle.Size = UDim2.new(0, 7, 0, 7)

			UICorner_3.CornerRadius = UDim.new(0, 99)
			UICorner_3.Parent = sectionCircle

			TextLabel.Parent = sectionFrameHead
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0.0992907807, 0, 0.194444448, 0)
			TextLabel.Size = UDim2.new(0, 173, 0, 22)
			TextLabel.Font = Enum.Font.Gotham
			TextLabel.Text = sectionName.Name
			TextLabel.TextColor3 = Color3.fromRGB(82, 82, 98)
			TextLabel.TextSize = 14.000
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left

			closeSection.Name = "closeSection"
			closeSection.Parent = sectionFrameHead
			closeSection.BackgroundTransparency = 1.000
			closeSection.Position = UDim2.new(0.889999986, 0, 0.155000001, 0)
			closeSection.Size = UDim2.new(0, 25, 0, 25)
			closeSection.ZIndex = 2
			closeSection.Image = "rbxassetid://3926305904"
			closeSection.ImageColor3 = Color3.fromRGB(82, 82, 98)
			closeSection.ImageRectOffset = Vector2.new(404, 284)
			closeSection.ImageRectSize = Vector2.new(36, 36)
			closeSection.MouseButton1Click:Connect(function()
				if isDropped then
					-- Logika untuk menutup
					isDropped = false
					sectionFrame:TweenSize(UDim2.new(0.956, 0, 0, 36), "In", "Linear", 0.10)
					game.TweenService:Create(closeSection, TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Rotation = 0,
						ImageColor3 = Color3.fromRGB(82, 82, 98)
					}):Play()
					game.TweenService:Create(sectionCircle, TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						BackgroundColor3 = Color3.fromRGB(82, 82, 98)
					}):Play()
					game.TweenService:Create(TextLabel, TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						TextColor3 = Color3.fromRGB(82, 82, 98)
					}):Play()
					wait(0.10)
					UpdateSize()
				else
					-- Logika untuk membuka
					isDropped = true
					sectionFrame:TweenSize(UDim2.new(0.956, 0, 0, sectionListLayout.AbsoluteContentSize.Y + 8), "In", "Linear", 0.10)
					game.TweenService:Create(closeSection, TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Rotation = 180,
						ImageColor3 = sectionName.Color
					}):Play()
					game.TweenService:Create(sectionCircle, TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						BackgroundColor3 = sectionName.Color
					}):Play()
					game.TweenService:Create(TextLabel, TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						TextColor3 = sectionName.Color
					}):Play()
					wait(0.10)
					UpdateSize()
				end
			end)
			local OpenSection = true
			local function UpdateSizeSection()
				if OpenSection then
					local SectionSizeYWitdh = 38
					for i, v in sectionFrame:GetChildren() do
						if v.Name ~= "UIListLayout" and v.Name ~= "UICorner" then
							SectionSizeYWitdh = SectionSizeYWitdh + v.Size.Y.Offset + 3
						end
					end
					tween:Create(sectionFrame, TweenInfo.new(0.5), {Size = UDim2.new(1, 0, 0, SectionSizeYWitdh - 38)}):Play()
					task.wait(0.5)
					UpdateSize()
				end
			end
			local itemHandling = {}
			local CountItem = 0
			function itemHandling:Button(btnText, callback)
				----
				btnText = btnText or "Click Me!"
				callback = callback or function() end
				----

				local buttonFrame = Instance.new("Frame")
				local UIListLayout = Instance.new("UIListLayout")
				local TextButton = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")

				buttonFrame.Name = "buttonFrame"
				buttonFrame.Parent = sectionFrame
				buttonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				buttonFrame.BackgroundTransparency = 1.000
				buttonFrame.Position = UDim2.new(0.0354609936, 0, 0.168103442, 0)
				buttonFrame.Size = UDim2.new(0, 262, 0, 31)

				UIListLayout.Parent = buttonFrame
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

				TextButton.Parent = buttonFrame
				TextButton.BackgroundColor3 = GuiConfig.Color
				TextButton.Position = UDim2.new(0.118320614, 0, -0.0813953504, 0)
				TextButton.Size = UDim2.new(0, 262,0, 31)
				TextButton.AutoButtonColor = false
				TextButton.Font = Enum.Font.Gotham
				TextButton.Text = btnText
				TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.TextSize = 14.000

				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = TextButton

				local clickDebounce = false
				local callBackDebounce = false
				local mouseleft

				TextButton.MouseButton1Down:Connect(function()
					if not clickDebounce then
						clickDebounce = true
						game.TweenService:Create(TextButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{
							Size = UDim2.new(0, 251,0, 28),
							TextSize = 13
						}):Play()
						wait(0.5)
						clickDebounce = false
					end
				end)

				TextButton.MouseButton1Click:Connect(function()
					if not callBackDebounce then
						callBackDebounce = true	
						callback()
						wait(0.5)
						callBackDebounce = false
					end
				end)

				TextButton.MouseButton1Up:Connect(function()
					if mouseleft then
						game.TweenService:Create(TextButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{
							Size = UDim2.new(0, 262,0, 31),
							TextSize = 14
						}):Play()
					else
						game.TweenService:Create(TextButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{
							Size = UDim2.new(0, 262,0, 31),
							TextSize = 14
						}):Play()
					end
				end)
				TextButton.MouseEnter:Connect(function()
					if callBackDebounce then
						mouseleft = false
						game.TweenService:Create(TextButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{
							BackgroundColor3 = GuiConfig.Color
						}):Play()
					else
						mouseleft = false
						game.TweenService:Create(TextButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{
							BackgroundColor3 = GuiConfig.Color
						}):Play()
					end
				end)
				TextButton.MouseLeave:Connect(function()
					if callBackDebounce then
						mouseleft = true
						game.TweenService:Create(TextButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{
							Size = UDim2.new(0, 262,0, 31),
							TextSize = 14
						}):Play()
						game.TweenService:Create(TextButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{
							BackgroundColor3 = GuiConfig.Color
						}):Play()
					else
						mouseleft = true
						game.TweenService:Create(TextButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{
							Size = UDim2.new(0, 262,0, 31),
							TextSize = 14
						}):Play()
						game.TweenService:Create(TextButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{
							BackgroundColor3 = GuiConfig.Color
						}):Play()
					end
				end)
			end
			function itemHandling:Toggle(ToggleConfig)
				local ToggleConfig = ToggleConfig or {}
				ToggleConfig.Title = ToggleConfig.Title or "Title"
				ToggleConfig.Default = ToggleConfig.Default or false
				ToggleConfig.Callback = ToggleConfig.Callback or function() end
				local ToggleFunc = {Value = ToggleConfig.Default, Options = ToggleConfig.Options, Selecting = ToggleConfig.Selecting}

				local Toggle = Instance.new("Frame");
				local UICorner20 = Instance.new("UICorner");
				local ToggleTitle = Instance.new("TextLabel");
				local ToggleButton = Instance.new("TextButton");
				local Frame = Instance.new("Frame");
				local ImageLabel3 = Instance.new("ImageLabel");
				local UICorner21 = Instance.new("UICorner");
				local TextButton = Instance.new("TextButton");
				local FeatureFrame2 = Instance.new("Frame");
				local UICorner22 = Instance.new("UICorner");
				local UIStroke8 = Instance.new("UIStroke");
				local ToggleCircle = Instance.new("Frame");
				local UICorner23 = Instance.new("UICorner");

				Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.BackgroundTransparency = 0.9990000128746033
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.LayoutOrder = CountItem
				Toggle.Size = UDim2.new(1, 0, 0, 46)
				Toggle.Name = "Toggle"
				Toggle.Parent = sectionFrame

				UICorner20.CornerRadius = UDim.new(0, 4)
				UICorner20.Parent = Toggle

				ToggleTitle.Font = Enum.Font.GothamBold
				ToggleTitle.Text = ToggleConfig.Title
				ToggleTitle.TextSize = 13
				ToggleTitle.TextColor3 = Color3.fromRGB(230.77499270439148, 230.77499270439148, 230.77499270439148)
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
				ToggleTitle.TextYAlignment = Enum.TextYAlignment.Top
				ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleTitle.BackgroundTransparency = 0.9990000128746033
				ToggleTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleTitle.BorderSizePixel = 0
				ToggleTitle.Position = UDim2.new(0, 10, 0, 10)
				ToggleTitle.Size = UDim2.new(1, -100, 0, 13)
				ToggleTitle.Name = "ToggleTitle"
				ToggleTitle.Parent = Toggle

				ToggleButton.Font = Enum.Font.SourceSans
				ToggleButton.Text = ""
				ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ToggleButton.TextSize = 14
				ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				ToggleButton.BackgroundTransparency = 0.9990000128746033
				ToggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleButton.BorderSizePixel = 0
				ToggleButton.Size = UDim2.new(1, 0, 1, 0)
				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = Toggle

				FeatureFrame2.AnchorPoint = Vector2.new(1, 0.5)
				FeatureFrame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				FeatureFrame2.BackgroundTransparency = 0.9200000166893005
				FeatureFrame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				FeatureFrame2.BorderSizePixel = 0
				FeatureFrame2.Position = UDim2.new(1, -30, 0.5, 0)
				FeatureFrame2.Size = UDim2.new(0, 30, 0, 15)
				FeatureFrame2.Name = "FeatureFrame"
				FeatureFrame2.Parent = Toggle

				UICorner22.Parent = FeatureFrame2

				UIStroke8.Color = Color3.fromRGB(255, 255, 255)
				UIStroke8.Thickness = 2
				UIStroke8.Transparency = 0.9
				UIStroke8.Parent = FeatureFrame2

				ToggleCircle.BackgroundColor3 = Color3.fromRGB(230.00000149011612, 230.00000149011612, 230.00000149011612)
				ToggleCircle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleCircle.BorderSizePixel = 0
				ToggleCircle.Position = UDim2.new(0, 0, 0, 0)
				ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
				ToggleCircle.Name = "ToggleCircle"
				ToggleCircle.Parent = FeatureFrame2

				UICorner23.CornerRadius = UDim.new(0, 15)
				UICorner23.Parent = ToggleCircle

				ToggleButton.Activated:Connect(function()
					CircleClick(ToggleButton, Mouse.X, Mouse.Y) 
					ToggleFunc.Value = not ToggleFunc.Value
					ToggleFunc:Set(ToggleFunc.Value)
				end)
				function ToggleFunc:Set(Value)
					ToggleConfig.Callback(Value)
					if Value then
						tween:Create(
							ToggleTitle,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
							{TextColor3 = GuiConfig.Color}
						):Play()
						tween:Create(
							ToggleCircle,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
							{Position = UDim2.new(0, 15, 0, 0)}
						):Play()
						tween:Create(
							UIStroke8,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
							{Color = GuiConfig.Color, Transparency = 0}
						):Play()
						tween:Create(
							FeatureFrame2,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
							{BackgroundColor3 = GuiConfig.Color, BackgroundTransparency = 0} 
						):Play()
					else
						tween:Create(
							ToggleTitle,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
							{TextColor3 = Color3.fromRGB(230.77499270439148, 230.77499270439148, 230.77499270439148)}
						):Play()
						tween:Create(
							ToggleCircle,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
							{Position = UDim2.new(0, 0, 0, 0)}
						):Play()
						tween:Create(
							UIStroke8,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
							{Color = Color3.fromRGB(255, 255, 255), Transparency = 0.9}
						):Play()
						tween:Create(
							FeatureFrame2,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
							{BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9200000166893005}
						):Play()
					end
				end
				ToggleFunc:Set(ToggleFunc.Value)
				CountItem = CountItem + 1
				return ToggleFunc
			end
			function itemHandling:TextBox(InputConfig)
				local InputConfig = InputConfig or {}
				InputConfig.Title = InputConfig.Title or "Title"
				InputConfig.Callback = InputConfig.Callback or function() end
				local InputFunc = {Value = ""}

				local Input = Instance.new("Frame");
				local UICorner12 = Instance.new("UICorner");
				local InputTitle = Instance.new("TextLabel");
				local InputFrame = Instance.new("Frame");
				local UICorner13 = Instance.new("UICorner");
				local InputTextBox = Instance.new("TextBox");

				Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Input.BackgroundTransparency = 0.9990000128746033
				Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Input.BorderSizePixel = 0
				Input.LayoutOrder = CountItem
				Input.Size = UDim2.new(1, 0, 0, 46)
				Input.Name = "Input"
				Input.Parent = sectionFrame

				UICorner12.CornerRadius = UDim.new(0, 4)
				UICorner12.Parent = Input

				InputTitle.Font = Enum.Font.GothamBold
				InputTitle.Text = InputConfig.Title
				InputTitle.TextColor3 = Color3.fromRGB(230.77499270439148, 230.77499270439148, 230.77499270439148)
				InputTitle.TextSize = 13
				InputTitle.TextXAlignment = Enum.TextXAlignment.Left
				InputTitle.TextYAlignment = Enum.TextYAlignment.Top
				InputTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InputTitle.BackgroundTransparency = 0.9990000128746033
				InputTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InputTitle.BorderSizePixel = 0
				InputTitle.Position = UDim2.new(0, 10, 0, 10)
				InputTitle.Size = UDim2.new(1, -180, 0, 13)
				InputTitle.Name = "InputTitle"
				InputTitle.Parent = Input

				InputFrame.AnchorPoint = Vector2.new(1, 0.5)
				InputFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InputFrame.BackgroundTransparency = 0.949999988079071
				InputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InputFrame.BorderSizePixel = 0
				InputFrame.ClipsDescendants = true
				InputFrame.Position = UDim2.new(1, -7, 0.5, 0)
				InputFrame.Size = UDim2.new(0, 148, 0, 30)
				InputFrame.Name = "InputFrame"
				InputFrame.Parent = Input

				UICorner13.CornerRadius = UDim.new(0, 4)
				UICorner13.Parent = InputFrame

				InputTextBox.CursorPosition = -1
				InputTextBox.Font = Enum.Font.GothamBold
				InputTextBox.PlaceholderColor3 = Color3.fromRGB(120.00000044703484, 120.00000044703484, 120.00000044703484)
				InputTextBox.PlaceholderText = "Write your input there"
				InputTextBox.Text = ""
				InputTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				InputTextBox.TextSize = 12
				InputTextBox.TextXAlignment = Enum.TextXAlignment.Left
				InputTextBox.AnchorPoint = Vector2.new(0, 0.5)
				InputTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InputTextBox.BackgroundTransparency = 0.9990000128746033
				InputTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InputTextBox.BorderSizePixel = 0
				InputTextBox.Position = UDim2.new(0, 5, 0.5, 0)
				InputTextBox.Size = UDim2.new(1, -10, 1, -8)
				InputTextBox.Name = "InputTextBox"
				InputTextBox.Parent = InputFrame
				function InputFunc:Set(Value)
					InputTextBox.Text = Value
					InputFunc.Value = Value
					InputConfig.Callback(Value)
				end
				InputTextBox.FocusLost:Connect(function()
					InputFunc:Set(InputTextBox.Text)
				end)
				CountItem = CountItem + 1
				return InputFunc
			end

			function itemHandling:Slider(SliderConfig)
				local SliderConfig = SliderConfig or {}
				SliderConfig.Title = SliderConfig.Title or "Slider"
				SliderConfig.Content = SliderConfig.Content or "Content"
				SliderConfig.Increment = SliderConfig.Increment or 1
				SliderConfig.Min = SliderConfig.Min or 0
				SliderConfig.Max = SliderConfig.Max or 100
				SliderConfig.Default = SliderConfig.Default or 50
				SliderConfig.Callback = SliderConfig.Callback or function() end
				local SliderFunc = {Value = SliderConfig.Default}

				local Slider = Instance.new("Frame");
				local UICorner15 = Instance.new("UICorner");
				local SliderTitle = Instance.new("TextLabel");
				local SliderInput = Instance.new("Frame");
				local UICorner16 = Instance.new("UICorner");
				local TextBox = Instance.new("TextBox");
				local SliderFrame = Instance.new("Frame");
				local UICorner17 = Instance.new("UICorner");
				local SliderDraggable = Instance.new("Frame");
				local UICorner18 = Instance.new("UICorner");
				local UIStroke5 = Instance.new("UIStroke");
				local SliderCircle = Instance.new("Frame");
				local UICorner19 = Instance.new("UICorner");
				local UIStroke6 = Instance.new("UIStroke");
				local UIStroke7 = Instance.new("UIStroke");

				Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider.BackgroundTransparency = 0.9990000128746033
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.LayoutOrder = CountItem
				Slider.Size = UDim2.new(1, 0, 0, 46)
				Slider.Name = "Slider"
				Slider.Parent = sectionFrame

				UICorner15.CornerRadius = UDim.new(0, 4)
				UICorner15.Parent = Slider

				SliderTitle.Font = Enum.Font.GothamBold
				SliderTitle.Text = SliderConfig.Title
				SliderTitle.TextColor3 = Color3.fromRGB(230.77499270439148, 230.77499270439148, 230.77499270439148)
				SliderTitle.TextSize = 13
				SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
				SliderTitle.TextYAlignment = Enum.TextYAlignment.Top
				SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderTitle.BackgroundTransparency = 0.9990000128746033
				SliderTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderTitle.BorderSizePixel = 0
				SliderTitle.Position = UDim2.new(0, 10, 0, 10)
				SliderTitle.Size = UDim2.new(1, -180, 0, 13)
				SliderTitle.Name = "SliderTitle"
				SliderTitle.Parent = Slider

				SliderInput.AnchorPoint = Vector2.new(0, 0.5)
				SliderInput.BackgroundColor3 = GuiConfig.Color
				SliderInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderInput.BorderSizePixel = 0
				SliderInput.Position = UDim2.new(1, -155, 0.5, 0)
				SliderInput.Size = UDim2.new(0, 28, 0, 20)
				SliderInput.Name = "SliderInput"
				SliderInput.Parent = Slider

				UICorner16.CornerRadius = UDim.new(0, 2)
				UICorner16.Parent = SliderInput

				TextBox.Font = Enum.Font.GothamBold
				TextBox.Text = "90"
				TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextSize = 13
				TextBox.TextWrapped = true
				TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.BackgroundTransparency = 0.9990000128746033
				TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.BorderSizePixel = 0
				TextBox.Position = UDim2.new(0, -1, 0, 0)
				TextBox.Size = UDim2.new(1, 0, 1, 0)
				TextBox.Parent = SliderInput

				SliderFrame.AnchorPoint = Vector2.new(1, 0.5)
				SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderFrame.BackgroundTransparency = 0.800000011920929
				SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderFrame.BorderSizePixel = 0
				SliderFrame.Position = UDim2.new(1, -20, 0.5, 0)
				SliderFrame.Size = UDim2.new(0, 100, 0, 3)
				SliderFrame.Name = "SliderFrame"
				SliderFrame.Parent = Slider

				UICorner17.Parent = SliderFrame

				SliderDraggable.AnchorPoint = Vector2.new(0, 0.5)
				SliderDraggable.BackgroundColor3 = GuiConfig.Color
				SliderDraggable.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderDraggable.BorderSizePixel = 0
				SliderDraggable.Position = UDim2.new(0, 0, 0.5, 0)
				SliderDraggable.Size = UDim2.new(0.899999976, 0, 0, 1)
				SliderDraggable.Name = "SliderDraggable"
				SliderDraggable.Parent = SliderFrame

				UICorner18.Parent = SliderDraggable

				SliderCircle.AnchorPoint = Vector2.new(1, 0.5)
				SliderCircle.BackgroundColor3 = GuiConfig.Color
				SliderCircle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderCircle.BorderSizePixel = 0
				SliderCircle.Position = UDim2.new(1, 4, 0.5, 0)
				SliderCircle.Size = UDim2.new(0, 8, 0, 8)
				SliderCircle.Name = "SliderCircle"
				SliderCircle.Parent = SliderDraggable

				UICorner19.Parent = SliderCircle

				UIStroke6.Color = GuiConfig.Color
				UIStroke6.Parent = SliderCircle

				local Dragging = false
				local function Round(Number, Factor)
					local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
					if Result < 0 then 
						Result = Result + Factor 
					end
					return Result
				end
				function SliderFunc:Set(Value)
					Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)
					SliderFunc.Value = Value
					TextBox.Text = tostring(Value)
					tween:Create(
						SliderDraggable,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.fromScale((Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 1)}
					):Play()
				end
				SliderFrame.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
						Dragging = true 
					end 
				end)
				SliderFrame.InputEnded:Connect(function(Input) 
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
						Dragging = false 
						SliderConfig.Callback(SliderFunc.Value)
					end 
				end)
				input.InputChanged:Connect(function(Input)
					if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then 
						local SizeScale = math.clamp((Input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
						SliderFunc:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale)) 
					end
				end)
				TextBox:GetPropertyChangedSignal("Text"):Connect(function()
					local Valid = TextBox.Text:gsub("[^%d]", "")
					if Valid ~= "" then
						local ValidNumber = math.min(tonumber(Valid), SliderConfig.Max)
						TextBox.Text = tostring(ValidNumber)
					else
						TextBox.Text = tostring(Valid)
					end
				end)
				TextBox.FocusLost:Connect(function()
					if TextBox.Text ~= "" then
						SliderFunc:Set(tonumber(TextBox.Text))
					else
						SliderFunc:Set(0)
					end
				end)
				SliderFunc:Set(tonumber(SliderConfig.Default))
				CountItem = CountItem + 1
				return SliderFunc
			end

			function itemHandling:Label(txtLabel)
				txtLabel = txtLabel or "nightmare.fun"
				local TextLabel = Instance.new("TextLabel")

				TextLabel.Parent = sectionFrame
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.Position = UDim2.new(0.0390070938, 0, 0.826923072, 0)
				TextLabel.Size = UDim2.new(0, 260, 0, 27)
				TextLabel.Font = Enum.Font.Gotham
				TextLabel.Text = txtLabel
				TextLabel.TextColor3 = Color3.fromRGB(198, 198, 198)
				TextLabel.TextSize = 14.000
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			end

			function itemHandling:KeyBind(bindInfo, first, callback)
				bindInfo = bindInfo or "Press the Key"
				local oldKey = first.Name
				callback = callback or function() end

				local keybindFrame = Instance.new("Frame")
				local UIListLayout = Instance.new("UIListLayout")
				local keybindBtn = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local TextLabel = Instance.new("TextLabel")

				keybindFrame.Name = "keybindFrame"
				keybindFrame.Parent = sectionFrame
				keybindFrame.BackgroundColor3 = Color3.fromRGB(43, 43, 52)
				keybindFrame.BackgroundTransparency = 1.000
				keybindFrame.Position = UDim2.new(0.0354609936, 0, 0.344827592, 0)
				keybindFrame.Size = UDim2.new(0, 262, 0, 33)

				UIListLayout.Parent = keybindFrame
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 3)

				keybindBtn.Name = "keybindBtn"
				keybindBtn.Parent = keybindFrame
				keybindBtn.BackgroundColor3 = Color3.fromRGB(43, 43, 52)
				keybindBtn.Position = UDim2.new(0, 0, 0.106060609, 0)
				keybindBtn.Size = UDim2.new(0, 107, 0, 26)
				keybindBtn.AutoButtonColor = false
				keybindBtn.Font = Enum.Font.GothamBold
				keybindBtn.Text = oldKey
				keybindBtn.TextColor3 = Color3.fromRGB(204, 204, 204)
				keybindBtn.TextSize = 14.000

				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = keybindBtn

				TextLabel.Parent = keybindFrame
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.Position = UDim2.new(0.408396959, 0, 0.893939376, 0)
				TextLabel.Size = UDim2.new(0, 155, 0, 12)
				TextLabel.Font = Enum.Font.Gotham
				TextLabel.Text = "KeyBind"
				TextLabel.TextColor3 = GuiConfig.Color
				TextLabel.TextSize = 14.000
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left

				keybindBtn.MouseButton1Click:connect(function(e) 
					keybindBtn.Text = ". . ."
					local a, b = game:GetService('UserInputService').InputBegan:wait();
					if a.KeyCode.Name ~= "Unknown" then
						keybindBtn.Text = a.KeyCode.Name
						oldKey = a.KeyCode.Name;
					end
				end)

				game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
					if not ok then 
						if current.KeyCode.Name == oldKey then 
							callback()
						end
					end
				end)
			end

			function itemHandling:Dropdown(dropInfo, list, callback)
				dropInfo = dropInfo or 'Favorite Hub'
				list = list or {}
				callback = callback or function() end

				local DropYSize = 28
				local dropped = false

				local dropdownFrame = Instance.new("Frame")
				local dropdownFrameHeader = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local dropdowninfo = Instance.new("TextLabel")
				local closeDropdown = Instance.new("ImageButton")
				local dropcover = Instance.new("Frame")
				local dropListing = Instance.new("UIListLayout")
				local dropdownCorner = Instance.new("UICorner")

				dropdownFrame.Name = "dropdownFrame"
				dropdownFrame.Parent = sectionFrame
				dropdownFrame.BackgroundColor3 = Color3.fromRGB(48, 48, 58)
				dropdownFrame.ClipsDescendants = true
				dropdownFrame.Position = UDim2.new(0.0354609936, 0, 0.495833337, 0)
				dropdownFrame.Size = UDim2.new(0, 262, 0, 28)

				dropdownFrameHeader.Name = "dropdownFrameHeader"
				dropdownFrameHeader.Parent = dropdownFrame
				dropdownFrameHeader.BackgroundColor3 = GuiConfig.Color
				dropdownFrameHeader.Size = UDim2.new(0, 262, 0, 28)

				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = dropdownFrameHeader

				dropdowninfo.Name = "dropdowninfo"
				dropdowninfo.Parent = dropdownFrameHeader
				dropdowninfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				dropdowninfo.BackgroundTransparency = 1.000
				dropdowninfo.Position = UDim2.new(0.0267175566, 0, 0, 0)
				dropdowninfo.Size = UDim2.new(0, 197, 0, 28)
				dropdowninfo.Font = Enum.Font.Gotham
				dropdowninfo.Text = dropInfo
				dropdowninfo.TextColor3 = Color3.fromRGB(255, 255, 255)
				dropdowninfo.TextSize = 15.000
				dropdowninfo.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
				dropdowninfo.TextXAlignment = Enum.TextXAlignment.Left

				closeDropdown.Name = "closeDropdown"
				closeDropdown.Parent = dropdownFrameHeader
				closeDropdown.BackgroundTransparency = 1.000
				closeDropdown.Position = UDim2.new(0.8823663, 0, 0.0857142881, 0)
				closeDropdown.Size = UDim2.new(0, 25, 0, 25)
				closeDropdown.ZIndex = 2
				closeDropdown.Image = "rbxassetid://3926305904"
				closeDropdown.ImageRectOffset = Vector2.new(404, 284)
				closeDropdown.ImageRectSize = Vector2.new(36, 36)
				closeDropdown.MouseButton1Click:Connect(function()
					if dropped then
						dropped = false
						dropdownFrame:TweenSize(UDim2.new(0, 262, 0, 28), 'InOut', 'Linear', 0.08)
						game.TweenService:Create(closeDropdown, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Rotation = 0
						}):Play()
						wait(0.1)
						sectionFrame:TweenSize(UDim2.new(0.956,0, 0, sectionListLayout.AbsoluteContentSize.Y + 8), "InOut", "Linear", 0.1)
						wait(0.1)
						game.TweenService:Create(dropcover, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							BackgroundTransparency = 1
						}):Play()
						wait(0.1)
						UpdateSize()
					else
						dropped = true
						dropdownFrame:TweenSize(UDim2.new(0, 262, 0, DropYSize), 'InOut', 'Linear', 0.08)
						game.TweenService:Create(closeDropdown, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Rotation = 180
						}):Play()
						wait(0.1)
						sectionFrame:TweenSize(UDim2.new(0.956,0, 0, sectionListLayout.AbsoluteContentSize.Y + 8), "InOut", "Linear", 0.1)
						wait(0.1)
						game.TweenService:Create(dropcover, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							BackgroundTransparency = 0
						}):Play()
						wait(0.1)
						UpdateSize()
					end
				end)

				dropcover.Name = "dropcover"
				dropcover.Parent = dropdownFrameHeader
				dropcover.BackgroundColor3 = GuiConfig.Color
				dropcover.BackgroundTransparency = 1.000
				dropcover.BorderSizePixel = 0
				dropcover.Position = UDim2.new(0, 0, 0.850000024, 0)
				dropcover.Size = UDim2.new(0, 262, 0, 5)

				dropListing.Name = "dropListing"
				dropListing.Parent = dropdownFrame
				dropListing.HorizontalAlignment = Enum.HorizontalAlignment.Center
				dropListing.SortOrder = Enum.SortOrder.LayoutOrder
				dropListing.Padding = UDim.new(0, 4)

				dropdownCorner.CornerRadius = UDim.new(0, 5)
				dropdownCorner.Name = "dropdownCorner"
				dropdownCorner.Parent = dropdownFrame

				for i,v in next, list do
					local dropdownButton = Instance.new("Frame")
					local UIListLayout = Instance.new("UIListLayout")
					local optionButton = Instance.new("TextButton")
					local optionCorner = Instance.new("UICorner")

					dropdownButton.Name = "dropdownButton"
					dropdownButton.Parent = dropdownFrame
					dropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					dropdownButton.BackgroundTransparency = 1.000
					dropdownButton.Position = UDim2.new(0, 0, 0.284552842, 0)
					dropdownButton.Size = UDim2.new(0, 251, 0, 28)

					UIListLayout.Parent = dropdownButton
					UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
					UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

					DropYSize = DropYSize + 33
					optionButton.Name = "optionButton"
					optionButton.Parent = dropdownButton
					optionButton.BackgroundColor3 = GuiConfig.Color
					optionButton.BorderSizePixel = 0
					optionButton.Position = UDim2.new(0.0667938963, 0, -0.418119699, 0)
					optionButton.Size = UDim2.new(0, 251, 0, 28)
					optionButton.AutoButtonColor = false
					optionButton.Font = Enum.Font.Gotham
					optionButton.Text = "  "..v
					optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					optionButton.TextSize = 14.000
					optionButton.TextXAlignment = Enum.TextXAlignment.Left
					optionButton.MouseButton1Click:Connect(function()
						dropped = false
						dropdowninfo.Text = v
						callback(v)
						dropdownFrame:TweenSize(UDim2.new(0, 262, 0, 28), 'InOut', 'Linear', 0.08)
						game.TweenService:Create(closeDropdown, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Rotation = 0
						}):Play()
						wait(0.1)
						sectionFrame:TweenSize(UDim2.new(0.956,0, 0, sectionListLayout.AbsoluteContentSize.Y + 8), "InOut", "Linear", 0.1)
						wait(0.1)
						game.TweenService:Create(dropcover, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							BackgroundTransparency = 1
						}):Play()
						wait(0.1)
						UpdateSize()
					end)

					optionButton.MouseButton1Down:Connect(function()
						game.TweenService:Create(optionButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Size = UDim2.new(0, 235,0, 26)
						}):Play()
					end)
					optionButton.MouseButton1Up:Connect(function()
						game.TweenService:Create(optionButton, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Size = UDim2.new(0, 251,0, 28)
						}):Play()
					end)

					optionCorner.CornerRadius = UDim.new(0, 5)
					optionCorner.Name = "optionCorner"
					optionCorner.Parent = optionButton
				end 
			end
			return itemHandling
		end
		return sectionHandling
	end
	return Tabs
end
return ArcHub