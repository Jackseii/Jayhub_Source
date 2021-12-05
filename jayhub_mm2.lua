

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
MiscTab = lib:CreateTab("Miscellaneous")

TeleportLabel = lib:CreateLabel("Teleports", TeleportsTab)
CharacterLabel = lib:CreateLabel("Character", CharacterTab)
MiscLabel = lib:CreateLabel("Miscellaneous", MiscTab)
SettingsLabel = lib:CreateLabel("Settings", SettingsTab)

game:GetService("Players").LocalPlayer.Idled:connect(function()
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local player = game.Players.LocalPlayer

JayhubFunctions = {

    MainFrameOpen = true,
    Coin = false,
    Gun = false,
    Esp = false,
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

    if JayhubFunctions["Noclip"] == true or JayhubFunctions["Teleport"] == true then
        game.Players.LocalPlayer.Character.Head.CanCollide = false
        game.Players.LocalPlayer.Character.LowerTorso.CanCollide = false
        game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
        game.Players.LocalPlayer.Character.UpperTorso.CanCollide = false
        game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid"):ChangeState(11)
    end
end)

function lookAt(chr,target) --assume chr is a character and target is a brick to look towards
	if chr.PrimaryPart then --just make sure the character's HRP has loaded
		local chrPos=chr.PrimaryPart.Position --get the position of the HRP
		local tPos=target.Position --get the position of the target
		local newCF=CFrame.new(chrPos,tPos) --create our CFrame
		chr:SetPrimaryPartCFrame(newCF) --set the HRP's CFrame to our result, thus moving the character!
	end
end

function ShotGun(pos)
    local ShootGun = nil
    for i, v in pairs(player.Backpack:GetChildren()) do
        if v:IsA'Tool' and v.Name == 'Gun' then
            player.Character.Humanoid:EquipTool(v)
            ShootGun = v.KnifeServer.ShootGun
            break
        end
    end
    if ShootGun == nil then
        for i, v in pairs(player.Character:GetChildren()) do
            if v:IsA'Tool' and v.Name == 'Gun' then
                ShootGun = v.KnifeServer.ShootGun
                break
            end
        end
    end
    if ShootGun ~= nil then
        ShootGun:InvokeServer(1, pos, "AH")
    end
end

function CommitMurder()
    local Knife = nil
    for i, v in pairs(player.Backpack:GetChildren()) do
        if v:IsA'Tool' and v.Name == 'Knife' then
            player.Character.Humanoid:EquipTool(v)
            Knife = v.Stab
            break
        end
    end
    if Knife == nil then
        for i, v in pairs(player.Character:GetChildren()) do
            if v:IsA'Tool' and v.Name == 'Knife' then
                Knife = v.Stab
                break
            end
        end
    end
    if Knife then
        Knife:FireServer("Slash")
    end
end


function getSheriff()
    for i, v in pairs(game.Players:children()) do
    if  v.Backpack:findFirstChild("Gun") or v.Character:findFirstChild("Gun") then
    return v
    end
    end
end

function getMurder()
    for i, v in pairs(game.Players:children()) do
    if  v.Backpack:findFirstChild("Knife") or v.Character:findFirstChild("Knife") then
    return v
    end
    end
end




local Kill_All_Running = false


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
    for i, v in pairs(game.Players:children()) do
        for i, a in pairs(v.Character.Head:children()) do
        if a.ClassName == "BoxHandleAdornment" then
        a:remove()
        end
        end
        end
    RunServiceStepped:Disconnect()
    lib:DestroyGui()
end

KillGuiBtn = lib:CreateButton("Kill Gui", HomeTab, function()
    JayHub_RemoveGui()
end)



-- End Home Tab


function tween_teleport(TargetFrame)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    Move = game:GetService("TweenService"):Create(player.Character.HumanoidRootPart, TweenInfo.new(((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - TargetFrame.p).Magnitude / 70), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {CFrame = TargetFrame})
    Move:Play()
    Move.Completed:wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
end

function FindMap()
    for i, v in pairs(workspace:GetChildren()) do
        if v:FindFirstChild("CoinContainer") then
            return v.CoinContainer
        elseif v:FindFirstChild("Map") then
            if pcall(function() local view = v.Map.CoinContainer end) then
                return v.Map.CoinContainer
            end
        end
    end
    return false
end

function Coin_Farm()
    while JayhubFunctions["Coin"] == true do
        local Map = FindMap()
        if Map then
            local InGame = false
            pcall(function()
                if game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:findFirstChild("EarnedXP") and game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:findFirstChild("EarnedXP").Visible == true then InGame = true end
            end)
            if InGame then
                pcall(function()
                    local minimum_distant = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Map['Coin_Server'].Coin.Position).Magnitude
                    local minimum_object = Map['Coin_Server']
                    for i, v in pairs(Map:GetChildren()) do
                        if v.Name == 'Coin_Server' then
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Coin.Position).Magnitude < minimum_distant then
                                minimum_distant = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Coin.Position).Magnitude;
                                minimum_object = v;
                            end 
                        end
                    end
                    tween_teleport(CFrame.new(minimum_object.Coin.CFrame.p))
                    spawn(function()
                        wait(5)
                        minimum_object.Name = 'False_Coin'
                    end)
                    repeat
                        wait()
                    until(minimum_object.Name ~= 'Coin_Server')
                    wait(1)
                end)
            end
        end
        wait()
    end
