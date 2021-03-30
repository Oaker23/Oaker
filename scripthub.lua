do
	local ui = game:GetService("CoreGui"):FindFirstChild("FluxLib")
	if ui then
		ui:Destroy()
	end
end

local Flux = {RainbowColorValue = 0, HueSelectionPosition = 0}
local PresetColor = Color3.fromRGB(66, 134, 255)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CloseBind = Enum.KeyCode.RightControl

local FluxLib = Instance.new("ScreenGui")
FluxLib.Name = "FluxLib"
FluxLib.Parent = game.CoreGui
FluxLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

coroutine.wrap(
	function()
		while wait() do
			Flux.RainbowColorValue = Flux.RainbowColorValue + 1 / 255
			Flux.HueSelectionPosition = Flux.HueSelectionPosition + 1

			if Flux.RainbowColorValue >= 1 then
				Flux.RainbowColorValue = 0
			end

			if Flux.HueSelectionPosition == 80 then
				Flux.HueSelectionPosition = 0
			end
		end
	end
)()

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		object.Position = pos
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

function Flux:Destroy()
FluxLib:Destroy()
end

function Flux:Window(text, bottom,mainclr,toclose)
	CloseBind = toclose or Enum.KeyCode.RightControl
	PresetColor = mainclr or Color3.fromRGB(66, 134, 255)
	local fs = false
	local MainFrame = Instance.new("Frame")
	local MainCorner = Instance.new("UICorner")
	local LeftFrame = Instance.new("Frame")
	local LeftCorner = Instance.new("UICorner")
	local GlowTabHolder = Instance.new("ImageLabel")
	local Title = Instance.new("TextLabel")
	local BottomText = Instance.new("TextLabel")
	local TabHold = Instance.new("Frame")
	local TabLayout = Instance.new("UIListLayout")
	local Drag = Instance.new("Frame")
	local ContainerFolder = Instance.new("Folder")

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = FluxLib
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(50, 53, 59)
	MainFrame.ClipsDescendants = true
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.Size = UDim2.new(0, 0, 0, 0)

	MainCorner.CornerRadius = UDim.new(0, 5)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = MainFrame

	LeftFrame.Name = "LeftFrame"
	LeftFrame.Parent = MainFrame
	LeftFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
	LeftFrame.Size = UDim2.new(0, 205, 0, 484)

	LeftCorner.CornerRadius = UDim.new(0, 5)
	LeftCorner.Name = "LeftCorner"
	LeftCorner.Parent = LeftFrame

	GlowTabHolder.Name = "GlowTabHolder"
	GlowTabHolder.Parent = LeftFrame
	GlowTabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GlowTabHolder.BackgroundTransparency = 1.000
	GlowTabHolder.BorderSizePixel = 0
	GlowTabHolder.Position = UDim2.new(0, -15, 0, -15)
	GlowTabHolder.Size = UDim2.new(1, 30, 1, 30)
	GlowTabHolder.ZIndex = 0
	GlowTabHolder.Image = "rbxassetid://4996891970"
	GlowTabHolder.ImageColor3 = Color3.fromRGB(15, 15, 15)
	GlowTabHolder.ScaleType = Enum.ScaleType.Slice
	GlowTabHolder.SliceCenter = Rect.new(20, 20, 280, 280)

	Title.Name = "Title"
	Title.Parent = LeftFrame
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.0926829204, 0, 0.0371900871, 0)
	Title.Size = UDim2.new(0, 111, 0, 34)
	Title.Font = Enum.Font.GothamBold
	Title.Text = text
	Title.TextColor3 = mainclr
	Title.TextSize = 25.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	BottomText.Name = "BottomText"
	BottomText.Parent = LeftFrame
	BottomText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BottomText.BackgroundTransparency = 1.000
	BottomText.Position = UDim2.new(0.126829267, 0, 0.0889999792, 0)
	BottomText.Size = UDim2.new(0, 113, 0, 28)
	BottomText.Font = Enum.Font.Gotham
	BottomText.Text = bottom
	BottomText.TextColor3 = Color3.fromRGB(255, 255, 255)
	BottomText.TextSize = 14.000
	BottomText.TextTransparency = 0.300
	BottomText.TextXAlignment = Enum.TextXAlignment.Left

	TabHold.Name = "TabHold"
	TabHold.Parent = LeftFrame
	TabHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabHold.BackgroundTransparency = 1.000
	TabHold.Position = UDim2.new(0, 0, 0.167355374, 0)
	TabHold.Size = UDim2.new(0, 205, 0, 403)

	TabLayout.Name = "TabLayout"
	TabLayout.Parent = TabHold
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 3)

	Drag.Name = "Drag"
	Drag.Parent = MainFrame
	Drag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Drag.BackgroundTransparency = 1.000
	Drag.Position = UDim2.new(0.290368259, 0, 0, 0)
	Drag.Size = UDim2.new(0, 501, 0, 23)

	ContainerFolder.Name = "ContainerFolder"
	ContainerFolder.Parent = MainFrame
	
	MakeDraggable(Drag,MainFrame)
	MakeDraggable(LeftFrame,MainFrame)
	MainFrame:TweenSize(UDim2.new(0, 706, 0, 484), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
	
	local uitoggled = false
	UserInputService.InputBegan:Connect(
		function(io, p)
			if io.KeyCode == CloseBind then
				if uitoggled == false then
					uitoggled = true
					FluxLib.Enabled = false
				else
					FluxLib.Enabled = true
					uitoggled = false
				end
			end
		end
	)
	
	function Flux:Notification(desc,buttontitle)
		for i, v in next, MainFrame:GetChildren() do
			if v.Name == "NotificationBase" then
				v:Destroy()
			end
		end
		local NotificationBase = Instance.new("TextButton")
		local NotificationBaseCorner = Instance.new("UICorner")
		local NotificationFrame = Instance.new("Frame")
		local NotificationFrameCorner = Instance.new("UICorner")
		local NotificationFrameGlow = Instance.new("ImageLabel")
		local NotificationTitle = Instance.new("TextLabel")
		local CloseBtn = Instance.new("TextButton")
		local CloseBtnCorner = Instance.new("UICorner")
		local NotificationDesc = Instance.new("TextLabel")

		NotificationBase.Name = "NotificationBase"
		NotificationBase.Parent = MainFrame
		NotificationBase.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		NotificationBase.BackgroundTransparency = 1
		NotificationBase.Size = UDim2.new(0, 706, 0, 484)
		NotificationBase.AutoButtonColor = false
		NotificationBase.Font = Enum.Font.SourceSans
		NotificationBase.Text = ""
		NotificationBase.TextColor3 = Color3.fromRGB(0, 0, 0)
		NotificationBase.TextSize = 14.000
		NotificationBase.Visible = true

		NotificationBaseCorner.CornerRadius = UDim.new(0, 5)
		NotificationBaseCorner.Name = "NotificationBaseCorner"
		NotificationBaseCorner.Parent = NotificationBase

		NotificationFrame.Name = "NotificationFrame"
		NotificationFrame.Parent = NotificationBase
		NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		NotificationFrame.BackgroundColor3 = Color3.fromRGB(50, 53, 59)
		NotificationFrame.ClipsDescendants = true
		NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		NotificationFrame.Size = UDim2.new(0, 0, 0, 0)

		NotificationFrameCorner.CornerRadius = UDim.new(0, 5)
		NotificationFrameCorner.Name = "NotificationFrameCorner"
		NotificationFrameCorner.Parent = NotificationFrame

		NotificationFrameGlow.Name = "NotificationFrameGlow"
		NotificationFrameGlow.Parent = NotificationFrame
		NotificationFrameGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotificationFrameGlow.BackgroundTransparency = 1.000
		NotificationFrameGlow.BorderSizePixel = 0
		NotificationFrameGlow.Position = UDim2.new(0, -15, 0, -15)
		NotificationFrameGlow.Size = UDim2.new(1, 30, 1, 30)
		NotificationFrameGlow.ZIndex = 0
		NotificationFrameGlow.Image = "rbxassetid://4996891970"
		NotificationFrameGlow.ImageColor3 = Color3.fromRGB(15, 15, 15)
		NotificationFrameGlow.ScaleType = Enum.ScaleType.Slice
		NotificationFrameGlow.SliceCenter = Rect.new(20, 20, 280, 280)

		NotificationTitle.Name = "NotificationTitle"
		NotificationTitle.Parent = NotificationFrame
		NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotificationTitle.BackgroundTransparency = 1.000
		NotificationTitle.Position = UDim2.new(0.0400609747, 0, 0.0761325806, 0)
		NotificationTitle.Size = UDim2.new(0, 111, 0, 34)
		NotificationTitle.Font = Enum.Font.GothamBold
		NotificationTitle.Text = Title.Text .. " | NOTIFICATION"
		NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotificationTitle.TextSize = 24.000
		NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
		NotificationTitle.TextTransparency = 1

		CloseBtn.Name = "CloseBtn"
		CloseBtn.Parent = NotificationFrame
		CloseBtn.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
		CloseBtn.ClipsDescendants = true
		CloseBtn.Position = UDim2.new(0.0403124988, 0, 0.720855951, 0)
		CloseBtn.Size = UDim2.new(0, 366, 0, 43)
		CloseBtn.AutoButtonColor = false
		CloseBtn.Font = Enum.Font.Gotham
		CloseBtn.Text = buttontitle
		CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		CloseBtn.TextSize = 15.000
		CloseBtn.TextTransparency = 1
		CloseBtn.BackgroundTransparency = 1

		CloseBtnCorner.CornerRadius = UDim.new(0, 4)
		CloseBtnCorner.Name = "CloseBtnCorner"
		CloseBtnCorner.Parent = CloseBtn

		NotificationDesc.Name = "NotificationDesc"
		NotificationDesc.Parent = NotificationFrame
		NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotificationDesc.BackgroundTransparency = 1.000
		NotificationDesc.Position = UDim2.new(0.112499997, 0, 0.266355127, 0)
		NotificationDesc.Size = UDim2.new(0, 309, 0, 82)
		NotificationDesc.Font = Enum.Font.Gotham
		NotificationDesc.Text = desc
		NotificationDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotificationDesc.TextSize = 15.000
		NotificationDesc.TextWrapped = true
		NotificationDesc.TextTransparency = 1
		
		CloseBtn.MouseEnter:Connect(function()
			TweenService:Create(
				CloseBtn,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 0}
			):Play()
		end)

		CloseBtn.MouseLeave:Connect(function()
			TweenService:Create(
				CloseBtn,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 0.3}
			):Play()
		end)
		
		CloseBtn.MouseButton1Click:Connect(function()
			
			TweenService:Create(
				NotificationDesc,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 1}
			):Play()
			TweenService:Create(
				CloseBtn,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 1}
			):Play()
			TweenService:Create(
				NotificationTitle,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 1}
			):Play()
			TweenService:Create(
				CloseBtn,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			
			wait(.4)
			CloseBtn.Visible = false
			NotificationFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

			wait(.2)
			
			TweenService:Create(
				NotificationBase,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			
			wait(.2)
			
			NotificationBase.Visible = false
		end)

		
		TweenService:Create(
			NotificationBase,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0.550}
		):Play()
		
		wait(.1)
		
		NotificationFrame:TweenSize(UDim2.new(0, 400, 0, 214), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
		
		wait(.4)
		TweenService:Create(
			NotificationDesc,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{TextTransparency = .3}
		):Play()
		TweenService:Create(
			CloseBtn,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{TextTransparency = .3}
		):Play()
		TweenService:Create(
			NotificationTitle,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{TextTransparency = 0}
		):Play()
		TweenService:Create(
			CloseBtn,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0}
		):Play()
	end
	local Tabs = {}
	function Tabs:Tab(text,ico)
		local Tab = Instance.new("TextButton")
		local TabIcon = Instance.new("ImageLabel")
		local TabTitle = Instance.new("TextLabel")

		Tab.Name = "Tab"
		Tab.Parent = TabHold
		Tab.BackgroundColor3 = PresetColor
		Tab.BorderSizePixel = 0
		Tab.Size = UDim2.new(0, 205, 0, 40)
		Tab.AutoButtonColor = false
		Tab.Font = Enum.Font.SourceSans
		Tab.Text = ""
		Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
		Tab.TextSize = 14.000
		Tab.BackgroundTransparency = 1

		TabIcon.Name = "TabIcon"
		TabIcon.Parent = Tab
		TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabIcon.BackgroundTransparency = 1.000
		TabIcon.Position = UDim2.new(0.0634146333, 0, 0.25, 0)
		TabIcon.Size = UDim2.new(0, 20, 0, 20)
		TabIcon.Image = ico
		TabIcon.ImageTransparency = .3

		TabTitle.Name = "TabTitle"
		TabTitle.Parent = Tab
		TabTitle.BackgroundColor3 = Color3.fromRGB(98, 155, 162)
		TabTitle.BackgroundTransparency = 1.000
		TabTitle.Position = UDim2.new(0.1902439, 0, 0.25, 0)
		TabTitle.Size = UDim2.new(0, 113, 0, 19)
		TabTitle.Font = Enum.Font.Gotham
		TabTitle.Text = text
		TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabTitle.TextSize = 15.000
		TabTitle.TextXAlignment = Enum.TextXAlignment.Left
		TabTitle.TextTransparency = .3
		
		local Container = Instance.new("ScrollingFrame")
		local ContainerLayout = Instance.new("UIListLayout")


		Container.Name = "Container"
		Container.Parent = ContainerFolder
		Container.Active = true
		Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Container.BackgroundTransparency = 1.000
		Container.BorderSizePixel = 0
		Container.Position = UDim2.new(0.321529746, 0, 0.0475206599, 0)
		Container.Size = UDim2.new(0, 470, 0, 438)
		Container.CanvasSize = UDim2.new(0, 0, 0, 0)
		Container.ScrollBarThickness = 5
		Container.Visible = false
		Container.ScrollBarImageColor3 = Color3.fromRGB(71, 76, 84)

		ContainerLayout.Name = "ContainerLayout"
		ContainerLayout.Parent = Container
		ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContainerLayout.Padding = UDim.new(0, 15)
		
		if fs == false then
			fs = true
			TabTitle.TextTransparency = 0
			TabIcon.ImageTransparency = 0
			Tab.BackgroundTransparency = 0
			Container.Visible = true
		end
		
		Tab.MouseButton1Click:Connect(function()
			for i, v in next, ContainerFolder:GetChildren() do
				if v.Name == "Container" then
					v.Visible = false
				end
				Container.Visible = true
			end
			for i, v in next, TabHold:GetChildren() do
				if v.Name == "Tab" then
					TweenService:Create(
						v,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						v.TabIcon,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						v.TabTitle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = .3}
					):Play()
					TweenService:Create(
						Tab,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						TabIcon,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						TabTitle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end
			end
		end)
		local ContainerContent = {}
		function ContainerContent:Button(text, desc, callback)
			if desc == "" then
				desc = "There is no description for this button."
			end
			local BtnDescToggled = false
			local Button = Instance.new("TextButton")
			local ButtonCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local Description = Instance.new("TextLabel")
			local ArrowBtn = Instance.new("ImageButton")
			local ArrowIco = Instance.new("ImageLabel")

			Button.Name = "Button"
			Button.Parent = Container
			Button.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
			Button.ClipsDescendants = true
			Button.Position = UDim2.new(0.370312512, 0, 0.552631557, 0)
			Button.Size = UDim2.new(0, 457, 0, 43)
			Button.AutoButtonColor = false
			Button.Font = Enum.Font.SourceSans
			Button.Text = ""
			Button.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button.TextSize = 14.000

			ButtonCorner.CornerRadius = UDim.new(0, 4)
			ButtonCorner.Name = "ButtonCorner"
			ButtonCorner.Parent = Button

			Title.Name = "Title"
			Title.Parent = Button
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(254, 165, 107)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(254, 165, 107)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			Description.Name = "Description"
			Description.Parent = Title
			Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description.BackgroundTransparency = 1.000
			Description.Position = UDim2.new(-0.200942323, 0, 0.785714269, 0)
			Description.Size = UDim2.new(0, 432, 0, 31)
			Description.Font = Enum.Font.Gotham
			Description.Text = desc
			Description.TextColor3 = Color3.fromRGB(255, 255, 255)
			Description.TextSize = 15.000
			Description.TextTransparency = 1
			Description.TextWrapped = true
			Description.TextXAlignment = Enum.TextXAlignment.Left

			ArrowBtn.Name = "ArrowBtn"
			ArrowBtn.Parent = Button
			ArrowBtn.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
			ArrowBtn.BackgroundTransparency = 1.000
			ArrowBtn.Position = UDim2.new(0.903719902, 0, 0, 0)
			ArrowBtn.Size = UDim2.new(0, 33, 0, 37)
			ArrowBtn.SliceCenter = Rect.new(30, 30, 30, 30)
			ArrowBtn.SliceScale = 7.000

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = ArrowBtn
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(0.495753437, 0, 0.554054081, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6034818372"
			ArrowIco.ImageTransparency = .3
			
			Button.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)
			
			Button.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)
			
			Button.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
			
			ArrowBtn.MouseButton1Click:Connect(function()
				if BtnDescToggled == false then
					Button:TweenSize(UDim2.new(0, 457, 0, 74), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Button:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				BtnDescToggled = not BtnDescToggled
			end)
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		function ContainerContent:Toggle(text, desc,default, callback)
			local ToggleDescToggled = false
			local Toggled = false
			if desc == "" then
				desc = "There is no description for this toggle."
			end
			local Toggle = Instance.new("TextButton")
			local ToggleCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local ToggleFrame = Instance.new("Frame")
			local ToggleFrameCorner = Instance.new("UICorner")
			local ToggleCircle = Instance.new("Frame")
			local ToggleCircleCorner = Instance.new("UICorner")
			local Description = Instance.new("TextLabel")
			local ArrowBtn = Instance.new("ImageButton")
			local ArrowIco = Instance.new("ImageLabel")

			Toggle.Name = "Toggle"
			Toggle.Parent = Container
			Toggle.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
			Toggle.ClipsDescendants = true
			Toggle.Position = UDim2.new(0.110937506, 0, 0.67653507, 0)
			Toggle.Size = UDim2.new(0, 457, 0, 43)
			Toggle.AutoButtonColor = false
			Toggle.Font = Enum.Font.SourceSans
			Toggle.Text = ""
			Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.TextSize = 14.000

			ToggleCorner.CornerRadius = UDim.new(0, 4)
			ToggleCorner.Name = "ToggleCorner"
			ToggleCorner.Parent = Toggle

			Title.Name = "Title"
			Title.Parent = Toggle
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(254, 165, 107)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(254, 165, 107)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.Parent = Circle
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(226, 227, 227)
			ToggleFrame.Position = UDim2.new(33.0856934, 0, 0, 0)
			ToggleFrame.Size = UDim2.new(0, 27, 0, 11)

			ToggleFrameCorner.Name = "ToggleFrameCorner"
			ToggleFrameCorner.Parent = ToggleFrame

			ToggleCircle.Name = "ToggleCircle"
			ToggleCircle.Parent = ToggleFrame
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(254, 165, 107)
			ToggleCircle.Position = UDim2.new(0, 0, -0.272727281, 0)
			ToggleCircle.Selectable = true
			ToggleCircle.Size = UDim2.new(0, 17, 0, 17)

			ToggleCircleCorner.CornerRadius = UDim.new(2, 8)
			ToggleCircleCorner.Name = "ToggleCircleCorner"
			ToggleCircleCorner.Parent = ToggleCircle

			Description.Name = "Description"
			Description.Parent = Title
			Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description.BackgroundTransparency = 1.000
			Description.Position = UDim2.new(-0.200942323, 0, 0.785714269, 0)
			Description.Size = UDim2.new(0, 432, 0, 31)
			Description.Font = Enum.Font.Gotham
			Description.Text = desc
			Description.TextColor3 = Color3.fromRGB(255, 255, 255)
			Description.TextSize = 15.000
			Description.TextTransparency = 1
			Description.TextWrapped = true
			Description.TextXAlignment = Enum.TextXAlignment.Left

			ArrowBtn.Name = "ArrowBtn"
			ArrowBtn.Parent = Toggle
			ArrowBtn.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
			ArrowBtn.BackgroundTransparency = 1.000
			ArrowBtn.Position = UDim2.new(0.903719902, 0, 0, 0)
			ArrowBtn.Size = UDim2.new(0, 33, 0, 37)
			ArrowBtn.SliceCenter = Rect.new(30, 30, 30, 30)
			ArrowBtn.SliceScale = 7.000

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = ArrowBtn
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(0.495753437, 0, 0.554054081, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6034818372"
			ArrowIco.ImageTransparency = .3
			
		    Toggle.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)

			Toggle.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)

			Toggle.MouseButton1Click:Connect(function()
				if Toggled == false then
					ToggleCircle:TweenPosition(UDim2.new(0.37, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
					TweenService:Create(
						ToggleCircle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =PresetColor}
					):Play()
				else
					ToggleCircle:TweenPosition(UDim2.new(0, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
					TweenService:Create(
						ToggleCircle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
				end
				Toggled = not Toggled
				pcall(callback, Toggled)
			end)
			
			ArrowBtn.MouseButton1Click:Connect(function()
				if ToggleDescToggled == false then
					Toggle:TweenSize(UDim2.new(0, 457, 0, 74), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Toggle:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				ToggleDescToggled = not ToggleDescToggled
			end)
			if default == true then
				ToggleCircle:TweenPosition(UDim2.new(0.37, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
				TweenService:Create(
					ToggleCircle,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundColor3 =PresetColor}
				):Play()
				Toggled = not Toggled
				pcall(callback, Toggled)
			end
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		
		function ContainerContent:Slider(text,desc,min,max,start,callback)
			local SliderFunc = {}
                        local dragging = false
			local SliderDescToggled = false
			if desc == "" then
				desc = "There is no description for this slider."
			end
			local Slider = Instance.new("TextButton")
			local SliderCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local Description = Instance.new("TextLabel")
			local SlideFrame = Instance.new("Frame")
			local CurrentValueFrame = Instance.new("Frame")
			local SlideCircle = Instance.new("ImageButton")
			local ArrowBtn = Instance.new("ImageButton")
			local ArrowIco = Instance.new("ImageLabel")
			local Value = Instance.new("TextLabel")

			Slider.Name = "Slider"
			Slider.Parent = Container
			Slider.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Slider.ClipsDescendants = true
			Slider.Position = UDim2.new(0.189062506, 0, 0.648612201, 0)
			Slider.Size = UDim2.new(0, 457, 0, 60)
			Slider.AutoButtonColor = false
			Slider.Font = Enum.Font.SourceSans
			Slider.Text = ""
			Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
			Slider.TextSize = 14.000

			SliderCorner.CornerRadius = UDim.new(0, 4)
			SliderCorner.Name = "SliderCorner"
			SliderCorner.Parent = Slider

			Title.Name = "Title"
			Title.Parent = Slider
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(254, 165, 107)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)


			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(254, 165, 107)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			Description.Name = "Description"
			Description.Parent = Title
			Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description.BackgroundTransparency = 1.000
			Description.Position = UDim2.new(-0.201000005, 0, 1.38600004, 0)
			Description.Size = UDim2.new(0, 432, 0, 31)
			Description.Font = Enum.Font.Gotham
			Description.Text = desc
			Description.TextColor3 = Color3.fromRGB(255, 255, 255)
			Description.TextSize = 15.000
			Description.TextTransparency = 0.300
			Description.TextWrapped = true
			Description.TextXAlignment = Enum.TextXAlignment.Left

			SlideFrame.Name = "SlideFrame"
			SlideFrame.Parent = Title
			SlideFrame.BackgroundColor3 = Color3.fromRGB(235, 234, 235)
			SlideFrame.BorderSizePixel = 0
			SlideFrame.Position = UDim2.new(-0.197140202, 0, 0.986091495, 0)
			SlideFrame.Size = UDim2.new(0, 426, 0, 3)

			CurrentValueFrame.Name = "CurrentValueFrame"
			CurrentValueFrame.Parent = SlideFrame
			CurrentValueFrame.BackgroundColor3 = PresetColor
			CurrentValueFrame.BorderSizePixel = 0
			CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 3)

			SlideCircle.Name = "SlideCircle"
			SlideCircle.Parent = SlideFrame
			SlideCircle.BackgroundColor3 = Color3.fromRGB(110, 200, 170)
			SlideCircle.BackgroundTransparency = 1.000
			SlideCircle.Position = UDim2.new((start or 0)/max, -6,-1.30499995, 0)
			SlideCircle.Size = UDim2.new(0, 11, 0, 11)
			SlideCircle.Image = "rbxassetid://3570695787"
			SlideCircle.ImageColor3 = PresetColor

			ArrowBtn.Name = "ArrowBtn"
			ArrowBtn.Parent = Slider
			ArrowBtn.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
			ArrowBtn.BackgroundTransparency = 1.000
			ArrowBtn.Position = UDim2.new(0.903719902, 0, 0, 0)
			ArrowBtn.Size = UDim2.new(0, 33, 0, 37)
			ArrowBtn.SliceCenter = Rect.new(30, 30, 30, 30)
			ArrowBtn.SliceScale = 7.000

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = ArrowBtn
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(0.495753437, 0, 0.554054081, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6034818372"
			ArrowIco.ImageTransparency = .3

			Value.Name = "Value"
			Value.Parent = Title
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1.000
			Value.Position = UDim2.new(2.27693367, 0, 0, 0)
			Value.Size = UDim2.new(0, 113, 0, 41)
			Value.Font = Enum.Font.Gotham
			Value.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = 15.000
			Value.TextTransparency = 0.300
			Value.TextXAlignment = Enum.TextXAlignment.Right
			
			ArrowBtn.MouseButton1Click:Connect(function()
				if SliderDescToggled == false then
					Slider:TweenSize(UDim2.new(0, 457, 0, 101), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						Value,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Slider:TweenSize(UDim2.new(0, 457, 0, 60), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						Value,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				SliderDescToggled = not SliderDescToggled
			end)
			
				local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
							-6,
						-1.30499995,
							0
						)
					local pos1 =
						UDim2.new(
							math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
							0,
							0,
							3
						)
					CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
					SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
					local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
					Value.Text = tostring(value)
					pcall(callback, value)
				end
				SlideCircle.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true
						end
					end
				)
				SlideCircle.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false
						end
					end
				)
				game:GetService("UserInputService").InputChanged:Connect(
				function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
				end
				)
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
			function SliderFunc:Change(tochange)
				CurrentValueFrame.Size = UDim2.new((tochange or 0) / max, 0, 0, 3)
				SlideCircle.Position = UDim2.new((tochange or 0)/max, -6,-1.30499995, 0)
				Value.Text = tostring(tochange and math.floor((tochange / max) * (max - min) + min) or 0)
				pcall(callback,tochange)
			end
			return SliderFunc
		end
		function ContainerContent:Dropdown(text,list,callback)
			local DropFunc = {}
			local Selected = text
			local OldSelected = text
			local FrameSize = 43
			local ItemCount = 0
			local DropToggled = false
			local Dropdown = Instance.new("TextButton")
			local DropdownCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local ArrowIco = Instance.new("ImageLabel")
			local DropItemHolder = Instance.new("ScrollingFrame")
			local DropLayout = Instance.new("UIListLayout")

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = Container
			Dropdown.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
			Dropdown.ClipsDescendants = true
			Dropdown.Position = UDim2.new(0.110937499, 0, 0.67653507, 0)
			Dropdown.Size = UDim2.new(0, 457, 0, 43)
			Dropdown.AutoButtonColor = false
			Dropdown.Font = Enum.Font.SourceSans
			Dropdown.Text = ""
			Dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.TextSize = 14.000

			DropdownCorner.CornerRadius = UDim.new(0, 4)
			DropdownCorner.Name = "DropdownCorner"
			DropdownCorner.Parent = Dropdown

			Title.Name = "Title"
			Title.Parent = Dropdown
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(254, 165, 107)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(254, 165, 107)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = Title
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(3.45979357, 0, 0.508096159, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6035047377"
			ArrowIco.ImageTransparency = .3

			DropItemHolder.Name = "DropItemHolder"
			DropItemHolder.Parent = Title
			DropItemHolder.Active = true
			DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropItemHolder.BackgroundTransparency = 1.000
			DropItemHolder.BorderSizePixel = 0
			DropItemHolder.Position = UDim2.new(-0.203539819, 0, 1.02380955, 0)
			DropItemHolder.Size = UDim2.new(0, 436, 0, 82)
			DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
			DropItemHolder.ScrollBarThickness = 5
			DropItemHolder.ScrollBarImageColor3 = Color3.fromRGB(41, 42, 48)

			DropLayout.Name = "DropLayout"
			DropLayout.Parent = DropItemHolder
			DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
			DropLayout.Padding = UDim.new(0, 2)
			
			Dropdown.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)

			Dropdown.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)

			
			Dropdown.MouseButton1Click:Connect(function()
				if DropToggled == false then
					Title.Text = Selected
					Dropdown:TweenSize(UDim2.new(0, 457, 0, FrameSize), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Title.Text = Selected
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
			DropToggled = not DropToggled
			end)
			
			for i,v in next, list do
				ItemCount = ItemCount + 1
				
				if ItemCount == 1 then
					FrameSize = 78
				elseif ItemCount == 2 then
					FrameSize = 107
				elseif ItemCount >= 3 then
					FrameSize = 133
				end
				local Item = Instance.new("TextButton")
				local ItemCorner = Instance.new("UICorner")
				
				Item.Name = "Item"
				Item.Parent = DropItemHolder
				Item.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
				Item.ClipsDescendants = true
				Item.Size = UDim2.new(0, 427, 0, 25)
				Item.AutoButtonColor = false
				Item.Font = Enum.Font.Gotham
				Item.Text = v
				Item.TextColor3 = Color3.fromRGB(255, 255, 255)
				Item.TextSize = 15.000
				Item.TextTransparency = 0.300

				ItemCorner.CornerRadius = UDim.new(0, 4)
				ItemCorner.Name = "ItemCorner"
				ItemCorner.Parent = Item
				DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
				
				Item.MouseEnter:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end)

				Item.MouseLeave:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
				end)
				
				Item.MouseButton1Click:Connect(function()
					pcall(callback, v)
					Title.Text = OldSelected.." : "..v
					Selected = v
					DropToggled = not DropToggled
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
					
				end)
			end
			function DropFunc:Add(addtext)
				ItemCount = ItemCount + 1

				if ItemCount == 1 then
					FrameSize = 78
				elseif ItemCount == 2 then
					FrameSize = 107
				elseif ItemCount >= 3 then
					FrameSize = 133
				end
				local Item = Instance.new("TextButton")
				local ItemCorner = Instance.new("UICorner")

				Item.Name = "Item"
				Item.Parent = DropItemHolder
				Item.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
				Item.ClipsDescendants = true
				Item.Size = UDim2.new(0, 427, 0, 25)
				Item.AutoButtonColor = false
				Item.Font = Enum.Font.Gotham
				Item.Text = addtext
				Item.TextColor3 = Color3.fromRGB(255, 255, 255)
				Item.TextSize = 15.000
				Item.TextTransparency = 0.300

				ItemCorner.CornerRadius = UDim.new(0, 4)
				ItemCorner.Name = "ItemCorner"
				ItemCorner.Parent = Item
				DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)

				Item.MouseEnter:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end)

				Item.MouseLeave:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
				end)

				Item.MouseButton1Click:Connect(function()
					pcall(callback, addtext)
					Title.Text = OldSelected.." : "..addtext
					Selected = addtext
					DropToggled = not DropToggled
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end)
				if DropToggled == true then
					Title.Text = Selected
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
			end
			function DropFunc:Clear()
				Title.Text = OldSelected
				FrameSize = 0
				ItemCount = 0
				for i, v in next, DropItemHolder:GetChildren() do
					if v.Name == "Item" then
						v:Destroy()
					end
				end
				if DropToggled == true then
					Title.Text = Selected
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
			end
			return DropFunc
		end
		function ContainerContent:Colorpicker(text,preset,callback)
			local ColorPickerToggled = false
			local OldToggleColor = Color3.fromRGB(0, 0, 0)
			local OldColor = Color3.fromRGB(0, 0, 0)
			local OldColorSelectionPosition = nil
			local OldHueSelectionPosition = nil
			local ColorH, ColorS, ColorV = 1, 1, 1
			local RainbowColorPicker = false
			local ColorPickerInput = nil
			local ColorInput = nil
			local HueInput = nil
			
			local Colorpicker = Instance.new("Frame")
			local ColorpickerCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local Hue = Instance.new("ImageLabel")
			local HueCorner = Instance.new("UICorner")
			local HueGradient = Instance.new("UIGradient")
			local HueSelection = Instance.new("ImageLabel")
			local Color = Instance.new("ImageLabel")
			local ColorCorner = Instance.new("UICorner")
			local ColorSelection = Instance.new("ImageLabel")
			local Toggle = Instance.new("TextLabel")
			local ToggleFrame = Instance.new("Frame")
			local ToggleFrameCorner = Instance.new("UICorner")
			local ToggleCircle = Instance.new("Frame")
			local ToggleCircleCorner = Instance.new("UICorner")
			local Confirm = Instance.new("TextButton")
			local ConfirmCorner = Instance.new("UICorner")
			local ConfirmTitle = Instance.new("TextLabel")
			local BoxColor = Instance.new("Frame")
			local BoxColorCorner = Instance.new("UICorner")
			local ColorpickerBtn = Instance.new("TextButton")
			local ToggleBtn = Instance.new("TextButton")


			Colorpicker.Name = "Colorpicker"
			Colorpicker.Parent = Container
			Colorpicker.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Colorpicker.ClipsDescendants = true
			Colorpicker.Position = UDim2.new(0.110937499, 0, 0.67653507, 0)
			Colorpicker.Size = UDim2.new(0, 457, 0, 43)

			ColorpickerCorner.CornerRadius = UDim.new(0, 4)
			ColorpickerCorner.Name = "ColorpickerCorner"
			ColorpickerCorner.Parent = Colorpicker

			Title.Name = "Title"
			Title.Parent = Colorpicker
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = "Colorpicker"
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left
			

			ColorpickerBtn.Name = "ColorpickerBtn"
			ColorpickerBtn.Parent = Title
			ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ColorpickerBtn.BackgroundTransparency = 1.000
			ColorpickerBtn.Position = UDim2.new(-0.336283177, 0, 0, 0)
			ColorpickerBtn.Size = UDim2.new(0, 457, 0, 42)
			ColorpickerBtn.Font = Enum.Font.SourceSans
			ColorpickerBtn.Text = ""
			ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
			ColorpickerBtn.TextSize = 14.000

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(110, 200, 170)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(110, 200, 170)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			Hue.Name = "Hue"
			Hue.Parent = Title
			Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hue.Position = UDim2.new(0, 229, 0, 46)
			Hue.Size = UDim2.new(0, 25, 0, 80)

			HueCorner.CornerRadius = UDim.new(0, 3)
			HueCorner.Name = "HueCorner"
			HueCorner.Parent = Hue

			HueGradient.Color = ColorSequence.new {
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
				ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
				ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
				ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
				ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
				ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
			}			
			HueGradient.Rotation = 270
			HueGradient.Name = "HueGradient"
			HueGradient.Parent = Hue

			HueSelection.Name = "HueSelection"
			HueSelection.Parent = Hue
			HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
			HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueSelection.BackgroundTransparency = 1.000
			HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
			HueSelection.Size = UDim2.new(0, 18, 0, 18)
			HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
			HueSelection.Visible = false

			Color.Name = "Color"
			Color.Parent = Title
			Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			Color.Position = UDim2.new(0, -23, 0, 46)
			Color.Size = UDim2.new(0, 246, 0, 80)
			Color.ZIndex = 10
			Color.Image = "rbxassetid://4155801252"

			ColorCorner.CornerRadius = UDim.new(0, 3)
			ColorCorner.Name = "ColorCorner"
			ColorCorner.Parent = Color

			ColorSelection.Name = "ColorSelection"
			ColorSelection.Parent = Color
			ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
			ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ColorSelection.BackgroundTransparency = 1.000
			ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
			ColorSelection.Size = UDim2.new(0, 18, 0, 18)
			ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
			ColorSelection.ScaleType = Enum.ScaleType.Fit
			ColorSelection.Visible = false

			Toggle.Name = "Toggle"
			Toggle.Parent = Title
			Toggle.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
			Toggle.BackgroundTransparency = 1.000
			Toggle.Position = UDim2.new(2.37430048, 0, 1.07157099, 0)
			Toggle.Size = UDim2.new(0, 137, 0, 38)
			Toggle.Font = Enum.Font.Gotham
			Toggle.Text = "Rainbow"
			Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.TextSize = 15.000
			Toggle.TextTransparency = 0.300
			Toggle.TextXAlignment = Enum.TextXAlignment.Left

			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.Parent = Toggle
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(226, 227, 227)
			ToggleFrame.Position = UDim2.new(0.778387249, 0, 0.357142866, 0)
			ToggleFrame.Size = UDim2.new(0, 27, 0, 11)

			ToggleFrameCorner.Name = "ToggleFrameCorner"
			ToggleFrameCorner.Parent = ToggleFrame

			ToggleCircle.Name = "ToggleCircle"
			ToggleCircle.Parent = ToggleFrame
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(110, 200, 170)
			ToggleCircle.Position = UDim2.new(0, 0, -0.273000002, 0)
			ToggleCircle.Selectable = true
			ToggleCircle.Size = UDim2.new(0, 17, 0, 17)

			ToggleCircleCorner.CornerRadius = UDim.new(2, 8)
			ToggleCircleCorner.Name = "ToggleCircleCorner"
			ToggleCircleCorner.Parent = ToggleCircle

			Confirm.Name = "Confirm"
			Confirm.Parent = Title
			Confirm.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Confirm.ClipsDescendants = true
			Confirm.Position = UDim2.new(2.3791616, 0, 1.97633278, 0)
			Confirm.Size = UDim2.new(0, 144, 0, 42)
			Confirm.AutoButtonColor = false
			Confirm.Font = Enum.Font.SourceSans
			Confirm.Text = ""
			Confirm.TextColor3 = Color3.fromRGB(0, 0, 0)
			Confirm.TextSize = 14.000

			ConfirmCorner.CornerRadius = UDim.new(0, 4)
			ConfirmCorner.Name = "ConfirmCorner"
			ConfirmCorner.Parent = Confirm

			ConfirmTitle.Name = "ConfirmTitle"
			ConfirmTitle.Parent = Confirm
			ConfirmTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ConfirmTitle.BackgroundTransparency = 1.000
			ConfirmTitle.Size = UDim2.new(0, 116, 0, 40)
			ConfirmTitle.Font = Enum.Font.Gotham
			ConfirmTitle.Text = "Confirm"
			ConfirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			ConfirmTitle.TextSize = 15.000
			ConfirmTitle.TextTransparency = 0.300
			ConfirmTitle.TextXAlignment = Enum.TextXAlignment.Left

			BoxColor.Name = "BoxColor"
			BoxColor.Parent = Title
			BoxColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BoxColor.Position = UDim2.new(3.26915574, 0, 0.261904776, 0)
			BoxColor.Size = UDim2.new(0, 35, 0, 19)

			BoxColorCorner.CornerRadius = UDim.new(0, 4)
			BoxColorCorner.Name = "BoxColorCorner"
			BoxColorCorner.Parent = BoxColor

			ToggleBtn.Name = "ToggleBtn"
			ToggleBtn.Parent = Toggle
			ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleBtn.BackgroundTransparency = 1.000
			ToggleBtn.Size = UDim2.new(0, 137, 0, 38)
			ToggleBtn.Font = Enum.Font.SourceSans
			ToggleBtn.Text = ""
			ToggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
			ToggleBtn.TextSize = 14.000
			
			ColorpickerBtn.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)

			ColorpickerBtn.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)
		 	
			ColorpickerBtn.MouseButton1Click:Connect(function()
				if ColorPickerToggled == false then
					ColorSelection.Visible = true
					HueSelection.Visible = true
					Colorpicker:TweenSize(UDim2.new(0, 457, 0, 138), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					ColorSelection.Visible = false
					HueSelection.Visible = false
					Colorpicker:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				ColorPickerToggled = not ColorPickerToggled
			end)
			

			local function UpdateColorPicker(nope)
				BoxColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
				Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

				pcall(callback, BoxColor.BackgroundColor3)
			end

			ColorH =
				1 -
				(math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
					Hue.AbsoluteSize.Y)
			ColorS =
				(math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
					Color.AbsoluteSize.X)
			ColorV =
				1 -
				(math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
					Color.AbsoluteSize.Y)

			BoxColor.BackgroundColor3 = preset
			Color.BackgroundColor3 = preset
			pcall(callback, BoxColor.BackgroundColor3)

			Color.InputBegan:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if RainbowColorPicker then
							return
						end

						if ColorInput then
							ColorInput:Disconnect()
						end

						ColorInput =
							RunService.RenderStepped:Connect(
								function()
								local ColorX =
									(math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
										Color.AbsoluteSize.X)
								local ColorY =
									(math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
										Color.AbsoluteSize.Y)

								ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
								ColorS = ColorX
								ColorV = 1 - ColorY

								UpdateColorPicker(true)
							end
							)
					end
				end
			)

			Color.InputEnded:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if ColorInput then
							ColorInput:Disconnect()
						end
					end
				end
			)

			Hue.InputBegan:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if RainbowColorPicker then
							return
						end

						if HueInput then
							HueInput:Disconnect()
						end

						HueInput =
							RunService.RenderStepped:Connect(
								function()
								local HueY =
									(math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
										Hue.AbsoluteSize.Y)

								HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
								ColorH = 1 - HueY

								UpdateColorPicker(true)
							end
							)
					end
				end
			)

			Hue.InputEnded:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HueInput then
							HueInput:Disconnect()
						end
					end
				end
			)

			ToggleBtn.MouseButton1Down:Connect(
				function()
					RainbowColorPicker = not RainbowColorPicker

					if ColorInput then
						ColorInput:Disconnect()
					end

					if HueInput then
						HueInput:Disconnect()
					end

					if RainbowColorPicker then
						ToggleCircle:TweenPosition(UDim2.new(0.37, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
						TweenService:Create(
							ToggleCircle,
							TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 =PresetColor}
						):Play()

						OldToggleColor = BoxColor.BackgroundColor3
						OldColor = Color.BackgroundColor3
						OldColorSelectionPosition = ColorSelection.Position
						OldHueSelectionPosition = HueSelection.Position

						while RainbowColorPicker do
							BoxColor.BackgroundColor3 = Color3.fromHSV(Flux.RainbowColorValue, 1, 1)
							Color.BackgroundColor3 = Color3.fromHSV(Flux.RainbowColorValue, 1, 1)

							ColorSelection.Position = UDim2.new(1, 0, 0, 0)
							HueSelection.Position = UDim2.new(0.48, 0, 0, Flux.HueSelectionPosition)

							pcall(callback, BoxColor.BackgroundColor3)
							wait()
						end
					elseif not RainbowColorPicker then
						ToggleCircle:TweenPosition(UDim2.new(0, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
						TweenService:Create(
							ToggleCircle,
							TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 = Color3.fromRGB(255,255,255)}
						):Play()

						BoxColor.BackgroundColor3 = OldToggleColor
						Color.BackgroundColor3 = OldColor

						ColorSelection.Position = OldColorSelectionPosition
						HueSelection.Position = OldHueSelectionPosition

						pcall(callback, BoxColor.BackgroundColor3)
					end
				end
			)

			Confirm.MouseButton1Click:Connect(
				function()
					ColorSelection.Visible = false
					HueSelection.Visible = false
					ColorPickerToggled = not ColorPickerToggled
					Colorpicker:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
			)
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		function ContainerContent:Line()
			local Line = Instance.new("TextButton")
			local LineCorner = Instance.new("UICorner")

			Line.Name = "Line"
			Line.Parent = Container
			Line.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Line.ClipsDescendants = true
			Line.Position = UDim2.new(0, 0, 0.70091325, 0)
			Line.Size = UDim2.new(0, 457, 0, 4)
			Line.AutoButtonColor = false
			Line.Font = Enum.Font.SourceSans
			Line.Text = ""
			Line.TextColor3 = Color3.fromRGB(0, 0, 0)
			Line.TextSize = 14.000

			LineCorner.CornerRadius = UDim.new(0, 4)
			LineCorner.Name = "LineCorner"
			LineCorner.Parent = Line
			
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		function ContainerContent:Label(text)
			local Label = Instance.new("TextButton")
			local LabelCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")

			Label.Name = "Label"
			Label.Parent = Container
			Label.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
			Label.ClipsDescendants = true
			Label.Position = UDim2.new(0.370312512, 0, 0.552631557, 0)
			Label.Size = UDim2.new(0, 457, 0, 43)
			Label.AutoButtonColor = false
			Label.Font = Enum.Font.SourceSans
			Label.Text = ""
			Label.TextColor3 = Color3.fromRGB(0, 0, 0)
			Label.TextSize = 14.000

			LabelCorner.CornerRadius = UDim.new(0, 4)
			LabelCorner.Name = "LabelCorner"
			LabelCorner.Parent = Label

			Title.Name = "Title"
			Title.Parent = Label
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.038480062, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left
			
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
            local labelfunc = {}
            
            function labelfunc:Refresh(ReTest)
                Title.Text = ReTest
            end
            
            return labelfunc
		end
		function ContainerContent:Textbox(text,desc,disapper,callback)
			if desc == "" then
				desc = "There is no description for this textbox."
			end
			local TextboxDescToggled = false
			local Textbox = Instance.new("TextButton")
			local TextboxCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local Description = Instance.new("TextLabel")
			local TextboxFrame = Instance.new("Frame")
			local TextboxFrameCorner = Instance.new("UICorner")
			local TextBox = Instance.new("TextBox")
			local ArrowBtn = Instance.new("ImageButton")
			local ArrowIco = Instance.new("ImageLabel")

			Textbox.Name = "Textbox"
			Textbox.Parent = Container
			Textbox.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Textbox.ClipsDescendants = true
			Textbox.Position = UDim2.new(0.0459499061, 0, 0.734449744, 0)
			Textbox.Size = UDim2.new(0, 457, 0, 43)
			Textbox.AutoButtonColor = false
			Textbox.Font = Enum.Font.SourceSans
			Textbox.Text = ""
			Textbox.TextColor3 = Color3.fromRGB(0, 0, 0)
			Textbox.TextSize = 14.000

			TextboxCorner.CornerRadius = UDim.new(0, 4)
			TextboxCorner.Name = "TextboxCorner"
			TextboxCorner.Parent = Textbox

			Title.Name = "Title"
			Title.Parent = Textbox
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(110, 200, 170)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(110, 200, 170)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			Description.Name = "Description"
			Description.Parent = Title
			Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description.BackgroundTransparency = 1.000
			Description.Position = UDim2.new(-0.200942323, 0, 0.985714269, 0)
			Description.Size = UDim2.new(0, 432, 0, 31)
			Description.Font = Enum.Font.Gotham
			Description.Text = desc
			Description.TextColor3 = Color3.fromRGB(255, 255, 255)
			Description.TextSize = 15.000
			Description.TextTransparency = 1
			Description.TextWrapped = true
			Description.TextXAlignment = Enum.TextXAlignment.Left

			TextboxFrame.Name = "TextboxFrame"
			TextboxFrame.Parent = Title
			TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 53, 59)
			TextboxFrame.Position = UDim2.new(1.82300889, 0, 0.202380955, 0)
			TextboxFrame.Size = UDim2.new(0, 161, 0, 26)

			TextboxFrameCorner.CornerRadius = UDim.new(0, 4)
			TextboxFrameCorner.Name = "TextboxFrameCorner"
			TextboxFrameCorner.Parent = TextboxFrame

			TextBox.Parent = TextboxFrame
			TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.BackgroundTransparency = 1.000
			TextBox.Size = UDim2.new(0, 161, 0, 26)
			TextBox.Font = Enum.Font.Gotham
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextSize = 15.000
			TextBox.TextTransparency = 0.300

			ArrowBtn.Name = "ArrowBtn"
			ArrowBtn.Parent = Textbox
			ArrowBtn.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
			ArrowBtn.BackgroundTransparency = 1.000
			ArrowBtn.Position = UDim2.new(0.903719902, 0, 0, 0)
			ArrowBtn.Size = UDim2.new(0, 33, 0, 37)
			ArrowBtn.SliceCenter = Rect.new(30, 30, 30, 30)
			ArrowBtn.SliceScale = 7.000

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = ArrowBtn
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(0.495753437, 0, 0.554054081, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6034818372"
			
			TextBox.FocusLost:Connect(
				function(ep)
					if ep then
						if #TextBox.Text > 0 then
							pcall(callback, TextBox.Text)
							if disapper then
								TextBox.Text = ""
							end
						end
					end
				end
			)
			
			ArrowBtn.MouseButton1Click:Connect(function()
				if TextboxDescToggled == false then
					Textbox:TweenSize(UDim2.new(0, 457, 0, 81), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Textbox:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(254, 165, 107)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				TextboxDescToggled = not TextboxDescToggled
			end)
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		function ContainerContent:Bind(text,presetbind,callback)
			local Key = presetbind.Name
			local Bind = Instance.new("TextButton")
			local BindCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local BindLabel = Instance.new("TextLabel")

			Bind.Name = "Bind"
			Bind.Parent = Container
			Bind.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Bind.ClipsDescendants = true
			Bind.Position = UDim2.new(0.40625, 0, 0.828947306, 0)
			Bind.Size = UDim2.new(0, 457, 0, 43)
			Bind.AutoButtonColor = false
			Bind.Font = Enum.Font.SourceSans
			Bind.Text = ""
			Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
			Bind.TextSize = 14.000

			BindCorner.CornerRadius = UDim.new(0, 4)
			BindCorner.Name = "BindCorner"
			BindCorner.Parent = Bind

			Title.Name = "Title"
			Title.Parent = Bind
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(110, 200, 170)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(110, 200, 170)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			BindLabel.Name = "BindLabel"
			BindLabel.Parent = Title
			BindLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BindLabel.BackgroundTransparency = 1.000
			BindLabel.Position = UDim2.new(2.56011987, 0, 0, 0)
			BindLabel.Size = UDim2.new(0, 113, 0, 42)
			BindLabel.Font = Enum.Font.Gotham
			BindLabel.Text = Key
			BindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			BindLabel.TextSize = 15.000
			BindLabel.TextTransparency = 0.300
			BindLabel.TextXAlignment = Enum.TextXAlignment.Right
			
			Bind.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)

			Bind.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)

			Bind.MouseButton1Click:connect(
				function()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						BindLabel,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						BindLabel,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					BindLabel.Text = "..."
					local inputwait = game:GetService("UserInputService").InputBegan:wait()
					if inputwait.KeyCode.Name ~= "Unknown" then
						BindLabel.Text = inputwait .KeyCode.Name
						Key = inputwait .KeyCode.Name
					end
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						BindLabel,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						BindLabel,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
				end
			)

			game:GetService("UserInputService").InputBegan:connect(
			function(current, pressed)
				if not pressed then
					if current.KeyCode.Name == Key then
						pcall(callback)
					end
				end
			end
			)
			
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		return ContainerContent
	end
	return Tabs
end

local win = Flux:Window("NewbieHub", "Blox Fruit", Color3.fromRGB(255, 165, 9), Enum.KeyCode.RightControl)
local AutoFram = win:Tab("Auto Fram", "http://www.roblox.com/asset/?id=6023426915")
OldWorld = false
newworld = false
Test = "Magnet" 
local MyLevel = game.Players.localPlayer.Data.Level.Value
local placeId = game.PlaceId
if placeId == 2753915549 then
    OldWorld = true
elseif placeId == 4442272183 then
    newworld = true
end
function CheckQuest()
    local MyLevel = game.Players.localPlayer.Data.Level.Value
    if OldWorld then
        if MyLevel == 1 or MyLevel <= 9 then -- Bandit
            Ms = "Bandit [Lv. 5]"
            NaemQuest = "BanditQuest1"
            LevelQuest = 1
            CFrameQuest = CFrame.new(1061.66699, 16.5166187, 1544.52905, -0.942978859, -3.33851502e-09, 0.332852632, 7.04340497e-09, 1, 2.99841325e-08, -0.332852632, 3.06188177e-08, -0.942978859)
            CFrameMon = CFrame.new(1199.31287, 52.2717781, 1536.91516, -0.929782331, 6.60215846e-08, -0.368109822, 3.9077392e-08, 1, 8.06501603e-08, 0.368109822, 6.06023249e-08, -0.929782331)
        elseif MyLevel == 10 or MyLevel <= 14 then -- Monkey
            Ms = "Monkey [Lv. 14]"
            NaemQuest = "JungleQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
            CFrameMon = CFrame.new(-1402.74609, 98.5633316, 90.6417007, 0.836947978, 0, 0.547282517, -0, 1, -0, -0.547282517, 0, 0.836947978)
        elseif MyLevel == 15 or MyLevel <= 29 then -- Gorilla
            Ms = "Gorilla [Lv. 20]"
            NaemQuest = "JungleQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
            CFrameMon = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519, -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
        elseif MyLevel == 30 or MyLevel <= 39 then -- Pirate
            Ms = "Pirate [Lv. 35]"
            NaemQuest = "BuggyQuest1"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
            CFrameMon = CFrame.new(-1219.32324, 4.75205183, 3915.63452, -0.966492832, -6.91238853e-08, 0.25669381, -5.21195496e-08, 1, 7.3047012e-08, -0.25669381, 5.72206496e-08, -0.966492832)
        elseif MyLevel == 40 or MyLevel <= 59 then -- ÚBrute
            Ms = "Brute [Lv. 45]"
            NaemQuest = "BuggyQuest1"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
            CFrameMon = CFrame.new(-1146.49646, 96.0936813, 4312.1333, -0.978175163, -1.53222057e-08, 0.207781896, -3.33316912e-08, 1, -8.31738873e-08, -0.207781896, -8.82843523e-08, -0.978175163)
        elseif MyLevel == 60 or MyLevel <= 74 then -- Desert Bandit
            Ms = "Desert Bandit [Lv. 60]"
            NaemQuest = "DesertQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(897.031128, 6.43846416, 4388.97168, -0.804044724, 3.68233266e-08, 0.594568789, 6.97835176e-08, 1, 3.24365246e-08, -0.594568789, 6.75715199e-08, -0.804044724)
            CFrameMon = CFrame.new(932.788818, 6.4503746, 4488.24609, -0.998625934, 3.08948351e-08, 0.0524050146, 2.79967303e-08, 1, -5.60361286e-08, -0.0524050146, -5.44919629e-08, -0.998625934)
        elseif MyLevel == 75 or MyLevel <= 89 then -- Desert Officre
            Ms = "Desert Officer [Lv. 70]"
            NaemQuest = "DesertQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(897.031128, 6.43846416, 4388.97168, -0.804044724, 3.68233266e-08, 0.594568789, 6.97835176e-08, 1, 3.24365246e-08, -0.594568789, 6.75715199e-08, -0.804044724)
            CFrameMon = CFrame.new(1580.03198, 4.61375761, 4366.86426, 0.135744005, -6.44280718e-08, -0.990743816, 4.35738308e-08, 1, -5.90598574e-08, 0.990743816, -3.51534837e-08, 0.135744005)
        elseif MyLevel == 90 or MyLevel <= 99 then -- Snow Bandits
            Ms = "Snow Bandit [Lv. 90]"
            NaemQuest = "SnowQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(1384.14001, 87.272789, -1297.06482, 0.348555952, -2.53947841e-09, -0.937287986, 1.49860568e-08, 1, 2.86358204e-09, 0.937287986, -1.50443711e-08, 0.348555952)
            CFrameMon = CFrame.new(1370.24316, 102.403511, -1411.52905, 0.980274439, -1.12995728e-08, 0.197641045, -9.57343449e-09, 1, 1.04655214e-07, -0.197641045, -1.04482936e-07, 0.980274439)
        elseif MyLevel == 100 or MyLevel <= 119 then -- Snowman
            Ms = "Snowman [Lv. 100]"
            NaemQuest = "SnowQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(1384.14001, 87.272789, -1297.06482, 0.348555952, -2.53947841e-09, -0.937287986, 1.49860568e-08, 1, 2.86358204e-09, 0.937287986, -1.50443711e-08, 0.348555952)
            CFrameMon = CFrame.new(1370.24316, 102.403511, -1411.52905, 0.980274439, -1.12995728e-08, 0.197641045, -9.57343449e-09, 1, 1.04655214e-07, -0.197641045, -1.04482936e-07, 0.980274439)
        elseif MyLevel == 120 or MyLevel <= 149 then -- Chief Petty Officer
            Ms = "Chief Petty Officer [Lv. 120]"
            NaemQuest = "MarineQuest2"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-5035.0835, 28.6520386, 4325.29443, 0.0243340395, -7.08064647e-08, 0.999703884, -6.36926814e-08, 1, 7.23777944e-08, -0.999703884, -6.54350671e-08, 0.0243340395)
            CFrameMon = CFrame.new(-4882.8623, 22.6520386, 4255.53516, 0.273695946, -5.40380647e-08, -0.96181643, 4.37720793e-08, 1, -4.37274998e-08, 0.96181643, -3.01326679e-08, 0.273695946)
        elseif MyLevel == 150 or MyLevel <= 174 then -- Sky Bandit
            Ms = "Sky Bandit [Lv. 150]"
            NaemQuest = "SkyQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-4841.83447, 717.669617, -2623.96436, -0.875942111, 5.59710216e-08, -0.482416272, 3.04023082e-08, 1, 6.08195947e-08, 0.482416272, 3.86078725e-08, -0.875942111)
            CFrameMon = CFrame.new(-4970.74219, 294.544342, -2890.11353, -0.994874597, -8.61311236e-08, -0.101116329, -9.10836206e-08, 1, 4.43614923e-08, 0.101116329, 5.33441664e-08, -0.994874597)
        elseif MyLevel == 175 or MyLevel <= 224 then -- Dark Master
            Ms = "Dark Master [Lv. 175]"
            NaemQuest = "SkyQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-4841.83447, 717.669617, -2623.96436, -0.875942111, 5.59710216e-08, -0.482416272, 3.04023082e-08, 1, 6.08195947e-08, 0.482416272, 3.86078725e-08, -0.875942111)
            CFrameMon = CFrame.new(-5220.58594, 430.693298, -2278.17456, -0.925375521, 1.12086873e-08, 0.379051805, -1.05115507e-08, 1, -5.52320891e-08, -0.379051805, -5.50948407e-08, -0.925375521)
        elseif MyLevel == 225 or MyLevel <= 274 then -- Toga Warrior
            Ms = "Toga Warrior [Lv. 225]"
            NaemQuest = "ColosseumQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
            CFrameMon = CFrame.new(-1779.97583, 44.6077499, -2736.35474, 0.984437346, 4.10396339e-08, 0.175734788, -3.62286876e-08, 1, -3.05844168e-08, -0.175734788, 2.3741821e-08, 0.984437346)
        elseif MyLevel == 275 or MyLevel <= 299 then -- Gladiato
            Ms = "Gladiator [Lv. 275]"
            NaemQuest = "ColosseumQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
            CFrameMon = CFrame.new(-1274.75903, 58.1895943, -3188.16309, 0.464524001, 6.21005611e-08, 0.885560572, -4.80449414e-09, 1, -6.76054768e-08, -0.885560572, 2.71497012e-08, 0.464524001)
        elseif MyLevel == 300 or MyLevel <= 329 then -- Military Soldier
            Ms = "Military Soldier [Lv. 300]"
            NaemQuest = "MagmaQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
            CFrameMon = CFrame.new(-5363.01123, 41.5056877, 8548.47266, -0.578253984, -3.29503091e-10, 0.815856814, 9.11209668e-08, 1, 6.498761e-08, -0.815856814, 1.11920997e-07, -0.578253984)
        elseif MyLevel == 300 or MyLevel <= 374 then -- Military Spy
            Ms = "Military Spy [Lv. 330]"
            NaemQuest = "MagmaQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
            CFrameMon = CFrame.new(-5787.99023, 120.864456, 8762.25293, -0.188358366, -1.84706277e-08, 0.982100308, -1.23782129e-07, 1, -4.93306951e-09, -0.982100308, -1.22495649e-07, -0.188358366)
        elseif MyLevel == 375 or MyLevel <= 399 then -- Fishman Warrior
            Ms = "Fishman Warrior [Lv. 375]"
            NaemQuest = "FishmanQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
            CFrameMon = CFrame.new(60946.6094, 48.6735229, 1525.91687, -0.0817126185, 8.90751153e-08, 0.996655822, 2.00889794e-08, 1, -8.77269599e-08, -0.996655822, 1.28533992e-08, -0.0817126185)
        elseif MyLevel == 400 or MyLevel <= 449 then -- Fishman Commando
            Ms = "Fishman Commando [Lv. 400]"
            NaemQuest = "FishmanQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
            CFrameMon = CFrame.new(61885.5039, 18.4828243, 1504.17896, 0.577502489, 0, -0.816389024, -0, 1.00000012, -0, 0.816389024, 0, 0.577502489)
        elseif MyLevel == 450 or MyLevel <= 474 then -- God's Guards
            Ms = "God's Guard [Lv. 450]"
            NaemQuest = "SkyExp1Quest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-4721.71436, 845.277161, -1954.20105, -0.999277651, -5.56969759e-09, 0.0380011722, -4.14751478e-09, 1, 3.75035256e-08, -0.0380011722, 3.73188307e-08, -0.999277651)
            CFrameMon = CFrame.new(-4716.95703, 853.089722, -1933.92542, -0.93441087, -6.77488776e-09, -0.356197298, 1.12145182e-08, 1, -4.84390199e-08, 0.356197298, -4.92565206e-08, -0.93441087)
        elseif MyLevel == 475 or MyLevel <= 524 then -- Shandas
            Ms = "Shanda [Lv. 475]"
            NaemQuest = "SkyExp1Quest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-7863.63672, 5545.49316, -379.826324, 0.362120807, -1.98046344e-08, -0.93213129, 4.05822291e-08, 1, -5.48095125e-09, 0.93213129, -3.58431969e-08, 0.362120807)
            CFrameMon = CFrame.new(-7685.12354, 5601.05127, -443.171509, 0.150056243, 1.79768236e-08, -0.988677442, 6.67798661e-09, 1, 1.91962481e-08, 0.988677442, -9.48289181e-09, 0.150056243)
        elseif MyLevel == 525 or MyLevel <= 549 then -- Royal Squad
            Ms = "Royal Squad [Lv. 525]"
            NaemQuest = "SkyExp2Quest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-7902.66895, 5635.96387, -1411.71802, 0.0504222959, 2.5710392e-08, 0.998727977, 1.12541557e-07, 1, -3.14249675e-08, -0.998727977, 1.13982921e-07, 0.0504222959)
            CFrameMon = CFrame.new(-7685.02051, 5606.87842, -1442.729, 0.561947823, 7.69527464e-09, -0.827172697, -4.24974544e-09, 1, 6.41599973e-09, 0.827172697, -9.01838604e-11, 0.561947823)
        elseif MyLevel == 550 or MyLevel <= 624 then -- Royal Soldier
            Ms = "Royal Soldier [Lv. 550]"
            NaemQuest = "SkyExp2Quest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-7902.66895, 5635.96387, -1411.71802, 0.0504222959, 2.5710392e-08, 0.998727977, 1.12541557e-07, 1, -3.14249675e-08, -0.998727977, 1.13982921e-07, 0.0504222959)
            CFrameMon = CFrame.new(-7864.44775, 5661.94092, -1708.22351, 0.998389959, 2.28686137e-09, -0.0567218624, 1.99431383e-09, 1, 7.54200258e-08, 0.0567218624, -7.54117195e-08, 0.998389959)
        elseif MyLevel == 625 or MyLevel <= 649 then -- Galley Pirate
            Ms = "Galley Pirate [Lv. 625]"
            NaemQuest = "FountainQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(5254.60156, 38.5011406, 4049.69678, -0.0504891425, -3.62066501e-08, -0.998724639, -9.87921389e-09, 1, -3.57534553e-08, 0.998724639, 8.06145284e-09, -0.0504891425)
            CFrameMon = CFrame.new(5595.06982, 41.5013695, 3961.47095, -0.992138803, -2.11610267e-08, -0.125142589, -1.34249509e-08, 1, -6.26613996e-08, 0.125142589, -6.04887518e-08, -0.992138803)
        elseif MyLevel >= 650 then -- Galley Captain
            Ms = "Galley Captain [Lv. 650]"
            NaemQuest = "FountainQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(5254.60156, 38.5011406, 4049.69678, -0.0504891425, -3.62066501e-08, -0.998724639, -9.87921389e-09, 1, -3.57534553e-08, 0.998724639, 8.06145284e-09, -0.0504891425)
            CFrameMon = CFrame.new(5658.5752, 38.5361786, 4928.93506, -0.996873081, 2.12391046e-06, -0.0790185928, 2.16989656e-06, 1, -4.96097414e-07, 0.0790185928, -6.66008248e-07, -0.996873081)
        end
    end
    if newworld then
        if MyLevel == 700 or MyLevel <= 724 then -- Raider [Lv. 700]
            Ms = "Raider [Lv. 700]"
            NaemQuest = "Area1Quest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
            CFrameMon = CFrame.new(-737.026123, 39.1748352, 2392.57959, 0.272128761, 0, -0.962260842, -0, 1, -0, 0.962260842, 0, 0.272128761)
        elseif MyLevel == 725 or MyLevel <= 774 then -- Mercenary [Lv. 725]
            Ms = "Mercenary [Lv. 725]"
            NaemQuest = "Area1Quest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
            CFrameMon = CFrame.new(-973.731995, 95.8733215, 1836.46936, 0.999135971, 2.02326991e-08, -0.0415605344, -1.90767793e-08, 1, 2.82094952e-08, 0.0415605344, -2.73922804e-08, 0.999135971)
        elseif MyLevel == 775 or MyLevel <= 799 then -- Swan Pirate [Lv. 775]
            Ms = "Swan Pirate [Lv. 775]"
            NaemQuest = "Area2Quest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
            CFrameMon = CFrame.new(970.369446, 142.653198, 1217.3667, 0.162079468, -4.85452638e-08, -0.986777723, 1.03357589e-08, 1, -4.74980872e-08, 0.986777723, -2.50063148e-09, 0.162079468)
        elseif MyLevel == 800 or MyLevel <= 874 then -- Factory Staff [Lv. 800]
            Ms = "Factory Staff [Lv. 800]"
            NaemQuest = "Area2Quest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
            CFrameMon = CFrame.new(296.786499, 72.9948196, -57.1298141, -0.876037002, -5.32364979e-08, 0.482243896, -3.87658332e-08, 1, 3.99718729e-08, -0.482243896, 1.63222538e-08, -0.876037002)
        elseif MyLevel == 875 or MyLevel <= 899 then -- Marine Lieutenant [Lv. 875]
            Ms = "Marine Lieutenant [Lv. 875]"
            NaemQuest = "MarineQuest3"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
            CFrameMon = CFrame.new(-2913.26367, 73.0011826, -2971.64282, 0.910507619, 0, 0.413492233, 0, 1.00000012, 0, -0.413492233, 0, 0.910507619)
        elseif MyLevel == 900 or MyLevel <= 949 then -- Marine Captain [Lv. 900]
            Ms = "Marine Captain [Lv. 900]"
            NaemQuest = "MarineQuest3"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
            CFrameMon = CFrame.new(-1868.67688, 73.0011826, -3321.66333, -0.971402287, 1.06502087e-08, 0.237439692, 3.68856199e-08, 1, 1.06050372e-07, -0.237439692, 1.11775684e-07, -0.971402287)
        elseif MyLevel == 950 or MyLevel <= 974 then -- Zombie [Lv. 950]
            Ms = "Zombie [Lv. 950]"
            NaemQuest = "ZombieQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-5492.79395, 48.5151672, -793.710571, 0.321800292, -6.24695815e-08, 0.946807742, 4.05616092e-08, 1, 5.21931227e-08, -0.946807742, 2.16082796e-08, 0.321800292)
            CFrameMon = CFrame.new(-5634.83838, 126.067039, -697.665039, -0.992770672, 6.77618939e-09, 0.120025545, 1.65461245e-08, 1, 8.04023372e-08, -0.120025545, 8.18070234e-08, -0.992770672)
        elseif MyLevel == 975 or MyLevel <= 999 then -- Vampire [Lv. 975]
            Ms = "Vampire [Lv. 975]"
            NaemQuest = "ZombieQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-5492.79395, 48.5151672, -793.710571, 0.321800292, -6.24695815e-08, 0.946807742, 4.05616092e-08, 1, 5.21931227e-08, -0.946807742, 2.16082796e-08, 0.321800292)
            CFrameMon = CFrame.new(-6030.32031, 6.4377408, -1313.5564, -0.856965423, 3.9138893e-08, -0.515373945, -1.12178942e-08, 1, 9.45958547e-08, 0.515373945, 8.68467822e-08, -0.856965423)
        elseif MyLevel == 1000 or MyLevel <= 1049 then -- Snow Trooper [Lv. 1000] **
            Ms = "Snow Trooper [Lv. 1000]"
            NaemQuest = "SnowMountainQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(604.964966, 401.457062, -5371.69287, 0.353063971, 1.89520435e-08, -0.935599446, -5.81846002e-08, 1, -1.70033754e-09, 0.935599446, 5.50377841e-08, 0.353063971)
            CFrameMon = CFrame.new(535.893433, 401.457062, -5329.6958, -0.999524176, 0, 0.0308452044, 0, 1, -0, -0.0308452044, 0, -0.999524176)
        elseif MyLevel == 1050 or MyLevel <= 1099 then -- Winter Warrior [Lv. 1050]
            Ms = "Winter Warrior [Lv. 1050]"
            NaemQuest = "SnowMountainQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(604.964966, 401.457062, -5371.69287, 0.353063971, 1.89520435e-08, -0.935599446, -5.81846002e-08, 1, -1.70033754e-09, 0.935599446, 5.50377841e-08, 0.353063971)
            CFrameMon = CFrame.new(1223.7417, 454.575226, -5170.02148, 0.473996818, 2.56845354e-08, 0.880526543, -5.62456428e-08, 1, 1.10811016e-09, -0.880526543, -5.00510211e-08, 0.473996818)
        elseif MyLevel == 1100 or MyLevel <= 1124 then -- Lab Subordinate [Lv. 1100]
            Ms = "Lab Subordinate [Lv. 1100]"
            NaemQuest = "IceSideQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-6060.10693, 15.9868021, -4904.7876, -0.411000341, -5.06538868e-07, 0.91163528, 1.26306062e-07, 1, 6.12581289e-07, -0.91163528, 3.66916197e-07, -0.411000341)
            CFrameMon = CFrame.new(-5769.2041, 37.9288292, -4468.38721, -0.569419742, -2.49055017e-08, 0.822046936, -6.96206541e-08, 1, -1.79282633e-08, -0.822046936, -6.74401548e-08, -0.569419742)
        elseif MyLevel == 1125 or MyLevel <= 1174 then -- Horned Warrior [Lv. 1125]
            Ms = "Horned Warrior [Lv. 1125]"
            NaemQuest = "IceSideQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-6060.10693, 15.9868021, -4904.7876, -0.411000341, -5.06538868e-07, 0.91163528, 1.26306062e-07, 1, 6.12581289e-07, -0.91163528, 3.66916197e-07, -0.411000341)
            CFrameMon = CFrame.new(-6400.85889, 24.7645149, -5818.63574, -0.964845479, 8.65926566e-08, -0.262817472, 3.98261392e-07, 1, -1.13260398e-06, 0.262817472, -1.19745812e-06, -0.964845479)
        elseif MyLevel == 1175 or MyLevel <= 1199 then -- Magma Ninja [Lv. 1175]
            Ms = "Magma Ninja [Lv. 1175]"
            NaemQuest = "FireSideQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(-5431.09473, 15.9868021, -5296.53223, 0.831796765, 1.15322464e-07, -0.555080295, -1.10814341e-07, 1, 4.17010995e-08, 0.555080295, 2.68240168e-08, 0.831796765)
            CFrameMon = CFrame.new(-5496.65576, 58.6890411, -5929.76855, -0.885073781, 0, -0.465450764, 0, 1.00000012, -0, 0.465450764, 0, -0.885073781)
        elseif MyLevel == 1200 or MyLevel <= 1249 then -- Lava Pirate [Lv. 1200]
            Ms = "Lava Pirate [Lv. 1200]"
            NaemQuest = "FireSideQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(-5431.09473, 15.9868021, -5296.53223, 0.831796765, 1.15322464e-07, -0.555080295, -1.10814341e-07, 1, 4.17010995e-08, 0.555080295, 2.68240168e-08, 0.831796765)
            CFrameMon = CFrame.new(-5169.71729, 34.1234779, -4669.73633, -0.196780294, 0, 0.98044765, 0, 1.00000012, -0, -0.98044765, 0, -0.196780294)
        elseif MyLevel == 1250 or MyLevel <= 1274 then -- Ship Deckhand [Lv. 1250]
            Ms = "Ship Deckhand [Lv. 1250]"
            NaemQuest = "ShipQuest1"
            LevelQuest = 1
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
            CFrameMon = CFrame.new(1163.80872, 138.288452, 33058.4258, -0.998580813, 5.49076979e-08, -0.0532564968, 5.57436763e-08, 1, -1.42118655e-08, 0.0532564968, -1.71604082e-08, -0.998580813)
        elseif MyLevel == 1275 or MyLevel <= 1299 then -- Ship Engineer [Lv. 1275]
            Ms = "Ship Engineer [Lv. 1275]"
            NaemQuest = "ShipQuest1"
            LevelQuest = 2
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
            CFrameMon = CFrame.new(916.666504, 44.0920448, 32917.207, -0.99746871, -4.85034697e-08, -0.0711069331, -4.8925461e-08, 1, 4.19294288e-09, 0.0711069331, 7.66126895e-09, -0.99746871)
        elseif MyLevel == 1300 or MyLevel <= 1324 then -- Ship Steward [Lv. 1300]
            Ms = "Ship Steward [Lv. 1300]"
            NaemQuest = "ShipQuest2"
            LevelQuest = 1
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
            CFrameMon = CFrame.new(918.743286, 129.591064, 33443.4609, -0.999792814, -1.7070947e-07, -0.020350717, -1.72559169e-07, 1, 8.91351277e-08, 0.020350717, 9.2628369e-08, -0.999792814)
        elseif MyLevel == 1325 or MyLevel <= 1349 then -- Ship Officer [Lv. 1325]
            Ms = "Ship Officer [Lv. 1325]"
            NaemQuest = "ShipQuest2"
            LevelQuest = 2
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
            CFrameMon = CFrame.new(786.051941, 181.474106, 33303.2969, 0.999285698, -5.32193063e-08, 0.0377905183, 5.68968588e-08, 1, -9.62386864e-08, -0.0377905183, 9.83201005e-08, 0.999285698)
        elseif MyLevel == 1350 or MyLevel <= 1374 then -- Arctic Warrior [Lv. 1350]
            Ms = "Arctic Warrior [Lv. 1350]"
            NaemQuest = "FrostQuest"
            LevelQuest = 1
            CFrameQuest = CFrame.new(5669.43506, 28.2117786, -6482.60107, 0.888092756, 1.02705066e-07, 0.459664226, -6.20391774e-08, 1, -1.03572376e-07, -0.459664226, 6.34646895e-08, 0.888092756)
            CFrameMon = CFrame.new(5995.07471, 57.3188477, -6183.47314, 0.702747107, -1.53454167e-07, -0.711440146, -1.08168464e-07, 1, -3.22542007e-07, 0.711440146, 3.03620908e-07, 0.702747107)
        elseif MyLevel >= 1375 then -- Snow Lurker [Lv. 1375]
            Ms = "Snow Lurker [Lv. 1375]"
            NaemQuest = "FrostQuest"
            LevelQuest = 2
            CFrameQuest = CFrame.new(5669.43506, 28.2117786, -6482.60107, 0.888092756, 1.02705066e-07, 0.459664226, -6.20391774e-08, 1, -1.03572376e-07, -0.459664226, 6.34646895e-08, 0.888092756)
            CFrameMon = CFrame.new(5518.00684, 60.5559731, -6828.80518, -0.650781393, -3.64292951e-08, 0.759265184, -4.07668654e-09, 1, 4.44854642e-08, -0.759265184, 2.58550248e-08, -0.650781393)
        end
    end
