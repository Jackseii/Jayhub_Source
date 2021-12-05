Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jack1214060/LuaUtils/master/main.lua",true))()
Utils:SetupCompatibility()

function GetLib()
    local response = http_request(
    {
        Url = "https://raw.githubusercontent.com/Jack1214060/Jayhub_Source/Master/jayhub_uilib.lua",  -- This website helps debug HTTP requests
        Method = "GET"
    }
    )
    return response.Body
end

Library = loadstring(GetLib())()



lib = Library:CreateMain()


HomeTab = lib:CreateTab("Home", true)
TeleportsTab = lib:CreateTab("Teleports")
CharacterTab = lib:CreateTab("Character")
AutoFarmTab = lib:CreateTab("Auto Farm")

TeleportLabel = lib:CreateLabel("Teleports", TeleportsTab)
CharacterLabel = lib:CreateLabel("Character", CharacterTab)
AutoFarmLabel = lib:CreateLabel("Auto Farm", AutoFarmTab)

game:GetService("Players").LocalPlayer.Idled:connect(function()
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

JayhubFunctions = {

    MainFrameOpen = true,
    AutoFarm = false,
    Noclip = false,
    Teleport = false,
    WalkSpeed = false,
    JumpPower = false,
    WalkSpeed_Amn = nil,
    JumpPower_Amn = nil

}



local RunServiceStepped
RunServiceStepped = game:GetService("RunService").Stepped:connect(function()
    if JayhubFunctions["WalkSpeed"] == true then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = JayhubFunctions["WalkSpeed_Amn"]
    end
    if JayhubFunctions["JumpPower"] == true then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = JayhubFunctions["JumpPower_Amn"]
    end

    if JayhubFunctions["Noclip"] == true or JayhubFunctions["Teleport"] == true or JayhubFunctions["AutoFarm"] == true then
        game.Players.LocalPlayer.Character.Head.CanCollide = false
        game.Players.LocalPlayer.Character.LowerTorso.CanCollide = false
        game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
        game.Players.LocalPlayer.Character.UpperTorso.CanCollide = false
        game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid"):ChangeState(11)
    end
end)




function messagebox(text, delay)
    game.StarterGui:SetCore("SendNotification", {
        Title = "JayHub";
        Text = text;
        Duration = delay;
    })    
end


-- Home Tab

HomeLabel = lib:CreateLabel("Thank you for using JayHub", HomeTab)

DiscordCreditsLabel = lib:CreateLabel("Credits:", HomeTab)
DiscordCreditsLabel1 = lib:CreateLabel("Jack1214060#5890", HomeTab)
DiscordCreditsLabel2 = lib:CreateLabel("iFergggg#0328", HomeTab)
DiscordBtn = lib:CreateButton("Copy Discord", HomeTab, function()
    setclipboard("https://discord.gg/JeTzZsDNWN")
    messagebox("Discord Server copied to clipboard", 3)
end)

ResetBtn = lib:CreateButton("Reset Player", HomeTab, function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)

getgenv().JayHub_RemoveGui = function()
    for key, value in pairs(JayhubFunctions) do
        value = false
    end
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    RunServiceStepped:Disconnect()
    lib:DestroyGui()
end

KillGuiBtn = lib:CreateButton("Kill Gui", HomeTab, function()
    JayHub_RemoveGui()
end)



-- End Home Tab



function tp(x, y, z)
    local valtomove = 20
    moving = true
    if x < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X then
    while x < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X-valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
    end
    end
    if z < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z then
    while z < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z-valtomove))
    end
    end
    if x > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X then
    while x > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X+valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
    end
    end
    if z > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z then
    while z > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z+valtomove))
    end
    end
    if y < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y then
    while y < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y-valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
    end
    end
    if y > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y then
    while y > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y+valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
    end
    end
end

