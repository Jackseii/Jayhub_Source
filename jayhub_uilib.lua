local Library = {}

local Data = game:GetService("HttpService"):JSONDecode(http_request({Url="https://raw.githubusercontent.com/Jack1214060/Jayhub_Source/Master/Data.json",Method="GET"}).Body)

function Library:CreateMain()

    local JayHub = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local SideBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Version = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local TabFrame = Instance.new("Frame")
    local TabUIGridLayout = Instance.new("UIGridLayout")
    local Tabs = Instance.new("Folder")


    local MainUICorner = Instance.new("UICorner")
    local Containers = Instance.new("Folder")

    JayHub.Name = "JayHub"
    JayHub.Parent = game.CoreGui
    JayHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = JayHub
    Main.Visible = false
    Main.BackgroundColor3 = Color3.fromRGB(56, 59, 66)
    Main.BorderColor3 = Color3.fromRGB(27, 42, 53)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.5, -353, 0.5, -242)
    Main.Size = UDim2.new(0, 643, 0, 407)

    SideBar.Name = "SideBar"
    SideBar.Parent = Main
    SideBar.BackgroundColor3 = Color3.fromRGB(50, 53, 59)
    SideBar.BorderSizePixel = 0
    SideBar.Size = UDim2.new(0, 178, 0, 407)

    Title.Name = "Title"
    Title.Parent = SideBar
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.1557789, 0, 0, 0)
    Title.Size = UDim2.new(0, 169, 0, 50)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = "JayHub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 28.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Version.Name = "Version"
    Version.Parent = SideBar
    Version.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Version.BackgroundTransparency = 1.000
    Version.Position = UDim2.new(0.156000003, 0, 0.0850000009, 0)
    Version.Size = UDim2.new(0, 98, 0, 17)
    Version.Font = Enum.Font.Gotham
    Version.Text = Data["version"]
    Version.TextColor3 = Color3.fromRGB(214, 214, 214)
    Version.TextSize = 14.000
    Version.TextXAlignment = Enum.TextXAlignment.Left

    UICorner.Parent = SideBar

    TabFrame.Name = "TabFrame"
    TabFrame.Parent = SideBar
    TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabFrame.BackgroundTransparency = 1.000
    TabFrame.Position = UDim2.new(0, 0, 0.130165294, 0)
    TabFrame.Size = UDim2.new(0, 199, 0, 421)

    Tabs.Name = "Tabs"
    Tabs.Parent = TabFrame

    MainUICorner.Name = "MainUICorner"
    MainUICorner.Parent = Main

    Containers.Name = "Containers"
    Containers.Parent = Main

    TabFrame.Name = "TabFrame"
    TabFrame.Parent = SideBar
    TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabFrame.BackgroundTransparency = 1.000
    TabFrame.Position = UDim2.new(0, 0, 0.130165294, 0)
    TabFrame.Size = UDim2.new(0, 199, 0, 421)

    TabUIGridLayout.Name = "TabUIGridLayout"
    TabUIGridLayout.Parent = Tabs
    TabUIGridLayout.FillDirection = Enum.FillDirection.Vertical
    TabUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabUIGridLayout.CellPadding = UDim2.new(0, 5, 0, 3)
    TabUIGridLayout.CellSize = UDim2.new(0, 178, 0, 37)


    --Plugin Glitch Fix
    MainUICorner.CornerRadius = UDim.new(0, 8)
    --

    function dragify(Frame)
        dragToggle = nil
        dragSpeed = .25
        dragInput = nil
        dragStart = nil
        dragPos = nil
        
        function updateInput(input)
        Delta = input.Position - dragStart
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        game:GetService("TweenService"):Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
        end
        
        Frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragToggle = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
        if (input.UserInputState == Enum.UserInputState.End) then
        dragToggle = false
        end
        end)
        end
        end)
        
        Frame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
        end
        end)
        
        game:GetService("UserInputService").InputChanged:Connect(function(input)
        if (input == dragInput and dragToggle) then
        updateInput(input)
        end
        end)
        end
    
    dragify(Main)

    
    local JayHub_Downloader = Instance.new("ScreenGui")
    local DownloaderMainFrame = Instance.new("Frame")
    local MainUICorner = Instance.new("UICorner")
    local DownloaderTitleFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local MainUICorner_2 = Instance.new("UICorner")
    local Credits1 = Instance.new("TextLabel")
    local Credits2 = Instance.new("TextLabel")
    local Credits3 = Instance.new("TextLabel")
    
    --Properties:
    
    JayHub_Downloader.Name = "JayHub_Downloader"
    JayHub_Downloader.Parent = game.CoreGui
    JayHub_Downloader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    DownloaderMainFrame.Name = "DownloaderMainFrame"
    DownloaderMainFrame.Parent = JayHub_Downloader
    DownloaderMainFrame.BackgroundColor3 = Color3.fromRGB(56, 59, 66)
    DownloaderMainFrame.BorderSizePixel = 0
    DownloaderMainFrame.ClipsDescendants = true
    DownloaderMainFrame.Position = UDim2.new(0.5, -102, 0.5, -36)
    DownloaderMainFrame.Size = UDim2.new(0, 204, 0, 72)
    
    MainUICorner.Name = "MainUICorner"
    MainUICorner.Parent = DownloaderMainFrame
    
    DownloaderTitleFrame.Name = "DownloaderTitleFrame"
    DownloaderTitleFrame.Parent = DownloaderMainFrame
    DownloaderTitleFrame.BackgroundColor3 = Color3.fromRGB(50, 53, 59)
    DownloaderTitleFrame.BorderSizePixel = 0
    DownloaderTitleFrame.Size = UDim2.new(0, 204, 0, 23)
    
    Title.Name = "Title"
    Title.Parent = DownloaderTitleFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.116563082, 0, 0, 0)
    Title.Size = UDim2.new(0, 155, 0, 23)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = "JayHub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 17.000
    
    MainUICorner_2.Name = "MainUICorner"
    MainUICorner_2.Parent = DownloaderTitleFrame
    
    Credits1.Name = "Credits1"
    Credits1.Parent = DownloaderMainFrame
    Credits1.Visible = false
    Credits1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Credits1.BackgroundTransparency = 1.000
    Credits1.Position = UDim2.new(0.116563082, 0, 0.311815321, 0)
    Credits1.Size = UDim2.new(0, 155, 0, 23)
    Credits1.Font = Enum.Font.GothamSemibold
    Credits1.Text = "Created by "
    Credits1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Credits1.TextSize = 12.000
    
    Credits2.Name = "Credits2"
    Credits2.Parent = DownloaderMainFrame
    Credits2.Visible = false
    Credits2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Credits2.BackgroundTransparency = 1.000
    Credits2.Position = UDim2.new(0.116563082, 0, 0.481416315, 0)
    Credits2.Size = UDim2.new(0, 155, 0, 23)
    Credits2.Font = Enum.Font.GothamSemibold
    Credits2.Text = "Jack1214060#5890"
    Credits2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Credits2.TextSize = 10.000
    
    Credits3.Name = "Credits3"
    Credits3.Parent = DownloaderMainFrame
    Credits3.Visible = false
    Credits3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Credits3.BackgroundTransparency = 1.000
    Credits3.Position = UDim2.new(0.116563082, 0, 0.675860703, 0)
    Credits3.Size = UDim2.new(0, 155, 0, 23)
    Credits3.Font = Enum.Font.GothamSemibold
    Credits3.Text = "iFergggg#0328"
    Credits3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Credits3.TextSize = 10.000



    function StartUp()
        DownloaderMainFrame.Size = UDim2.new(0, 0, 0, 0)
        DownloaderMainFrame.Visible = true
        DownloaderMainFrame:TweenSize(UDim2.new(0, 204, 0, 23),  Enum.EasingDirection.Out,  Enum.EasingStyle.Quint, 0.5, true)  
        wait(1)
        DownloaderMainFrame:TweenSize(UDim2.new(0, 204, 0, 72),  Enum.EasingDirection.Out,  Enum.EasingStyle.Quint, 0.5, true)
        wait(0.1)
        Credits1.Visible = true
        Credits2.Visible = true 
        Credits3.Visible = true
        wait(2)
        Credits1.Visible = false
        Credits2.Visible = false
        Credits3.Visible = false
        DownloaderMainFrame:TweenSize(UDim2.new(0, 0, 0, 0),  Enum.EasingDirection.Out,  Enum.EasingStyle.Quint, 0.5, true)
        wait(0.6)
        DownloaderMainFrame.Visible = false
        Main.Size = UDim2.new(0, 0, 0, 0)
        Main.Visible = true
        Main:TweenSize(UDim2.new(0, 643, 0, 407),  Enum.EasingDirection.Out,  Enum.EasingStyle.Quint, 0.5, true)
        game.StarterGui:SetCore("SendNotification", {
            Title = "JayHub";
            Text = "Press Right Shift to Open/Close";
            Duration = 3;
        })
    end

    StartUp()
    local Gui_Open = true
    local UserInputService = game:GetService("UserInputService")

    UserInputService.InputBegan:Connect(function(input)
        if UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
            if Gui_Open == true then
                Gui_Open = false
                Main:TweenSize(UDim2.new(0, 0, 0, 0),  Enum.EasingDirection.Out,  Enum.EasingStyle.Quint, 0.5, true)                   
            elseif Gui_Open == false then
                Gui_Open = true
                Main:TweenSize(UDim2.new(0, 643, 0, 407),  Enum.EasingDirection.Out,  Enum.EasingStyle.Quint, 0.5, true)    
            end
        end
    end)
    local InsideLibrary = {}

    function InsideLibrary:CreateTab(name, selected)
        scrollable = scrollable or false
        selected = selected or false
        local Tab_678 = Instance.new("TextButton")
        local TabTextLabel_678 = Instance.new("TextLabel")
        local Container_123 = Instance.new("ScrollingFrame")
        local ContainerUIGridLayout_123 = Instance.new("UIGridLayout")

        Tab_678.Name = name.."Tab_678"
        Tab_678.Parent = Tabs
        Tab_678.BackgroundColor3 = Color3.fromRGB(50, 53, 59)
        Tab_678.BorderSizePixel = 0
        Tab_678.Size = UDim2.new(0, 178, 0, 37)
        Tab_678.Font = Enum.Font.Gotham
        Tab_678.Text = ""
        Tab_678.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab_678.TextSize = 14.000
        Tab_678.TextXAlignment = Enum.TextXAlignment.Left
        
        TabTextLabel_678.Name = "TabTextLabel_678"
        TabTextLabel_678.Parent = Tab_678
        TabTextLabel_678.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTextLabel_678.BackgroundTransparency = 1.000
        TabTextLabel_678.BorderSizePixel = 0
        TabTextLabel_678.Position = UDim2.new(0.155000001, 0, 0, 0)
        TabTextLabel_678.Size = UDim2.new(0, 169, 0, 36)
        TabTextLabel_678.Font = Enum.Font.Gotham
        TabTextLabel_678.Text = name
        TabTextLabel_678.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabTextLabel_678.TextSize = 17.000
        TabTextLabel_678.TextXAlignment = Enum.TextXAlignment.Left

        Container_123.Name = name.."Container_123"
        Container_123.Parent = Containers
        Container_123.Active = true
        Container_123.Visible = selected
        Container_123.BackgroundColor3 = Color3.fromRGB(56, 59, 66)
        Container_123.BorderSizePixel = 0
        Container_123.Position = UDim2.new(0.28186965, 0, 0.0309917629, 0)
        Container_123.Size = UDim2.new(0, 453, 0, 380)
        Container_123.ScrollBarThickness = 7
        Container_123.CanvasSize = UDim2.new(0, 0, 0, 0)
        


        ContainerUIGridLayout_123.Name = "ContainerUIGridLayout_123"
        ContainerUIGridLayout_123.Parent = Container_123
        ContainerUIGridLayout_123.FillDirection = Enum.FillDirection.Vertical
        ContainerUIGridLayout_123.HorizontalAlignment = Enum.HorizontalAlignment.Center
        ContainerUIGridLayout_123.SortOrder = Enum.SortOrder.LayoutOrder
        ContainerUIGridLayout_123.CellPadding = UDim2.new(0, 10, 0, 10)
        ContainerUIGridLayout_123.CellSize = UDim2.new(0, 426, 0, 38)
        ContainerUIGridLayout_123.FillDirectionMaxCells = 500


        Tab_678.AutoButtonColor = false
        if selected == true then
            Tab_678.BackgroundColor3 = Color3.fromRGB(232, 120, 35)
            Container_123.Visible = true
        end
        local changeSpeed = 0.3

        Tab_678.MouseButton1Click:Connect(function()
            for i, v in next, Tabs:GetChildren() do
                if v.name ~= "TabUIGridLayout" then
                    if v.BackgroundColor3 ~= Color3.fromRGB(50, 53, 59) then
                        local tw = game.TweenService:Create(v, TweenInfo.new(changeSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), { BackgroundColor3 = Color3.fromRGB(50, 53, 59) })
                        tw:Play()
                    end
                end
            end
            for i, v in next, Containers:GetChildren() do
                if v.name ~= "ContainerUIGridLayout_123" then
                    v.Visible = false
                end
            end    

            local tw = game.TweenService:Create(Tab_678, TweenInfo.new(changeSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), { BackgroundColor3 = Color3.fromRGB(232, 120, 35) })
            tw:Play()
            Container_123.Visible = true
        end)

        Container_123.ChildAdded:Connect(function()
            local ContentSize = Container_123.ContainerUIGridLayout_123.AbsoluteContentSize.Y
            Container_123.CanvasSize = UDim2.new(0, 0, 0, (ContentSize + 48))
        end)
    
        return Container_123;
    end

    function InsideLibrary:CreateButton(text, parent, callback)
        local callback = callback or function() end
        local Button_234 = Instance.new("Frame")
        local TextButton_234 = Instance.new("TextButton")
        local ButtonTextLabel_234 = Instance.new("TextLabel")
        local ButtonCircle_234 = Instance.new("Frame")
        local ButtonUICorner_234 = Instance.new("UICorner")
        local UICorner_234 = Instance.new("UICorner")
        local ButtonCircle = Instance.new("Frame")
        local ButtonCircleUICorner = Instance.new("UICorner")
        local ButtonFix = Instance.new("ImageLabel")

        Button_234.Name = text.."Button_234"
        Button_234.Parent = parent
        Button_234.BackgroundColor3 = Color3.fromRGB(71, 75, 84)
        Button_234.ClipsDescendants = true
        Button_234.Position = UDim2.new(0.0433924571, 0, 0.0796896964, 0)
        Button_234.Size = UDim2.new(0, 426, 0, 38)
        
        ButtonUICorner_234.CornerRadius = UDim.new(0, 10)
        ButtonUICorner_234.Name = "ButtonUICorner_234"
        ButtonUICorner_234.Parent = Button_234
        
        TextButton_234.Name = "TextButton_234"
        TextButton_234.Parent = Button_234
        TextButton_234.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextButton_234.BackgroundTransparency = 1.000
        TextButton_234.BorderSizePixel = 0
        TextButton_234.Size = UDim2.new(0, 425, 0, 35)
        TextButton_234.Font = Enum.Font.SourceSans
        TextButton_234.Text = ""
        TextButton_234.TextColor3 = Color3.fromRGB(0, 0, 0)
        TextButton_234.TextSize = 14.000
        
        ButtonTextLabel_234.Name = "ButtonTextLabel_234"
        ButtonTextLabel_234.Parent = TextButton_234
        ButtonTextLabel_234.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonTextLabel_234.BackgroundTransparency = 1.000
        ButtonTextLabel_234.BorderSizePixel = 0
        ButtonTextLabel_234.Position = UDim2.new(0.0686605126, 0, 0.054385975, 0)
        ButtonTextLabel_234.Size = UDim2.new(0, 206, 0, 33)
        ButtonTextLabel_234.Font = Enum.Font.Gotham
        ButtonTextLabel_234.Text = text
        ButtonTextLabel_234.TextColor3 = Color3.fromRGB(255, 255, 255)
        ButtonTextLabel_234.TextSize = 17.000
        ButtonTextLabel_234.TextXAlignment = Enum.TextXAlignment.Left
        
        ButtonCircle_234.Name = "ButtonCircle_234"
        ButtonCircle_234.Parent = TextButton_234
        ButtonCircle_234.BackgroundColor3 = Color3.fromRGB(227, 227, 227)
        ButtonCircle_234.Position = UDim2.new(0.0219999999, 0, 0.371428579, 0)
        ButtonCircle_234.Size = UDim2.new(0, 12, 0, 12)

        ButtonUICorner_234.CornerRadius = UDim.new(0, 10)
        ButtonUICorner_234.Name = "ButtonUICorner_234"
        ButtonUICorner_234.Parent = Button_234

        UICorner_234.CornerRadius = UDim.new(50, 50)
        UICorner_234.Name = "UICorner_234"
        UICorner_234.Parent = ButtonCircle_234

        ButtonCircle.Name = "ButtonCircle"
        ButtonCircle.Parent = Button_234
        ButtonCircle.AnchorPoint = Vector2.new(0.5, 0.5)
        ButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonCircle.BackgroundTransparency = 1.000
        ButtonCircle.Position = UDim2.new(0.494131446, 0, 0.5468027, 0)
        ButtonCircle.Size = UDim2.new(0, 30, 0, 30)

        ButtonCircleUICorner.CornerRadius = UDim.new(0, 100)
        ButtonCircleUICorner.Name = "ButtonCircleUICorner"
        ButtonCircleUICorner.Parent = ButtonCircle

        ButtonFix.Name = "ButtonFix"
        ButtonFix.Parent = Button_234
        ButtonFix.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonFix.BackgroundTransparency = 1.000
        ButtonFix.BorderSizePixel = 0
        ButtonFix.Position = UDim2.new(0, 0, -0.105263159, 0)
        ButtonFix.Size = UDim2.new(0, 429, 0, 46)
        ButtonFix.Image = "rbxassetid://6537818159"
        

        TextButton_234.MouseButton1Click:Connect(function(x, y)
            local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local x = Mouse.X
            local y = Mouse.Y
            local pos = UDim2.new(0,x-TextButton_234.AbsolutePosition.X,0,y-TextButton_234.AbsolutePosition.Y)
            ButtonCircle.Position = pos
            ButtonCircle.Size = UDim2.new(0,1,0,1)
            ButtonCircle.Transparency = .5
            
            local goal = {}
            goal.Size = UDim2.new(0,500,0,500)
            goal.Transparency = 1
            
            local tween = game.TweenService:Create(ButtonCircle, TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.Out), goal)
            tween:Play()
            pcall(callback)

        end)

    end

    function InsideLibrary:CreateLabel(text, parent)
        local Label_345 = Instance.new("Frame")
        local LabelUICorner_345 = Instance.new("UICorner")
        local LabelTextLabel_345 = Instance.new("TextLabel")

        Label_345.Name = text.." Label_345"
        Label_345.Parent = parent
        Label_345.BackgroundColor3 = Color3.fromRGB(71, 75, 84)
        Label_345.ClipsDescendants = true
        Label_345.Position = UDim2.new(0.0433925055, 0, 0.0247893538, 0)
        Label_345.Size = UDim2.new(0, 463, 0, 38)

        LabelUICorner_345.CornerRadius = UDim.new(0, 10)
        LabelUICorner_345.Name = "LabelUICorner_345"
        LabelUICorner_345.Parent = Label_345

        LabelTextLabel_345.Name = "LabelTextLabel_345"
        LabelTextLabel_345.Parent = Label_345
        LabelTextLabel_345.Text = text
        LabelTextLabel_345.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LabelTextLabel_345.BackgroundTransparency = 1.000
        LabelTextLabel_345.BorderSizePixel = 0
        LabelTextLabel_345.Position = UDim2.new(0.0341032781, 0, 0.054385975, 0)
        LabelTextLabel_345.Size = UDim2.new(0, 206, 0, 33)
        LabelTextLabel_345.Font = Enum.Font.Gotham
        LabelTextLabel_345.TextColor3 = Color3.fromRGB(255, 255, 255)
        LabelTextLabel_345.TextSize = 17.000
        LabelTextLabel_345.TextXAlignment = Enum.TextXAlignment.Left

        return LabelTextLabel_345;
    end

    function InsideLibrary:CreateTextbox(text, placeholder, cleartextbox, parent, callback)
        cleartextbox = cleartextbox or false
        local TextBox_456 = Instance.new("Frame")
        local TextBoxUICorner_456 = Instance.new("UICorner")
        local TextBoxTextLabel_456 = Instance.new("TextLabel")
        local TextBoxTextBox_456 = Instance.new("TextBox")
        local UICorner_456 = Instance.new("UICorner")

        TextBox_456.Name = text.."TextBox_456"
        TextBox_456.Parent = parent
        TextBox_456.BackgroundColor3 = Color3.fromRGB(71, 75, 84)
        TextBox_456.ClipsDescendants = true
        TextBox_456.Position = UDim2.new(0.0433925055, 0, 0.0247893538, 0)
        TextBox_456.Size = UDim2.new(0, 463, 0, 38)
        
        TextBoxUICorner_456.CornerRadius = UDim.new(0, 10)
        TextBoxUICorner_456.Name = "TextBoxUICorner_456"
        TextBoxUICorner_456.Parent = TextBox_456
        
        TextBoxTextLabel_456.Name = "TextBoxTextLabel_456"
        TextBoxTextLabel_456.Parent = TextBox_456
        TextBoxTextLabel_456.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextBoxTextLabel_456.BackgroundTransparency = 1.000
        TextBoxTextLabel_456.BorderSizePixel = 0
        TextBoxTextLabel_456.Position = UDim2.new(0.0341032781, 0, 0.054385975, 0)
        TextBoxTextLabel_456.Size = UDim2.new(0, 206, 0, 33)
        TextBoxTextLabel_456.Font = Enum.Font.Gotham
        TextBoxTextLabel_456.Text = text
        TextBoxTextLabel_456.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBoxTextLabel_456.TextSize = 17.000
        TextBoxTextLabel_456.TextXAlignment = Enum.TextXAlignment.Left
        
        TextBoxTextBox_456.Name = "TextBoxTextBox_456"
        TextBoxTextBox_456.Parent = TextBox_456
        TextBoxTextBox_456.BackgroundColor3 = Color3.fromRGB(62, 66, 74)
        TextBoxTextBox_456.BorderSizePixel = 0
        TextBoxTextBox_456.Position = UDim2.new(0.494999975, 0, 0, 0)
        TextBoxTextBox_456.Size = UDim2.new(0, 215, 0, 38)
        TextBoxTextBox_456.Font = Enum.Font.Gotham
        TextBoxTextBox_456.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
        TextBoxTextBox_456.PlaceholderText = placeholder
        TextBoxTextBox_456.Text = ""
        TextBoxTextBox_456.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBoxTextBox_456.TextSize = 14.000
        
        UICorner_456.CornerRadius = UDim.new(0, 10)
        UICorner_456.Name = "UICorner_456"
        UICorner_456.Parent = TextBoxTextBox_456

        local value = TextBoxTextBox_456.Text

        TextBoxTextBox_456.FocusLost:Connect(function(enterPressed)
            value = TextBoxTextBox_456.Text
            if enterPressed then
                pcall(callback, value)
                if cleartextbox == true then
                    TextBoxTextBox_456.Text = ""
                end
            end
        end)

        return TextBoxTextBox_456;


    end

    function InsideLibrary:CreateToggle(text, parent, callback)
        local enabled = false
        local actions = {}
        text = text or "New Toggle"
        callback = callback or function() end
        local Toggle_567 = Instance.new("Frame")
        local ToggleTextButton_567 = Instance.new("TextButton")
        local TextLabel_567 = Instance.new("TextLabel")
        local ToggleLineFrame = Instance.new("Frame")
        local ToggleFrameUi = Instance.new("UICorner")
        local ToggleCircle = Instance.new("Frame")
        local ToggleCircleUi = Instance.new("UICorner")
        local ToggleUICorner_567 = Instance.new("UICorner")

        Toggle_567.Name = text.."Toggle_567"
        Toggle_567.Parent = parent
        Toggle_567.BackgroundColor3 = Color3.fromRGB(71, 75, 84)
        Toggle_567.ClipsDescendants = true
        Toggle_567.Position = UDim2.new(0.0433925055, 0, 0.0247893538, 0)
        Toggle_567.Size = UDim2.new(0, 463, 0, 38)
        
        ToggleTextButton_567.Name = "ToggleTextButton_567"
        ToggleTextButton_567.Parent = Toggle_567
        ToggleTextButton_567.Active = false
        ToggleTextButton_567.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleTextButton_567.BackgroundTransparency = 1.000
        ToggleTextButton_567.BorderSizePixel = 0
        ToggleTextButton_567.Size = UDim2.new(0, 427, 0, 35)
        ToggleTextButton_567.Font = Enum.Font.SourceSans
        ToggleTextButton_567.Text = ""
        ToggleTextButton_567.TextColor3 = Color3.fromRGB(0, 0, 0)
        ToggleTextButton_567.TextSize = 14.000
        
        TextLabel_567.Name = "TextLabel_567"
        TextLabel_567.Parent = ToggleTextButton_567
        TextLabel_567.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_567.BackgroundTransparency = 1.000
        TextLabel_567.BorderSizePixel = 0
        TextLabel_567.Position = UDim2.new(0.0341032781, 0, 0.054385975, 0)
        TextLabel_567.Size = UDim2.new(0, 206, 0, 33)
        TextLabel_567.Font = Enum.Font.Gotham
        TextLabel_567.Text = text
        TextLabel_567.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_567.TextSize = 17.000
        TextLabel_567.TextXAlignment = Enum.TextXAlignment.Left
        
        ToggleLineFrame.Name = "ToggleLineFrame"
        ToggleLineFrame.Parent = ToggleTextButton_567
        ToggleLineFrame.BackgroundColor3 = Color3.fromRGB(62, 66, 74)
        ToggleLineFrame.BorderSizePixel = 0
        ToggleLineFrame.Position = UDim2.new(0.868161619, 0, 0.213571608, 0)
        ToggleLineFrame.Size = UDim2.new(0, 42, 0, 23)
        
        ToggleFrameUi.CornerRadius = UDim.new(0, 100)
        ToggleFrameUi.Name = "ToggleFrameUi"
        ToggleFrameUi.Parent = ToggleLineFrame
        
        ToggleCircle.Name = "ToggleCircle"
        ToggleCircle.Parent = ToggleLineFrame
        ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleCircle.Position = UDim2.new(0, 1, 0.094, 0)
        ToggleCircle.Size = UDim2.new(0, 19, 0, 19)
        
        ToggleCircleUi.CornerRadius = UDim.new(0, 100)
        ToggleCircleUi.Name = "ToggleCircleUi"
        ToggleCircleUi.Parent = ToggleCircle
        
        ToggleUICorner_567.CornerRadius = UDim.new(0, 10)
        ToggleUICorner_567.Name = "ToggleUICorner_567"
        ToggleUICorner_567.Parent = Toggle_567

        function Fire()
            local dummy_enabled = not enabled
            local accepted = callback(dummy_enabled)
            if accepted ~= false then
                enabled = not enabled
                ToggleCircle:TweenPosition(enabled and UDim2.new(0.5, 1, 0.094, 0) or UDim2.new(0, 1, 0.094, 0), "InOut", "Linear", 0.1)
                local tw = game.TweenService:Create(ToggleLineFrame, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), { BackgroundColor3 = enabled and Color3.fromRGB(255, 132, 38) or Color3.fromRGB(62, 66, 74)})
                tw:Play()
            end
        end


        ToggleTextButton_567.MouseButton1Click:Connect(Fire)

        local PropertiesTable = {
            fire = Fire
        }

        return PropertiesTable
    end

    function InsideLibrary:SetToggle(table)
        table["fire"]()
    end

    function InsideLibrary:CreateSlider(text, minvalue, maxvalue, parent, callback)
        local Slider_678 = Instance.new("Frame")
        local SliderUICorner_678 = Instance.new("UICorner")
        local SliderTextLabel_678 = Instance.new("TextLabel")
        local SliderFrame_678 = Instance.new("Frame")
        local UICorner_678 = Instance.new("UICorner")
        local SliderButton = Instance.new("TextButton")
        local SliderButtonUICorner_678 = Instance.new("UICorner")
        local SliderInner = Instance.new("Frame")
        local SliderInnerUICorner_678 = Instance.new("UICorner")
        local SliderFrameTextLabel_678 = Instance.new("TextLabel")

        Slider_678.Name = text.."Slider_678"
        Slider_678.Parent = parent
        Slider_678.BackgroundColor3 = Color3.fromRGB(71, 75, 84)
        Slider_678.ClipsDescendants = true
        Slider_678.Position = UDim2.new(0.0433925055, 0, 0.0247893538, 0)
        Slider_678.Size = UDim2.new(0, 463, 0, 38)
        
        SliderUICorner_678.CornerRadius = UDim.new(0, 10)
        SliderUICorner_678.Name = "SliderUICorner_678"
        SliderUICorner_678.Parent = Slider_678
        
        SliderTextLabel_678.Name = "SliderTextLabel_678"
        SliderTextLabel_678.Parent = Slider_678
        SliderTextLabel_678.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderTextLabel_678.BackgroundTransparency = 1.000
        SliderTextLabel_678.BorderSizePixel = 0
        SliderTextLabel_678.Position = UDim2.new(0.0341032781, 0, 0.054385975, 0)
        SliderTextLabel_678.Size = UDim2.new(0, 206, 0, 33)
        SliderTextLabel_678.Font = Enum.Font.Gotham
        SliderTextLabel_678.Text = text
        SliderTextLabel_678.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderTextLabel_678.TextSize = 17.000
        SliderTextLabel_678.TextXAlignment = Enum.TextXAlignment.Left
        
        SliderFrame_678.Name = "SliderFrame_678"
        SliderFrame_678.Parent = Slider_678
        SliderFrame_678.BackgroundColor3 = Color3.fromRGB(62, 66, 74)
        SliderFrame_678.Position = UDim2.new(0.312206566, 0, 0.157894745, 0)
        SliderFrame_678.Size = UDim2.new(0, 286, 0, 25)
        
        UICorner_678.CornerRadius = UDim.new(0, 10)
        UICorner_678.Name = "UICorner_678"
        UICorner_678.Parent = SliderFrame_678
        

        
        SliderButton.Name = "SliderButton"
        SliderButton.Parent = SliderFrame_678
        SliderButton.BackgroundColor3 = Color3.fromRGB(62, 66, 74)
        SliderButton.BackgroundTransparency = 1.000
        SliderButton.Size = UDim2.new(0, 285, 0, 25)
        SliderButton.AutoButtonColor = false
        SliderButton.Font = Enum.Font.SourceSans
        SliderButton.Text = ""
        SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        SliderButton.TextSize = 14.000
        
        SliderButtonUICorner_678.CornerRadius = UDim.new(0, 10)
        SliderButtonUICorner_678.Name = "SliderButtonUICorner_678"
        SliderButtonUICorner_678.Parent = SliderButton
        
        SliderInner.Name = "SliderInner"
        SliderInner.Parent = SliderButton
        SliderInner.BackgroundColor3 = Color3.fromRGB(255, 132, 38)
        SliderInner.BorderColor3 = Color3.fromRGB(71, 75, 84)
        SliderInner.Position = UDim2.new(0, 0, 0, 0)

        
        SliderInnerUICorner_678.CornerRadius = UDim.new(0, 10)
        SliderInnerUICorner_678.Name = "SliderInnerUICorner_678"
        SliderInnerUICorner_678.Parent = SliderInner

        SliderFrameTextLabel_678.Name = "SliderFrameTextLabel_678"
        SliderFrameTextLabel_678.Parent = SliderButton
        SliderFrameTextLabel_678.BackgroundColor3 = Color3.fromRGB(241, 241, 241)
        SliderFrameTextLabel_678.BackgroundTransparency = 1.000
        SliderFrameTextLabel_678.BorderSizePixel = 0
        SliderFrameTextLabel_678.Position = UDim2.new(0.0384438746, 0, -0.14561367, 0)
        SliderFrameTextLabel_678.Size = UDim2.new(0, 16, 0, 33)
        SliderFrameTextLabel_678.Font = Enum.Font.Gotham
        SliderFrameTextLabel_678.Text = minvalue
        SliderFrameTextLabel_678.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderFrameTextLabel_678.TextSize = 14.000
        SliderFrameTextLabel_678.TextXAlignment = Enum.TextXAlignment.Left

                -----Values-----
        minvalue = minvalue or 0
        maxvalue = maxvalue or 100


        -----Callback-----
        callback = callback or function() end


        -----Variables-----
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local uis = game:GetService("UserInputService")
        local Value;




        -----Main Code-----

        SliderButton.MouseButton1Down:Connect(function()
            Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 286) * SliderInner.AbsoluteSize.X) + tonumber(minvalue)) or 0
            pcall(function()
                callback(Value)
            end)
            SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 286), 0, 25)
            moveconnection = mouse.Move:Connect(function()
                SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 286), 0, 25)
                Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 286) * SliderInner.AbsoluteSize.X) + tonumber(minvalue))
                SliderFrameTextLabel_678.Text = Value
                pcall(function()
                    callback(Value)
                end)
            end)
            releaseconnection = uis.InputEnded:Connect(function(Mouse)
                if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                    SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 286), 0, 25)
                    Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 286) * SliderInner.AbsoluteSize.X) + tonumber(minvalue))
                    SliderFrameTextLabel_678.Text = Value
                    pcall(function()
                        callback(Value)
                    end)
                    moveconnection:Disconnect()
                    releaseconnection:Disconnect()
                end
            end)
        end)

        local PropertiesTable = {
            minvalue = minvalue,
            maxvalue = maxvalue,
            label = SliderFrameTextLabel_678,
            slider = SliderInner
        }

        return PropertiesTable

    end

    function InsideLibrary:SetSlider(table, value)
        local minvalue = table["minvalue"]
        local maxvalue = table["maxvalue"]
        local label = table["label"]
        local slider = table["slider"]

        if value ~= maxvalue then
            slider.Size = UDim2.new((value and value - minvalue or 0) / maxvalue , 0, 0, 25)
        else
            slider.Size = UDim2.new((value or 0) / maxvalue , 0, 0, 25)
        end

        label.Text = value
    end

    function InsideLibrary:CreateConfirmBox(text, yes, no)
        local JayHub_Confirm = Instance.new("ScreenGui")
        local ConfirmMainFrame = Instance.new("Frame")
        local ConfirmUICorner = Instance.new("UICorner")
        local ConfirmLabel = Instance.new("TextLabel")
        local YesBtn = Instance.new("TextButton")
        local ConfirmUICorner_2 = Instance.new("UICorner")
        local NoBtn = Instance.new("TextButton")
        local ConfirmUICorner_3 = Instance.new("UICorner")
        local confirm_data = nil
        --Properties:

        JayHub_Confirm.Name = "JayHub_Confirm"
        JayHub_Confirm.Parent = game.CoreGui
        JayHub_Confirm.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        ConfirmMainFrame.Name = "ConfirmMainFrame"
        ConfirmMainFrame.Parent = JayHub_Confirm
        ConfirmMainFrame.Visible = false
        ConfirmMainFrame.BackgroundColor3 = Color3.fromRGB(75, 79, 88)
        ConfirmMainFrame.Position = UDim2.new(0.5, -170, 0.5, -76)
        ConfirmMainFrame.Size = UDim2.new(0, 340, 0, 152)

        ConfirmUICorner.Name = "ConfirmUICorner"
        ConfirmUICorner.Parent = ConfirmMainFrame

        ConfirmLabel.Name = "ConfirmLabel"
        ConfirmLabel.Parent = ConfirmMainFrame
        ConfirmLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ConfirmLabel.BackgroundTransparency = 1.000
        ConfirmLabel.Position = UDim2.new(0.0527777784, 0, 0.0784313753, 0)
        ConfirmLabel.Size = UDim2.new(0, 316, 0, 129)
        ConfirmLabel.Font = Enum.Font.GothamSemibold
        ConfirmLabel.Text = text
        ConfirmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        ConfirmLabel.TextSize = 18.000
        ConfirmLabel.TextWrapped = true
        ConfirmLabel.TextYAlignment = Enum.TextYAlignment.Top

        YesBtn.Name = "YesBtn"
        YesBtn.Parent = ConfirmMainFrame
        YesBtn.BackgroundColor3 = Color3.fromRGB(117, 123, 136)
        YesBtn.Position = UDim2.new(0.0527777821, 0, 0.575163424, 0)
        YesBtn.Size = UDim2.new(0, 134, 0, 48)
        YesBtn.AutoButtonColor = false
        YesBtn.Font = Enum.Font.GothamSemibold
        YesBtn.Text = yes
        YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        YesBtn.TextSize = 18.000

        ConfirmUICorner_2.Name = "ConfirmUICorner"
        ConfirmUICorner_2.Parent = YesBtn

        NoBtn.Name = "NoBtn"
        NoBtn.Parent = ConfirmMainFrame
        NoBtn.BackgroundColor3 = Color3.fromRGB(117, 123, 136)
        NoBtn.Position = UDim2.new(0.558333337, 0, 0.575163424, 0)
        NoBtn.Size = UDim2.new(0, 134, 0, 48)
        NoBtn.AutoButtonColor = false
        NoBtn.Font = Enum.Font.GothamSemibold
        NoBtn.Text = no
        NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        NoBtn.TextSize = 18.000

        ConfirmUICorner_3.Name = "ConfirmUICorner"
        ConfirmUICorner_3.Parent = NoBtn

        ConfirmMainFrame.Position = UDim2.new(0.5, -170, -0.5, -76)
        ConfirmMainFrame.Visible = true
        ConfirmMainFrame:TweenPosition(UDim2.new(0.5, -170, 0.5, -76))

        YesBtn.MouseButton1Click:Connect(function()
            confirm_data = true
        end)

        NoBtn.MouseButton1Click:Connect(function()
            confirm_data = false
        end)

        repeat wait() until confirm_data ~= nil
        JayHub_Confirm:Destroy()
        return confirm_data
    end

    function InsideLibrary:DestroyGui()
        JayHub:Destroy()
    end

    function InsideLibrary:Visibility(input)
        if input == true then
            Main.Visible = true
        elseif input == false then
            Main.Visible = false
        else end
    end

    function InsideLibrary:CreateEsp(selected)
        selected = selected or false
        local PLAYER  = game:GetService("Players").LocalPlayer
        local MOUSE   = PLAYER:GetMouse()
        local CC      = game:GetService("Workspace").CurrentCamera
        local ESP_ENABLED = false

        local FREE_FOR_ALL = false
        EspTab = InsideLibrary:CreateTab("Esp", selected)
        EspLabel = InsideLibrary:CreateLabel("Esp", EspTab)

        function CLEAR()
            for _,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:children()) do
                if v.Name == 'ESP' and v:IsA('BillboardGui') then
                    v:Destroy()
                end
            end
        end
        
        function CREATE(BASE, TEAM, COLOR)
            local ESP_MAIN                   = Instance.new('BillboardGui', PLAYER.PlayerGui)
            local ESP_DOT                    = Instance.new('Frame', ESP_MAIN)
            local ESP_NAME                   = Instance.new('TextLabel', ESP_MAIN)
            
            ESP_MAIN.Name                    = 'ESP'
            ESP_MAIN.Adornee                 = BASE
            ESP_MAIN.AlwaysOnTop             = true
            ESP_MAIN.ExtentsOffset           = Vector3.new(0, 1, 0)
            ESP_MAIN.Size                    = UDim2.new(0, 5, 0, 5)
            
            ESP_DOT.Name                     = 'DOT'
            ESP_DOT.BackgroundColor          = COLOR
            ESP_DOT.BackgroundTransparency   = 0.3
            ESP_DOT.BorderSizePixel          = 0
            ESP_DOT.Position                 = UDim2.new(-0.5, 0, -0.5, 0)
            ESP_DOT.Size                     = UDim2.new(2, 0, 2, 0)
            ESP_DOT.Visible                  = true
            ESP_DOT.ZIndex                   = 10
            
            ESP_NAME.Name                    = 'NAME'
            ESP_NAME.BackgroundColor3        = Color3.new(255, 255, 255)
            ESP_NAME.BackgroundTransparency  = 1
            ESP_NAME.BorderSizePixel         = 0
            ESP_NAME.Position                = UDim2.new(0, 0, 0, -40)
            ESP_NAME.Size                    = UDim2.new(1, 0, 10, 0)
            ESP_NAME.Visible                 = true
            ESP_NAME.ZIndex                  = 10
            ESP_NAME.Font                    = 'ArialBold'
            ESP_NAME.FontSize                = 'Size14'
            ESP_NAME.Text                    = BASE.Parent.Name:upper()
            ESP_NAME.TextColor               = COLOR
        end
        
        function FIND()
            CLEAR()
            ESP_ENABLED = true
            spawn(function()
                while ESP_ENABLED do
                    wait()
                    if ESP_ENABLED then
                        CLEAR()
                        for i,v in pairs(game.Players:GetChildren()) do
                            if v.Character and v.Character:FindFirstChild('Head') then
                                if FREE_FOR_ALL == false then
                                    if v.TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor then
                                        if v.Character:FindFirstChild('Head') then
                                            CREATE(v.Character.Head, true, v.TeamColor)
                                        end
                                    elseif v.TeamColor == game:GetService("Players").LocalPlayer.TeamColor then
                                        if v.Character:FindFirstChild('Head') then
                                            CREATE(v.Character.Head, true, v.TeamColor)
                                        end
                                    end
                                else
                                    if v.Character:FindFirstChild('Head') then
                                        CREATE(v.Character.Head, true, BrickColor.new('Bright red'))
                                    end
                                end
                            end
                        end
                    end
                end
                wait(1)
            end)
        end

        EspToggle = InsideLibrary:CreateToggle("Esp", EspTab, function(enabled)
            if enabled == true then
                ESP_ENABLED = true
                spawn(FIND)
            elseif enabled == false then
                ESP_ENABLED = false
                wait()
                spawn(CLEAR)
            end
        end)
        
        FreeForAllToggle = InsideLibrary:CreateToggle("Free For All", EspTab, function(enabled)
            if enabled == true then
                FREE_FOR_ALL = true
            elseif enabled == false then
                FREE_FOR_ALL = false
            end
        end)


    end



    return InsideLibrary;

end

return Library;