end

function Gun_Auto()
    while JayhubFunctions["Gun"] == true do
        wait()
        local InGame = false
        pcall(function()
            if game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:findFirstChild("EarnedXP") and game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:findFirstChild("EarnedXP").Visible == true then InGame = true end
        end)
        if InGame then
            local Plr_Position_AutoGun = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            local wp = game:GetService("Workspace")
            if wp:FindFirstChild("GunDrop") then
                wait(2)
                tp(wp.GunDrop.CFrame.X, wp.GunDrop.CFrame.Y, wp.GunDrop.CFrame.Z)
                wait(0.3)
                tp(Plr_Position_AutoGun.X, Plr_Position_AutoGun.Y, Plr_Position_AutoGun.Z)
            end
        end
    end
end

local Esp_Murder_Name = nil
local Esp_Gun_Name = nil
function Esp_Fix()
    while JayhubFunctions["Esp"] == true do
        wait()
        function wjkdkajdwk()
            for i, v in pairs(game.Players:children()) do
                if v.Backpack:findFirstChild("Knife") or v.Character:findFirstChild("Knife") then
                    if v.name == Esp_Murder_Name then

                    else
                        for i, v in pairs(game.Players:children()) do
                            if v.Backpack:findFirstChild("Knife") or v.Character:findFirstChild("Knife") then
                            Esp_Murder_Name = v.name
                            if v.name ~= game.Players.LocalPlayer.name then
                                local esp = Instance.new("BoxHandleAdornment")
                                esp.Parent = v.Character.Head
                                esp.Size = Vector3.new(1,1,1)
                                esp.Color3 = Color3.new(255, 0, 0)
                                esp.AlwaysOnTop = true
                                esp.Adornee = v.Character.Head
                                esp.Visible = true
                                esp.ZIndex = 2
                            end
                            
                            elseif v.Backpack:findFirstChild("Gun") or v.Character:findFirstChild("Gun") then
                            if v.name ~= game.Players.LocalPlayer.name then
                                local esp = Instance.new("BoxHandleAdornment")
                                esp.Parent = v.Character.Head
                                esp.Size = Vector3.new(1,1,1)
                                esp.Color3 = Color3.new(0, 0, 255)
                                esp.AlwaysOnTop = true
                                esp.Adornee = v.Character.Head
                                esp.Visible = true
                                esp.ZIndex = 2
                            end
                            elseif v.name == game.Players.LocalPlayer.name then
                            else
                            local esp = Instance.new("BoxHandleAdornment")
                            esp.Parent = v.Character.Head
                            esp.Size = Vector3.new(1,1,1)
                            esp.Color3 = Color3.new(0, 255, 0)
                            esp.AlwaysOnTop = true
                            esp.Adornee = v.Character.Head
                            esp.Visible = true
                            esp.ZIndex = 2
                            end
                            
                        end
                    end
                elseif v.Backpack:findFirstChild("Gun") or v.Character:findFirstChild("Gun") then
                    if v.Backpack:findFirstChild("Gun") or v.Character:findFirstChild("Gun") then
                        if v.name == Esp_Gun_Name then
    
                        else
                            for i, v in pairs(game.Players:children()) do
                                if v.Backpack:findFirstChild("Knife") or v.Character:findFirstChild("Knife") then
                                if v.name ~= game.Players.LocalPlayer.name then
                                    local esp = Instance.new("BoxHandleAdornment")
                                    esp.Parent = v.Character.Head
                                    esp.Size = Vector3.new(1,1,1)
                                    esp.Color3 = Color3.new(255, 0, 0)
                                    esp.AlwaysOnTop = true
                                    esp.Adornee = v.Character.Head
                                    esp.Visible = true
                                    esp.ZIndex = 2
                                end
                                
                                elseif v.Backpack:findFirstChild("Gun") or v.Character:findFirstChild("Gun") then
                                Esp_Gun_Name = v.name
                                if v.name ~= game.Players.LocalPlayer.name then
                                    local esp = Instance.new("BoxHandleAdornment")
                                    esp.Parent = v.Character.Head
                                    esp.Size = Vector3.new(1,1,1)
                                    esp.Color3 = Color3.new(0, 0, 255)
                                    esp.AlwaysOnTop = true
                                    esp.Adornee = v.Character.Head
                                    esp.Visible = true
                                    esp.ZIndex = 2
                                end
                                elseif v.name == game.Players.LocalPlayer.name then
                                else
                                local esp = Instance.new("BoxHandleAdornment")
                                esp.Parent = v.Character.Head
                                esp.Size = Vector3.new(1,1,1)
                                esp.Color3 = Color3.new(0, 255, 0)
                                esp.AlwaysOnTop = true
                                esp.Adornee = v.Character.Head
                                esp.Visible = true
                                esp.ZIndex = 2
                                end
                                
                            end
                        end
                    end
                end
            end
        end
        pcall(wjkdkajdwk)
        wait(2)
    end