function getFirstChild(service,str,modifier)
	local children = service:GetChildren()
	for i=1,#children do
		local v = children[i]
		for s in string.gmatch(v.Name,"%S+") do
			if modifier(s:sub(1,#str)) == str then
				return v
			end
		end
	end
end
function findObject(service,str)
	if service and str and #str>0 then
		--exact match
		local targ = service:FindFirstChild(str) or service:FindFirstChild(str:lower())
		if targ then
			return targ
		else
			--loose match
			return getFirstChild(service,str,(str:lower()==str and string.lower) or function(x) return x end)
		end
	end
end



-- Teleport Tab

TpPlayerTextBox = lib:CreateTextbox("Tp to Player", "Plr Name", true, TeleportsTab, function(value) 
    local Players_Tp = game:GetService("Players")
    local Tp_Plr = value
    local target = findObject(Players_Tp,Tp_Plr)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        tp(target.Character.HumanoidRootPart.Position.X,target.Character.HumanoidRootPart.Position.Y,target.Character.HumanoidRootPart.Position.Z)
    end
end)

-- End Teleports Tab

--Character Tab


NoclipButton = lib:CreateToggle("Noclip", CharacterTab, function(enabled)
    if enabled == true then
        JayhubFunctions["Noclip"] = true
    elseif enabled == false then
        JayhubFunctions["Noclip"] = false
    end
end)

WalkSpeedSlider = lib:CreateSlider("WalkSpeed", 16, 500, CharacterTab, function(value) 
    JayhubFunctions["WalkSpeed_Amn"] = value
    JayhubFunctions["WalkSpeed"] = true
end)

JumpPowerSlider = lib:CreateSlider("JumpPower", 50, 500, CharacterTab, function(value) 
    JayhubFunctions["JumpPower_Amn"] = value
    JayhubFunctions["JumpPower"] = true
end)

-- End Character Tab

-- Auto Farm Tab
function AutoFarmFunction()
    while JayhubFunctions["AutoFarm"] do
        
        wait(2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").BoatStages.NormalStages:findFirstChild("CaveStage1").DarknessPart.CFrame
        for i=2, 10 do
            local Wall = game:GetService("Workspace").BoatStages.NormalStages:findFirstChild("CaveStage" .. tostring(i)).DarknessPart.CFrame
            local Wall_y = Wall.Y -10
            if JayhubFunctions["AutoFarm"] == false then break end
            tp(Wall.X, Wall_y, Wall.Z)
        end
        if JayhubFunctions["AutoFarm"] == true then 
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame
            game.Players.LocalPlayer.CharacterAdded:Wait() 
            wait(5)
            workspace.ClaimRiverResultsGold:FireServer()
        end
    end
    game.Players.LocalPlayer.Character:BreakJoints()
end

AutoFarmBtn = lib:CreateToggle("Auto Farm", AutoFarmTab, function(enabled)
    if enabled == true then
        JayhubFunctions["AutoFarm"] = true
        spawn(AutoFarmFunction)
    elseif enabled == false then
        JayhubFunctions["AutoFarm"] = false
    end
end)

-- End Farm Tab

-- Discord Tab
DiscordCreditsLabel = lib:CreateLabel("Credits:", DiscordTab)
DiscordCreditsLabel1 = lib:CreateLabel("Jack1214060#5890", DiscordTab)
DiscordCreditsLabel2 = lib:CreateLabel("iFergggg#0328", DiscordTab)
McDiscordBtn = lib:CreateButton("Copy Discord", DiscordTab, function()
    if syn then
        syn_clipboard_set("https://jack1214060.xyz/jayhub/discord")
    else
        setclipboard("https://jack1214060.xyz/jayhub/discord")
    end
    messagebox("Discord Server copied to clipboard", 3)
end)
-- End Discord Tab

-- Settings Tab



ResetBtn = lib:CreateButton("Reset Player", SettingsTab, function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)

KillGuiBtn = lib:CreateButton("Kill Gui", SettingsTab, function()
    JayhubFunctions["AutoFarm"] = false
    JayhubFunctions["Noclip"] = false
    JayhubFunctions["Teleport"] = false
    JayhubFunctions["WalkSpeed"] = false
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    JayhubFunctions["JumpPower"] = false
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    lib:DestroyGui()
end)









--End Settings Tab




getgenv().JayHub_RemoveGui = function()
    JayhubFunctions["AutoFarm"] = false
    JayhubFunctions["Noclip"] = false
    JayhubFunctions["Teleport"] = false
    JayhubFunctions["WalkSpeed"] = false
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    JayhubFunctions["JumpPower"] = false
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    lib:DestroyGui()
end