end
SelectToolWeapon = ""
AutoFram:Toggle("Auto Fram","",false,function(vu)
    if SelectToolWeapon == "" and vu then
        Flux:Notification("Select Weapon","Button")
	else
        local args = {
            [1] = "AbandonQuest"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        AFM = vu
    end
end)
AutoFram:Toggle("Auto Buy Legebdary Sword","",false,function(Value)
    LegebdarySword = Value    
end)
spawn(function()
    while wait() do
        if LegebdarySword then
            local args = {
                [1] = "LegendarySwordDealer",
                [2] = "2"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end 
    end
end)
AutoFram:Toggle("Auto Buy 2x Exp","",false,function(Value)
    x2Level = Value    
end)
x2Level = false
spawn(function()
    while wait(1) do
        if x2Level then
            if string.find(game.Players.LocalPlayer.PlayerGui.Main.Level.Exp.Text, "(2x ends)") then

            else
                local args = {
                    [1] = "Candies",
                    [2] = "Buy",
                    [3] = 1,
                    [4] = 1
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
        end
    end
end)
Wapon = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
    if v:IsA("Tool") then
        table.insert(Wapon ,v.Name)
    end
end
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
    if v:IsA("Tool") then
        table.insert(Wapon, v.Name)
    end
end
local SelectWeapon = AutoFram:Dropdown("Select Weapon",Wapon,function(Value)
    SelectToolWeapon = Value
end)
AutoFram:Button("Refresh Weapon","",function()
    SelectWeapon:Clear()
    Wapon = {}
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
		if v:IsA("Tool") then
			SelectWeapon:Add(v.Name)
		end
	end
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
		if v:IsA("Tool") then
			SelectWeapon:Add(v.Name)
		end
	end
end)
AutoFram:Label("Auto Farm Setting")
AutoFram:Toggle("Hide HitBlox","",false,function(Value)
    HideHitBlox = Value  
end)
AUTOHAKI = true
AutoFram:Toggle("Auto Haki","",true,function(Value)
    AUTOHAKI = Value  
end)
AutoFram:Toggle("Auto Observation haki","",false,function(Value)
    AUTOHAKIObs = Value  
end)
spawn(function()
    while wait() do
		if AUTOHAKI then 
			if game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then

			else
				local args = {
					[1] = "Buso"
				}
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
			end
		end
        if AUTOHAKIObs then 
            if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then

            else wait(1)
                local virtualUser = game:GetService('VirtualUser')
                virtualUser:CaptureController()

                virtualUser:SetKeyDown('0x65')
                wait(2)
                virtualUser:SetKeyUp('0x65')
            end
        end
    end
end)
local LocalPlayer = game:GetService("Players").LocalPlayer
local VirtualUser = game:GetService('VirtualUser')
function autofarm()
    if LocalPlayer.PlayerGui.Main.Quest.Visible == false then
        CheckQuest()
        print()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuest

        wait(1.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NaemQuest, LevelQuest)
    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
        CheckQuest()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
        if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
            pcall(
                function()
                    wait()
					repeat wait()
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v.Name == Ms then
								CheckQuest()
								if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
									if HideHitBlox then
										v.HumanoidRootPart.Transparency = 1
									else
										v.HumanoidRootPart.Transparency = 0.75
									end
									if game.Players.LocalPlayer.Backpack:FindFirstChild(SelectToolWeapon) then
										local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(SelectToolWeapon)
										wait(.4)
										game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
									end
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
									VirtualUser:CaptureController()
									VirtualUser:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
									-- µÕàÍ§
									if Test == "Magnet" then
										if setsimulationradius then 
											setsimulationradius(1e+1598, 1e+1599)
										end
										game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 15)
										PosMon = v.HumanoidRootPart.CFrame
									else
										game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 15)
									end
									v.HumanoidRootPart.CanCollide = false
								else
									CheckQuest()
									game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
								end
							end
						end
					until LocalPlayer.PlayerGui.Main.Quest.Visible == false or AFM == false
                end
            )
        else
            CheckQuest()
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
        end 
    end
end
spawn(function()
    while wait() do
        if Test == "Magnet" and AFM then
            CheckQuest()
            pcall(
                function()
                    repeat
                        wait()
                        for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == Ms then
                                wait()
                                v.HumanoidRootPart.CFrame = PosMon
                            end
                        end
                    until LocalPlayer.PlayerGui.Main.Quest.Visible == false or AFM == false
                end
            )
        end 
    end
end)
spawn(function()
    while wait() do
        if AFM then
            autofarm()
        end 
    end
end)
local Stats = win:Tab("Stats", "http://www.roblox.com/asset/?id=6023426915")
local Point = Stats:Label("Point :")
Point:Refresh("Point : "..game.Players.localPlayer.Data.Points.Value)
melee = false
Stats:Toggle("Melee","",false,function(Value)
    melee = Value    
end)
defense = false
Stats:Toggle("Defense","",false,function(value)
  defense = value
end)
sword = false
Stats:Toggle("Sword","",false,function(value)
  sword = value
end)
gun = false
Stats:Toggle("Gun","",false,function(value)
  gun = value
end)
demonfruit = false
Stats:Toggle("Demon Fruit","",false,function(value)
	demonfruit = value
end)
spawn(function()
    while wait() do
      if melee then
        local args = {
            [1] = "AddPoint",
            [2] = "Melee",
            [3] = 1
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
      end 
      if defense then
        local args = {
            [1] = "AddPoint",
            [2] = "Defense",
            [3] = 1
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
      end 
      if sword then
        local args = {
            [1] = "AddPoint",
            [2] = "Sword",
            [3] = 1
        }

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
      end 
      if gun then
        local args = {
            [1] = "AddPoint",
            [2] = "Gun",
            [3] = 1
        }

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
      end 
      if demonfruit then
        local args = {
            [1] = "AddPoint",
            [2] = "Demon Fruit",
            [3] = 1
        }

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
      end
      Point:Refresh("Point : "..game.Players.localPlayer.Data.Points.Value) 
    end
end)
local Teleport = win:Tab("Teleport", "http://www.roblox.com/asset/?id=6023426915")
Teleport:Toggle("Ctrl + Click = TP","",false,function(vu)
    CTRL = vu
end)
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()
Mouse.Button1Down:connect(
    function()
        if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
            return
        end
        if not Mouse.Target then
            return
        end
        if CTRL then
            Plr.Character:MoveTo(Mouse.Hit.p)
        end
    end
)
Teleport:Button("Current Quest","",function()
    CheckQuest()
    wait(0.25)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuest
end)
if newworld then
    Teleport:Button("Teleport To Old World","",function()
        local args = {
            [1] = "TravelMain" -- OLD WORLD to NEW WORLD
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
else
    Teleport:Button("Teleport To NewWorld","",function()
        local args = {
            [1] = "TravelDressrosa" -- NEW WORLD to OLD WORLD
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
end
Teleport:Label("Teleport Island")
if newworld then
    Teleport:Button("Dungeon","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6438.73535, 250.645355, -4501.50684)
    end)
    Teleport:Button("First Spot","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(82.9490662, 18.0710983, 2834.98779)
    end)
    Teleport:Button("Kingdom of Rose","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = game.Workspace["_WorldOrigin"].Locations["Kingdom of Rose"].CFrame
    end)
    Teleport:Button("Dark Ares","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = game.Workspace["_WorldOrigin"].Locations["Dark Arena"].CFrame
    end)
    Teleport:Button("Flamingo Mansion","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-390.096313, 331.886475, 673.464966)
    end)
    Teleport:Button("Flamingo Room","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2302.19019, 15.1778421, 663.811035)
    end)
    Teleport:Button("Green bit","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2372.14697, 72.9919434, -3166.51416)
    end)
    Teleport:Button("Cafe","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-385.250916, 73.0458984, 297.388397)
    end)
    Teleport:Button("Factroy","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_WorldOrigin"].Locations.Factory.CFrame
    end)
    Teleport:Button("Colosseum","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1836.58191, 44.5890656, 1360.30652)
    end)
    Teleport:Button("Ghost Island","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5571.84424, 195.182297, -795.432922)
    end)
    Teleport:Button("Ghost Island 2nd","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5931.77979, 5.19706631, -1189.6908)
    end)
    Teleport:Button("Snow Mountain","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1384.68298, 453.569031, -4990.09766)
    end)
    Teleport:Button("Hot and Cold","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6026.96484, 14.7461271, -5071.96338)
    end)
    Teleport:Button("Magma Side","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5478.39209, 15.9775667, -5246.9126)
    end)
    Teleport:Button("Cursed Ship","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(902.059143, 124.752518, 33071.8125)
    end)
    Teleport:Button("Frosted Island","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5400.40381, 28.21698, -6236.99219)
    end)
	Teleport:Button("Usoapp Island","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4748.78857, 8.35370827, 2849.57959)
    end)
else
    Teleport:Button("Start Island","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1071.2832, 16.3085976, 1426.86792)
    end)
    Teleport:Button("Middle Town","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-655.824158, 7.88708115, 1436.67908)
    end)
    Teleport:Button("Jungle","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1249.77222, 11.8870859, 341.356476)
    end)
    Teleport:Button("Buggy Island","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1122.34998, 4.78708982, 3855.91992)
    end)
    Teleport:Button("Desert","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1094.14587, 6.47350502, 4192.88721)
    end)
    Teleport:Button("Snow Island","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1198.00928, 27.0074959, -1211.73376)
    end)
    Teleport:Button("MarineFord","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4505.375, 20.687294, 4260.55908)
    end)
    Teleport:Button("Colosseum","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1428.35474, 7.38933945, -3014.37305)
    end)
    Teleport:Button("Sky 1st Floor","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4970.21875, 717.707275, -2622.35449)
    end)
    Teleport:Button("Sky 2st Floor","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4813.0249, 903.708557, -1912.69055)
    end)
    Teleport:Button("Sky 3st Floor","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7952.31006, 5545.52832, -320.704956)
    end)
    Teleport:Button("Impel Down","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4854.16455, 5.68742752, 740.194641)
    end)
    Teleport:Button("Vocalno Island","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5231.75879, 8.61593437, 8467.87695)
    end)
    Teleport:Button("UndeyWater City","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(61163.8516, 11.7796879, 1819.78418)
    end)
    Teleport:Button("Cyborg's Island Spot","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5132.7124, 4.53632832, 4037.8562)
    end)
    Teleport:Button("House Cyborg's","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6262.72559, 71.3003616, 3998.23047)
    end)
    Teleport:Button("Shank's Room","",function()
        game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1442.16553, 29.8788261, -28.3547478)
    end)
end
local Raids = win:Tab("Raids", "http://www.roblox.com/asset/?id=6023426915")
Raids:Label("Use In Raid Only",true)
Distance = 50
Raids:Slider("Distance","", 10,500,Distance,function(value)
    DistanceRaids = value
end)
Raids:Toggle("Kill Arua","",false,function(value)
	if newworld then
    	RaidsArua = value
	elseif OldWorld then
		Flux:Notification("Use In New World","Button")
	end
end)
Raids:Button("Awakening Room","",function()
	if newworld then
    	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(266.227783, 1.39509034, 1857.00732)
	elseif OldWorld then
		Flux:Notification("Use In New World","Button")
	end
end)
spawn(function()
	while wait() do
		if RaidsArua then
			for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
				if RaidsArua and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= DistanceRaids then
					pcall(function()
						repeat wait()
							if setsimulationradius then
								setsimulationradius(1e+1598, 1e+1599)
							end
							v.HumanoidRootPart.Transparency = 0.75
							v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
							v.HumanoidRootPart.CanCollide = false
							v.Humanoid.Health = 0
						until not RaidsArua or not v.Parent or v.Humanoid.Health <= 0
					end)
				end
			end
		end
	end
end)
local Esp = win:Tab("Esp", "http://www.roblox.com/asset/?id=6023426915")
local PLAYERS = math.random(1, 50)
function Create(base, team, Misc)
    local bb = Instance.new("BillboardGui", game.CoreGui)
    bb.Adornee = base
    bb.ExtentsOffset = Vector3.new(0, 1, 0)
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 5, 0, 5)
    bb.StudsOffset = Vector3.new(0, 1, 0)
    bb.Name = "PLAYER"..PLAYERS
    local frame = Instance.new("Frame", bb)
    frame.ZIndex = 10
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    local txtlbl = Instance.new("TextLabel", bb)
    txtlbl.ZIndex = 10
    txtlbl.BackgroundTransparency = 1
    txtlbl.Position = UDim2.new(0, 0, 0, -35)
    txtlbl.Size = UDim2.new(1, 0, 10, 0)
    txtlbl.Font = "GothamBold"
    txtlbl.FontSize = "Size18"
    txtlbl.Text = base.Parent.Name
    txtlbl.TextStrokeTransparency = 0.5
    if team and game.Players.localPlayer.Team == Misc.Team then
        txtlbl.TextColor3 = Color3.new(0,255,0)
        frame.BackgroundColor3 = Color3.new(0, 1, 1)
    else
        txtlbl.TextColor3 = Color3.new(255,0,0)
        frame.BackgroundColor3 = Color3.new(1, 0, 0)
    end
end
function Clearply()
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "PLAYER"..PLAYERS then
            v:Destroy()
        end
    end
end
Stats = false
function Findply(Stats)
    Clearply()
    ESPStatsply = Stats
    track = true
    spawn(
        function()
            while wait(0.1) do
                if track then
                    -- Clear()
                    for _, v in pairs(game.Players:GetChildren()) do
                        if v.Team == nil then

                        else
                            if v.Character and v.Character:FindFirstChild("Head") then
                                if ESPStatsply then
                                    Create(v.Character.Head, true,v)
                                elseif not ESPStatsply then
                                    Clearply()
                                end
                            end
                        end 
                    end
                end
                wait(15)
            end
        end
    )
    spawn(
        function()
            while wait(15) do
                if track then
                    if ESPStatsply then
                        Clearply()
                    end
                end
            end
        end
    )
end

local Chest = math.random(1, 50)
function CreateChest(base)
    local bb = Instance.new("BillboardGui", game.CoreGui)
    bb.Adornee = base
    bb.ExtentsOffset = Vector3.new(0, 1, 0)
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 5, 0, 5)
    bb.StudsOffset = Vector3.new(0, 1, 0)
    bb.Name = "Chest"..Chest
    local frame = Instance.new("Frame", bb)
    frame.ZIndex = 10
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    local txtlbl = Instance.new("TextLabel", bb)
    txtlbl.ZIndex = 10
    txtlbl.BackgroundTransparency = 1
    txtlbl.Position = UDim2.new(0, 0, 0, -35)
    txtlbl.Size = UDim2.new(1, 0, 10, 0)
    txtlbl.Font = "GothamBold"
    txtlbl.FontSize = "Size18"
    txtlbl.Text = base.Parent.Name:upper()
    txtlbl.TextStrokeTransparency = 0.5
    if base.Name == "Chest1" then
        txtlbl.TextColor3 = Color3.fromRGB(109, 109, 109)
        txtlbl.Text = "Chest 1"
    end
    if base.Name == "Chest2" then
        txtlbl.TextColor3 = Color3.fromRGB(173, 158, 21)
        txtlbl.Text = "Chest 2"
    end
    if base.Name == "Chest3" then
        txtlbl.TextColor3 = Color3.fromRGB(85, 255, 255)
        txtlbl.Text = "Chest 3"
    end
end
function ClearChest()
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "Chest"..Chest then
            v:Destroy()
        end
    end 
end
function FindChest(Stats)
    Clearply()
    ESPStatsChest = Stats
    track = true
    spawn(
        function()
            while wait(1) do
                if track then
                    -- Clear()
                    for _, v in pairs(game.Workspace:GetChildren()) do
                        if string.find(v.Name, "Chest") then    
                            if v:IsA("Part") then
                                if ESPStatsChest then
                                    CreateChest(v)
                                elseif not ESPStatsChest then
                                    ClearChest()
                                end
                            end
                        end
                    end
                end
                wait(15)
            end
        end
    )
    spawn(
        function()
            while wait(15) do
                if track then
                    if ESPStatsChest then
                        ClearChest()
                    end
                end
            end
        end
    )
end

local DevilFruit = math.random(1, 50)
function CreateDevilFruit(base)
    local bb = Instance.new("BillboardGui", game.CoreGui)
    bb.Adornee = base.Handle
    bb.ExtentsOffset = Vector3.new(0, 1, 0)
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 5, 0, 5)
    bb.StudsOffset = Vector3.new(0, 1, 0)
    bb.Name = "DevilFruit"..DevilFruit
    local frame = Instance.new("Frame", bb)
    frame.ZIndex = 10
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    local txtlbl = Instance.new("TextLabel", bb)
    txtlbl.ZIndex = 10
    txtlbl.BackgroundTransparency = 1
    txtlbl.Position = UDim2.new(0, 0, 0, -35)
    txtlbl.Size = UDim2.new(1, 0, 10, 0)
    txtlbl.Font = "GothamBold"
    txtlbl.FontSize = "Size18"
    txtlbl.Text = base.Name
    txtlbl.TextColor3 = Color3.fromRGB(255, 0, 0)
    txtlbl.TextStrokeTransparency = 0.5
end
function ClearDevilFruit()
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "DevilFruit"..DevilFruit then
            v:Destroy()
        end
    end 
end
function FindDevilFruit(Stats)
    ClearDevilFruit()
    ESPStatsDevilFruit = Stats
    track = true
    spawn(
        function()
            while wait(0.1) do
                if track then
                    -- Clear()
                    for _, v in pairs(game.Workspace:GetChildren()) do
                        if string.find(v.Name, "Fruit") then   
                            if v:IsA("Tool") then 
                                if ESPStatsDevilFruit then
                                    CreateDevilFruit(v)
                                elseif not ESPStatsDevilFruit then
                                    ClearDevilFruit()
                                end
                            end
                            if v:IsA("Model") then
                                if ESPStatsDevilFruit then
                                    CreateDevilFruit(v)
                                elseif not ESPStatsDevilFruit then
                                    ClearDevilFruit()
                                end
                            end
                        end 
                    end
                end
                wait(15)
            end
        end
    )
    spawn(
        function()
            while wait(15) do
                if track then
                    if ESPStatsDevilFruit then
                        ClearDevilFruit()
                    end
                end
            end
        end
    )
end

local Flower = math.random(1, 50)
function CreateFlower(base)
    local bb = Instance.new("BillboardGui", game.CoreGui)
    bb.Adornee = base
    bb.ExtentsOffset = Vector3.new(0, 1, 0)
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 5, 0, 5)
    bb.StudsOffset = Vector3.new(0, 1, 0)
    bb.Name = "Flower"..Flower
    local frame = Instance.new("Frame", bb)
    frame.ZIndex = 10
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    local txtlbl = Instance.new("TextLabel", bb)
    txtlbl.ZIndex = 10
    txtlbl.BackgroundTransparency = 1
    txtlbl.Position = UDim2.new(0, 0, 0, -35)
    txtlbl.Size = UDim2.new(1, 0, 10, 0)
    txtlbl.Font = "GothamBold"
    txtlbl.FontSize = "Size18"
    txtlbl.Text = base.Parent.Name:upper()
    txtlbl.TextStrokeTransparency = 0.5
    if base.Name == "Flower1" then 
        txtlbl.Text = "Blue Flower"
        txtlbl.TextColor3 = Color3.fromRGB(0, 0, 255)
    end
    if base.Name == "Flower2" then
        txtlbl.Text = "Red Flower"
        txtlbl.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end
function ClearFlower()
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "Flower"..Flower then
            v:Destroy()
        end
    end 
end
function FindFlower(Stats)
    Clearply()
    FlowerESPStats = Stats
    track = true
    spawn(
        function()
            while wait(0.1) do
                if track then
                    -- Clear()
                    for _, v in pairs(game.Workspace:GetChildren()) do
                        if string.find(v.Name, "Flower") then   
                            if FlowerESPStats then
                                CreateFlower(v)
                            elseif not FlowerESPStats then
                                ClearFlower()
                            end
                        end
                    end
                end
                wait(15)
            end
        end
    )
    spawn(
        function()
            while wait(15) do
                if track then
                    if FlowerESPStats then
                        ClearFlower()
                    end
                end
            end
        end
    )
end

Esp:Toggle("ESP Player","",false,function(Value)
    PLYESP = Value
    Findply(PLYESP)
end)
Esp:Toggle("ESP Chest","",false,function(Value)
    ChestESP = Value
    FindChest(ChestESP)
end)
Esp:Toggle("ESP Devil Fruit","",false,function(Value)
    DevilFruitESP = Value
    FindDevilFruit(DevilFruitESP)
end)
Esp:Toggle("ESP Flower","",false,function(Value)
    FlowerESP = Value
    FindFlower(FlowerESP)
end)
local Players = win:Tab("Players", "http://www.roblox.com/asset/?id=6023426915")
local SelectedPly = Players:Label("Selected Player : nil")
PlayerName = {}
for i,v in pairs(game.Players:GetChildren()) do  
    table.insert(PlayerName ,v.Name)
end
local Player = Players:Dropdown("Selected Player",PlayerName,function(plys) --true/false, replaces the current title "Dropdown" with the option that t
    KillPlayer = plys
    SelectedPly:Refresh(plys)
end)

Players:Button("Refrsh Player","",function()
    PlayerName = {}
    for i,v in pairs(game.Players:GetChildren()) do  
        table.insert(PlayerName ,v.Name)
    end
    Player:Refresh(PlayerName)
end)

Players:Toggle("Kill Player","",false,function(bool)
    pk = bool
    local plr1 = game.Players.LocalPlayer.Character
    local plr2 = game.Players:FindFirstChild(KillPlayer)
    repeat wait()
        plr1.HumanoidRootPart.CFrame = plr2.Character.HumanoidRootPart.CFrame*CFrame.new(0, 0, 5)
        plr2.Character.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
        Click()
    until pk == false
    plr2.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
end)

Players:Toggle("Spectate Player","",false,function(bool)
    Sp = bool
    local plr1 = game.Players.LocalPlayer.Character.Humanoid
    local plr2 = game.Players:FindFirstChild(KillPlayer)
    repeat wait()
        game.Workspace.Camera.CameraSubject = plr2.Character.Humanoid
    until Sp == false 
    game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)

Players:Button("Telepoet Player","",function()
    local plr1 = game.Players.LocalPlayer.Character
    local plr2 = game.Players:FindFirstChild(KillPlayer)
    plr1.HumanoidRootPart.CFrame = plr2.Character.HumanoidRootPart.CFrame
end)
local Misc = win:Tab("Misc", "http://www.roblox.com/asset/?id=6023426915")
local LocalPlayer = game:GetService'Players'.LocalPlayer
local originalstam = LocalPlayer.Character.Energy.Value
function infinitestam()
    LocalPlayer.Character.Energy.Changed:connect(function()
        if InfinitsEnergy then
            LocalPlayer.Character.Energy.Value = originalstam
        end 
    end)
end
spawn(function()
    while wait() do
        if InfinitsEnergy then
            wait(0.3)
            originalstam = LocalPlayer.Character.Energy.Value
            infinitestam()
        end
    end
end)
nododgecool = false
function NoDodgeCool()
    if nododgecool then
        for i,v in next, getgc() do
            if game.Players.LocalPlayer.Character.Dodge then
                if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character.Dodge then
                    for i2,v2 in next, getupvalues(v) do
                        if tostring(v2) == "0.4" then
                            repeat wait()
                                setupvalue(v,i2,0)
                            until not nododgecool
                        end
                    end
                end
            end
        end
    end
end
Misc:Toggle("Dodge No Cooldown","",false,function(Value)
    nododgecool = Value
    NoDodgeCool()
end)
Misc:Toggle("Infinits Energy","",false,function(value)
    InfinitsEnergy = value
    originalstam = LocalPlayer.Character.Energy.Value
end)
Misc:Toggle("Auto Click","",false,function(value)
    AuctoClick = value
end)
spawn(function()
    while wait() do
        if AuctoClick then
            Click()
        end
    end
end)
Misc:Toggle("Framing Mode : Magnet","",true,function(Value)
    if Value then
        Test = "Magnet" 
    else
        Test = "Back" 
    end   
end)
local Fruit = win:Tab("Devil Fruit", "http://www.roblox.com/asset/?id=6023426915")
SelectDevil = ""
Check = false
Fruit:Dropdown(
    "Devil Fruit Sniper",
    {
        "Bomb-Bomb",
        "Spike-Spike",
        "Chop-Chop",
        "Spring-Spring",
        "Smoke-Smoke",
        "Flame-Flame",
        "Ice-Ice",
        "Sand-Sand",
        "Dark-Dark",
        "Light-Light",
        "Rubber-Rubber",
        "Barrier-Barrier",
        "Magma-Magma",
        "Quake-Quake",
        "Human-Human: Buddha",
        "String-String",
        "Bird-Bird: Phoenix",
        "Rumble-Rumble",
        "Paw-Paw",
        "Gravity-Gravity",
        "Dough-Dough",
        "Control-Control",
        "Dragon-Dragon"
            }
    ,function(ply)
        SelectDevil = ply
    end
)
Fruit:Toggle("Buy Devil Fruit Sinper","",false,function(value)
    Check = value
    if SelectDevil == "" and Check then
        Library:Notification("Select DF","Please Select Devil Fruit to Sniper Buy First","Button")
    elseif SelectDevil == SelectDevil and Check then
        BuyFruitSinper = Check
    end
end)
local BuyItem = win:Tab("Buy Item", "http://www.roblox.com/asset/?id=6023426915")
BuyItem:Label("Candies Shop",true)
BuyItem:Button("x2 EXP 20 mins","",function()
    local args = {
        [1] = "Candies",
        [2] = "Buy",
        [3] = 1,
        [4] = 1
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Button("Stats Refund","",function()
    local args = {
        [1] = "Candies",
        [2] = "Buy",
        [3] = 1,
        [4] = 2
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Button("Race Reroll","",function()
    local args = {
        [1] = "Candies",
        [2] = "Buy",
        [3] = 1,
        [4] = 3
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Button("Elf Hat","",function()
    local args = {
        [1] = "Candies",
        [2] = "Buy",
        [3] = 3,
        [4] = 1
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Button("Santa Hat","",function()
    local args = {
        [1] = "Candies",
        [2] = "Buy",
        [3] = 3,
        [4] = 2
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Button("Sleigh","",function()
    local args = {
        [1] = "Candies",
        [2] = "Buy",
        [3] = 3,
        [4] = 3
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
if newworld then
    BuyItem:Label("Candies Shop [Fragments]")
    BuyItem:Button("500 Fragments","",function()
        local args = {
            [1] = "Candies",
            [2] = "Buy",
            [3] = 2,
            [4] = 1
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
    BuyItem:Button("1500 Fragments","",function()
        local args = {
            [1] = "Candies",
            [2] = "Buy",
            [3] = 2,
            [4] = 2
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
end
BuyItem:Label("Abilities")
BuyItem:Button("Skyjump","",function()
    local args = {
        [1] = "BuyHaki",
        [2] = "Geppo"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Button("Buso Haki","",function()
    local args = {
        [1] = "BuyHaki",
        [2] = "Buso"
    }

    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Button("Soru","",function()
    local args = {
        [1] = "BuyHaki",
        [2] = "Soru"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Label("Fighting Style")
BuyItem:Button("Black Leg","",function()
    local args = {
        [1] = "BuyBlackLeg"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Button("Electro","",function()
    local args = {
        [1] = "BuyElectro"
    }
    
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
BuyItem:Button("Fishman Karate","",function()
    local args = {
        [1] = "BuyFishmanKarate"
    }
    
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
if newworld then
    BuyItem:Button("Dragon Claw","",function()
        local args = {
            [1] = "BlackbeardReward",
            [2] = "DragonClaw",
            [3] = "1"
        }

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        local args = {
            [1] = "BlackbeardReward",
            [2] = "DragonClaw",
            [3] = "2"
        }

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
    BuyItem:Button("Superhuman","",function()
        local args = {
            [1] = "BuySuperhuman"
        }
        
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
    BuyItem:Button("Death Step","",function()
        local args = {
            [1] = "BuyDeathStep"
        }
        
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end)
end