end


function tp(x, y, z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
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

function esp()
    if JayhubFunctions["Esp"] == true then
        Esp_Fix()
    end
    if JayhubFunctions["Esp"] == false then
        for i, v in pairs(game.Players:children()) do
            for i, a in pairs(v.Character.Head:children()) do
            if a.ClassName == "BoxHandleAdornment" then
            a:remove()
            end
            end
            end
    end
end

-- Teleport Tab
LobbyBtn = lib:CreateButton("Lobby", TeleportsTab, function()
    tp(-108.53672027588, 140.69993591309, 82.270782470703)
end)


MurdererTpBtn = lib:CreateButton("Murderer", TeleportsTab, function()
    tp(getMurder().Character.HumanoidRootPart.CFrame.X, getMurder().Character.HumanoidRootPart.CFrame.Y, getMurder().Character.HumanoidRootPart.CFrame.Z)
end)

SheriffTpBtn = lib:CreateButton("Sheriff", TeleportsTab, function()
    tp(getSheriff().Character.HumanoidRootPart.CFrame.X, getSheriff().Character.HumanoidRootPart.CFrame.Y, getSheriff().Character.HumanoidRootPart.CFrame.Z)
end)

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

-- Misc Tab
local Who_Kill = nil



function KillAllLock()
    while Kill_All_Running == true do
        wait()
        print("wad")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Who_Kill.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
        lookAt(game.Players.LocalPlayer.Character, Who_Kill.Character.HumanoidRootPart)
    end
end

function KillAllFunction()
    while Kill_All_Running do
        wait()
        if game.Players.LocalPlayer.Backpack:findFirstChild("Knife") or game.Players.LocalPlayer.Character:findFirstChild("Knife") then
            spawn(function()
                for i = 1, 100 do
                    for i, v in pairs(game.Players:GetChildren()) do
                        if v:FindFirstChild("Character") and player:FindFirstChild("Character") then
                            v.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        end
                    end
                    wait()
                end
            end)
            for i = 1, 100 do 
                CommitMurder()
            end
        else
            Kill_All_Running = false
        end
    end
end

KillAllBtn = lib:CreateButton("Kill All (Murderer Only)", MiscTab, function()
    if game.Players.LocalPlayer.Backpack:findFirstChild("Knife") or game.Players.LocalPlayer.Character:findFirstChild("Knife") then
        if Kill_All_Running == false then
            print("yes")
            Kill_All_Running = true
            KillAllFunction()
            Kill_All_Running = false
        else
            messagebox("Already Running", 3)
        end
    else
        messagebox("You are not the Murderer", 3)
    end
end)

local Is_KillMurderer = false

KillMurderBtn = lib:CreateButton("Kill Murderer (Sheriff Only)", MiscTab, function()
    if game.Players.LocalPlayer.Backpack:findFirstChild("Gun") or game.Players.LocalPlayer.Character:findFirstChild("Gun") then
        print("idk")
        if Is_KillMurderer == false then
            local Murderer = getMurder()
            if Murderer then
                print("yes 1")
                local function FindMap()
                    for i, v in pairs(workspace:GetChildren()) do
                        if v:FindFirstChild("CoinContainer") then
                            return v
                        elseif v:FindFirstChild("Map") then
                            if pcall(function() local view = v.Map.CoinContainer end) then
                                return v.Map
                            end
                        end
                    end
                    return false
                end
                
                local Map = FindMap()
                if Map then
                    for i,v in pairs(Map:GetDescendants()) do
                        v:Destroy()
                    end
                end
                Is_KillMurderer = true
                while wait() and pcall(function() a = Murderer.Character:FindFirstChild('HumanoidRootPart') b = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') end) do
                    local InGame = false
                    pcall(function()
                        if game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:findFirstChild("EarnedXP") and game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:findFirstChild("EarnedXP").Visible == true then InGame = true end
                    end)
                    if InGame then
                        print("yes")
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Murderer.Character.HumanoidRootPart.CFrame + Vector3.new(-5,-5,-5)
                        spawn(function()
                            ShotGun(Murderer.Character.HumanoidRootPart.Position)
                        end)
                    else
                        break
                    end
                end
                Is_KillMurderer = false
            end
            Is_KillMurderer = false
        end
    else
        messagebox("You are not the Sheriff", 3)
    end
end)

GunBtn = lib:CreateButton("Get Gun", MiscTab, function()
    local Plr_Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local wp = game:GetService("Workspace")
    if wp:FindFirstChild("GunDrop") then
        tp(wp.GunDrop.CFrame.X, wp.GunDrop.CFrame.Y, wp.GunDrop.CFrame.Z)
        wait0(.5)
        tp(Plr_Position.X, Plr_Position.Y, Plr_Position.Z)
    else
        messagebox("Gun hasn't been dropped", 2)
    end
end)


AutoGunBtn = lib:CreateToggle("Auto Pickup Gun", MiscTab, function(enabled)
    if enabled == true then
        JayhubFunctions["Gun"] = true
        spawn(Gun_Auto)
    elseif enabled == false then
        JayhubFunctions["Gun"] = false
    end
end)

EspBtn = lib:CreateToggle("Esp", MiscTab, function(enabled)
    if enabled == true then
        JayhubFunctions["Esp"] = true
        spawn(esp)
    elseif enabled == false then
        JayhubFunctions["Esp"] = false
        spawn(esp)
    end
end)


CoinBtn = lib:CreateToggle("Coin Farm", MiscTab, function(enabled)
    if enabled == true then
        JayhubFunctions["Coin"] = true
        spawn(Coin_Farm)
    elseif enabled == false then
        JayhubFunctions["Coin"] = false
    end
end)

-- End Misc Tab




