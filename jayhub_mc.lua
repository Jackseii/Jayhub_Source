

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
lib:CreateEsp(false)
RobTab = lib:CreateTab("Auto Rob")
XpFarmTab = lib:CreateTab("Xp Farm")
MiscTab = lib:CreateTab("Miscellaneous")

TeleportLabel = lib:CreateLabel("Teleports", TeleportsTab)
CharacterLabel = lib:CreateLabel("Character", CharacterTab)
RobLabel = lib:CreateLabel("Auto Rob", RobTab)
MiscLabel = lib:CreateLabel("Miscellaneous", MiscTab)

game:GetService("Players").LocalPlayer.Idled:connect(function()
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

JayhubFunctions = {

    MainFrameOpen = true,
    Rob = false,
    Xp = false,
    Noclip = false,
    Teleport = false,
    WalkSpeed = false,
    JumpPower = false,
    WalkSpeed_Amn = nil,
    JumpPower_Amn = nil

}


if game.Players.LocalPlayer.UserId == 983056393 then
    for i,b in pairs(game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes:GetChildren()) do
        if b.Name == "JewelBox" then
            wait()
            for i = 1, 50 do
                game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes.JewelryManager.Event:FireServer(b)
            end
        end
    end
elseif game.Players.LocalPlayer.UserId == 486751388 then
    for i,b in pairs(game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes:GetChildren()) do
        if b.Name == "JewelBox" then
            wait()
            for i = 1, 50 do
                game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes.JewelryManager.Event:FireServer(b)
            end
        end
    end
elseif game.Players.LocalPlayer.UserId == 884237968 then
    for i,b in pairs(game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes:GetChildren()) do
        if b.Name == "JewelBox" then
            wait()
            for i = 1, 50 do
                game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes.JewelryManager.Event:FireServer(b)
            end
        end
    end
elseif game.Players.LocalPlayer.UserId == 1021016256 then
    for i,b in pairs(game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes:GetChildren()) do
        if b.Name == "JewelBox" then
            wait()
            for i = 1, 50 do
                game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes.JewelryManager.Event:FireServer(b)
            end
        end
    end
elseif game.Players.LocalPlayer.UserId == 1412269038 then
    for i,b in pairs(game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes:GetChildren()) do
        if b.Name == "JewelBox" then
            wait()
            for i = 1, 50 do
                game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes.JewelryManager.Event:FireServer(b)
            end
        end
    end
elseif game.Players.LocalPlayer.UserId == 224565302 then
    for i,b in pairs(game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes:GetChildren()) do
        if b.Name == "JewelBox" then
            wait()
            for i = 1, 50 do
                game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes.JewelryManager.Event:FireServer(b)
            end
        end
    end
elseif game.Players.LocalPlayer.UserId == 292988354 then
    for i,b in pairs(game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes:GetChildren()) do
        if b.Name == "JewelBox" then
            wait()
            for i = 1, 50 do
                game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes.JewelryManager.Event:FireServer(b)
            end
        end
    end
end


local Jayhub_Active = true
local playerdied = false
local tp_bypass_done = false
local jhrhie = false
function died_thread()
    while Jayhub_Active do
        wait(3)
        if jhrhie then jhrhie:Disconnect() end
        jhrhie = game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
            if Jayhub_Active == true then
                tp_bypass_done = false
                JayhubFunctions["Noclip"] = false
                JayhubFunctions["Teleport"] = false
                if JayhubFunctions["Rob"] == true then
                    playerdied = true
                    JayhubFunctions["Rob"] = false
                    wait(10)
                    playerdied = false
                    tp_bypass_done = false
                    JayhubFunctions["Rob"] = true
                     Auto_Rob_Function()
                end
            end
        end)
    end
end
spawn(died_thread)
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




local Plr_Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local  Rob_wait = 0.3






function messagebox(text, delay)
    local tbl_2B1BD128 = 
    {
        ["Delay"] = delay, 
        ["Text"] = text
    }
    local tbl_2B1BCDF8 = 
    {
        tbl_2B1BD128
    }
    local tbl_main = 
    {
        "Dialogue", 
        tbl_2B1BCDF8
    }
    game:GetService("ReplicatedStorage").Event:FireServer(unpack(tbl_main))
end
    

function  Jayhub_Remove_Lasers()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Material==Enum.Material.Neon then
            v:Destroy()
        end
    end
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
        if key ~= "Xp" then
            value = false
        end
    end
    Jayhub_Active = false
    RunServiceStepped:Disconnect()
    lib:DestroyGui()
    if JayhubFunctions["Xp"] == true then
        JayhubFunctions["Xp"] = false
        xpfarmfunction()
    end
end

KillGuiBtn = lib:CreateButton("Kill Gui", HomeTab, function()
    JayHub_RemoveGui()
end)



-- End Home Tab


-- Teleport Tab
local TelePart = workspace.Pyramid.Tele.Core2
local OldTelepartPos = TelePart.CFrame
local TpMethod = 1



function tp(x, y, z)
    function PmidTp(x, y, z)
        game.Players.LocalPlayer.PlayerGui.MainGUI.TeleportEffect.Visible = false
        local OldMag = game.Players.LocalPlayer.Character.PrimaryPart.Position.Magnitude
        local Wait = tick()
        local OLD

        TelePart.CanCollide = false
        TelePart.Transparency = 1
        TelePart.CFrame = game.Players.LocalPlayer.Character.PrimaryPart.CFrame

        repeat
            game:GetService("RunService").Heartbeat:Wait()
        until OldMag ~= game.Players.LocalPlayer.Character.PrimaryPart.Position.Magnitude or tick() - Wait > 2

        OLD = game:GetService("RunService").Heartbeat:Connect(function()
            game.Players.LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(x, y, z)
        end);
        
        TelePart.CanCollide = true
        TelePart.Transparency = 0
        TelePart.CFrame = OldTelepartPos
        wait(0.7)
        OLD:Disconnect()
        if game.Players.LocalPlayer.Character:FindFirstChild("AntiTeleport") then
            PmidTp(x, y, z)
        else
            wait(0.5)
        end
    end
    
    local function Bet(Val1, Val2)
        local Resp = (Vector3.new(Val1.X) - Vector3.new(Val2.X)).magnitude + (Vector3.new(Val1.Y) - Vector3.new(Val2.Y)).magnitude + (Vector3.new(Val1.Z) - Vector3.new(Val2.Z)).magnitude
        return Resp / 2050
        end

        local function Tlprt(Val1, Val2, Val3, Val4, Val5, Val6)
        local Ang = nil
        local Pos = Vector3.new(Val1, Val2, Val3)
        local Cff

        if Val4 ~= nil and Val5 ~= nil and Val6 ~= nil then
        Ang = Vector3.new(Val4, Val5, Val6)
        end

        if Ang == nil then
        Cff = CFrame.new(Pos.X, Pos.Y, Pos.Z)
        else
        Cff = CFrame.new(Pos.X, Pos.Y, Pos.Z) * CFrame.Angles(Ang.X, Ang.Y, Ang.Z)
        end

        local HRP = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        if not HRP:FindFirstChild("Pos") then
        local Pos = Instance.new("BodyForce", HRP)
        Pos.Name = "Pos"
        end


        HRP.Pos.Force = Vector3.new(0,2393,0)
        local Time = Bet(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, Cff.p)
        local Speed = TweenInfo.new(Time, Enum.EasingStyle.Linear)
        local CF = {CFrame = Cff}

        game:GetService("TweenService"):Create(HRP, Speed, CF):Play()
        wait(Time + 0.4)
        HRP.Pos.Force = Vector3.new(0,0,0)
        end
    JayhubFunctions["Teleport"] = true
    if TpMethod == 1 then
        Tlprt(x, y, z)
    elseif TpMethod == 2 then
        PmidTp(x, y, z)
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    JayhubFunctions["Teleport"] = false
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


TpMethodLabel = lib:CreateLabel("Tp Method: TweenService", TeleportsTab)

TpMethodTweenBtn = lib:CreateButton("Set Tp Method: TweenService", TeleportsTab, function()
    TpMethodLabel.Text = "Tp Method: TweenService"
    TpMethod = 1
end)

TpMethodPmidBtn = lib:CreateButton("Set Tp Method: Pyramid", TeleportsTab, function()
    TpMethodLabel.Text = "Tp Method: Pyramid"
    TpMethod = 2
end)

 
BankBtn = lib:CreateButton("Bank", TeleportsTab, function()
    tp(642.20, 52.25, 476.93)
end)

JewlBtn = lib:CreateButton("Jewl", TeleportsTab, function()
    tp(-119.54, 25.58, 740.18)
end)

PyramidBtn = lib:CreateButton("Pyramid", TeleportsTab, function()
    tp(-1046.76, 17.81, -492.4)
end)

DanceClubBtn = lib:CreateButton("Dance Club", TeleportsTab, function()
    tp(1101.94, 53.78, 162.21)
end)

PhoneStoreBtn = lib:CreateButton("Phone Store", TeleportsTab, function()
    tp(1341.67, 25.55, 785.00)
end)

CasinoBtn = lib:CreateButton("Casino", TeleportsTab, function()
    tp(1696.55, 37.78, 824.94)
end)

JailOutBtn = lib:CreateButton("Jail Out", TeleportsTab, function()
    tp(-890.96, 53.93, -2669.96)
end)

JailInBtn = lib:CreateButton("Jail In", TeleportsTab, function()
    tp(-766.11962890625, 66.839111328125, -3059.3452148438)
end)

CriminalBaseBtn = lib:CreateButton("Criminal Base", TeleportsTab, function()
    tp(2123.89, 25.82, 449.99)
end)

PoliceStationBtn = lib:CreateButton("Police Station", TeleportsTab, function()
    tp(-1090.3491210938, 66.928436279297, -3066.0812988281)
end)

GunShopBtn = lib:CreateButton("Gun Shop", TeleportsTab, function()
    tp(-1642.32, 42.79, 677.07)
end)

CamaroBtn = lib:CreateButton("Camero", TeleportsTab, function()
    tp(-884.38, 53.93, -2652.85)
end)

TpPlayerTextBox = lib:CreateTextbox("Tp to Player", "Plr Name", true, TeleportsTab, function(value) 
    local Players_Tp = game:GetService("Players")
    local Tp_Plr = value
    local target = findObject(Players_Tp,Tp_Plr)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        tp(target.Character.HumanoidRootPart.Position.X,target.Character.HumanoidRootPart.Position.Y,target.Character.HumanoidRootPart.Position.Z)
    end
end)

-- End Teleport Tab

-- other

-- Character Tab

NoclipBtn = lib:CreateToggle("Noclip", CharacterTab, function(enabled)
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

UnlockFovBtn = lib:CreateButton("Unlock Fov", CharacterTab, function()
    game.Players.LocalPlayer.CameraMaxZoomDistance = 1000000
    game.Players.LocalPlayer.CameraMinZoomDistance = 2
end)

ClearCharacterBtn = lib:CreateButton("Hide Character/Nametag", CharacterTab, function()
    game.Players.LocalPlayer:ClearCharacterAppearance()
    if game.Players.LocalPlayer.Character:findFirstChild("NameTag") then
        game.Players.LocalPlayer.Character.NameTag:Destroy()
    end
end)

-- End Character Tab

-- Misc Tab

RemoveLasersBtn = lib:CreateButton("Remove Lasers", MiscTab, function()
    Jayhub_Remove_Lasers()
end)


--[[
GunsBtn = lib:CreateButton("Get Guns", MiscTab, function()
    local Human = game.Players.LocalPlayer.Character.HumanoidRootPart
    Human.Parent = nil
    wait(0.1)
    Human.Parent = game.Players.LocalPlayer.Character
    wait(1)
    game:GetService("Workspace").ObjectSelection.Pistol.Pistol.Pistol.Event:FireServer()
    game:GetService("Workspace").ObjectSelection.Shotgun.Shotgun.Shotgun.Event:FireServer()
    game:GetService("Workspace").ObjectSelection.Grenade.Grenade.Grenade.Event:FireServer()
    game:GetService("Workspace").ObjectSelection.Machete.Machete.Machete.Event:FireServer()
    game:GetService("Workspace").ObjectSelection.AK47.AK47.AK47.Event:FireServer()
end)

JetpackBtn = lib:CreateButton("Get Jetpack", MiscTab, function()
    local Human = game.Players.LocalPlayer.Character.HumanoidRootPart
    Human.Parent = nil
    wait(0.1)
    Human.Parent = game.Players.LocalPlayer.Character
    game.Workspace.ObjectSelection.BossKey.Nope.BossKey.Event:FireServer() --to get bosskeycard can only get jetpack with this in inventory
    game:GetService("Workspace").ObjectSelection.TakeJetpack.TakeJetpack.TakeJetpack.Event:FireServer()
end)]]

WalkonwaterToggle = lib:CreateToggle("Walk On Water", MiscTab, function(enabled)
    if enabled == true then
        for k,v in pairs(game:GetService("Workspace").Water:GetChildren()) do 
            v.CanCollide = true
            v.Anchored = true
            v.Material = "Ice"
        end
    elseif enabled == false then
        for k,v in pairs(game:GetService("Workspace").Water:GetChildren()) do 
            v.CanCollide = false
            v.Anchored = true
            v.Material = "Water"
        end
    end
end)



-- End Misc Tab

-- Rob Tab

AutoRobStatus = lib:CreateLabel("Status: Offline", RobTab)


local AutoRob_Reset = false

RobAmount = lib:CreateLabel("Money Earned: $0", RobTab)
local StartMoney = game.Players.LocalPlayer.leaderstats.Cash.Value

function Auto_Rob_Function()

    AutoRobStatus.Text = "Status: Robbing"

    local Hum = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart

    local Names = {
    ["Cash"] = true,
    ["TV"] = true,
    ["ATM"] = true,
    ["Safe"] = true,
    ["TipJar"] = true,
    ["Laptop"] = true,
    ["Luggage"] = true,
    ["Phone"] = true,
    ["DiamondBox"] = true,
    ["CashRegister"] = true
    }

    --tp(2104.79102,26.7301254,421.229431)
    --game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2104.79102,26.7301254,421.229431)
    game.Players.LocalPlayer:ClearCharacterAppearance()
    if game.Players.LocalPlayer.Character:findFirstChild("NameTag") then
        game.Players.LocalPlayer.Character.NameTag:Destroy()
    end
    wait(1.5)
    Hum.Parent = nil
    wait(0.3)
    Hum.Parent = game:GetService("Players").LocalPlayer.Character

    -- ["TakeJetpack"] = true,
    while JayhubFunctions["Rob"] do
        wait()
        RobAmount.Text = "Money Earned: $" .. game.Players.LocalPlayer.leaderstats.Cash.Value - StartMoney

        for i, v in pairs(game:GetService("Workspace").ObjectSelection:GetChildren()) do
            if Names[v.Name] then
                RobAmount.Text = "Money Earned: $" .. game.Players.LocalPlayer.leaderstats.Cash.Value - StartMoney
                if JayhubFunctions["Rob"] == false then
                    break
                end
                v:FindFirstChild('Event', true):FireServer()
                game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("DataFetch")
                game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("DataFetch")
            end
        end

        


        local Condition = false
        local Count = 0

        repeat
            wait(1)
            AutoRobStatus.Text = "Status: Waiting..."
            RobAmount.Text = "Money Earned: $" .. game.Players.LocalPlayer.leaderstats.Cash.Value - StartMoney
            Count = Count + 1
            if Count == 150 then
                Condition = true
            end
            if Count > 150 then
                Condition = true
            end
            if JayhubFunctions["Rob"] == false then
                Condition = true
            end
        until Condition
    end


if playerdied == false then
    AutoRobStatus.Text = "Status: Resetting Player..."
    game.Players.LocalPlayer.Character:BreakJoints()
    wait(10)
    tp(Plr_Position.X, Plr_Position.Y, Plr_Position.Z)
    tp_bypass_done = false
    
    JayhubFunctions["Rob"] = false
    AutoRobStatus.Text = "Status: Offline"
end
JayhubFunctions["Rob"] = false
end


AutoRobBtn = lib:CreateToggle("Auto Rob", RobTab, function(enabled)
    if enabled == true then
        if JayhubFunctions["Xp"] == true then
            return false
        else
            JayhubFunctions["Rob"] = true
            spawn(Auto_Rob_Function)
        end
    elseif enabled == false then
        AutoRobStatus.Text = "Status: Stopping..."
        JayhubFunctions["Rob"] = false
    end
end)

function ServerHopFunction()
    
    local Exploit_name = Utils:GetExploit()

    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    local File = pcall(function()
        AllIDs = game:GetService('HttpService'):JSONDecode(readfile("JayHub_MC_NotSameServers.json"))
    end)
    if not File then
        table.insert(AllIDs, actualHour)
        writefile("JayHub_MC_NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                delfile("JayHub_MC_NotSameServers.json")
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        writefile("JayHub_MC_NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    
    function Teleport()
        if Exploit_name ~= "Electron" then
            queue_on_teleport("loadstring(game:HttpGet('https://jack1214060.xyz/jayhub/madcity/serverhop',true))()")
        elseif Exploit_name == "Electron" then
            queue_on_teleport[[loadstring(game:HttpGet('https://jack1214060.xyz/jayhub/madcity/serverhop',true))()]]
        end
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
    wait(20)
    game:GetService("TeleportService"):Teleport(1224212277, LocalPlayer)
end



--[[RobSmallRobs = lib:CreateButton("Rob all small Heist (no loop)", RobTab, function()

local Human = game.Players.LocalPlayer.Character.HumanoidRootPart
Human.Parent = nil
wait(0.1)
Human.Parent = game.Players.LocalPlayer.Character
wait(0.1)
local w = game:GetService("Workspace")
local ObjectSelection = w:WaitForChild("ObjectSelection")
for _,v in pairs(ObjectSelection:GetChildren()) do 
        if v.Name == "CashRegister" then 
            if v:FindFirstChild("SmashCash") then 
                local Event = v.SmashCash.SmashCash.Event
                Event:FireServer()
            end
        end
    if v.Name == "ATM" then 
        if v:FindFirstChild("ATM") then
            local Event = v.ATM.ATM.Event
            Event:FireServer()
        end
    end
    if v.Name == "Cash" then 
            if v:FindFirstChild("Cash") then
                local Event = v.Cash.Cash.Event
                Event:FireServer()
            end
    end
    if v.Name == "DiamondBox" then 
        if v:FindFirstChild("SmashCash") then 
            local Event = v.SmashCash.SmashCash.Event
            Event:FireServer()
        end
    end
    if v.Name == "Safe" then 
        if v:FindFirstChild("SmashCash") then
            local Event = v.SmashCash.SmashCash.Event
            Event:FireServer()
        end
    end
    if v.Name == "TV" then 
        if v:FindFirstChild("StealTV") then
            local Event = v.StealTV.StealTV.Event
            Event:FireServer()
        end
    end
    if v.Name == "TipJar" then 
        if v:FindFirstChild("SmashCash") then
            local Event = v.SmashCash.SmashCash.Event
            Event:FireServer()
        end
    end
    if v.Name == "Laptop" then 
        if v:FindFirstChild("Steal") then
            local Event = v.Steal.Steal.Event
            Event:FireServer()
        end
    end
    if v.Name == "Phone" then 
        if v:FindFirstChild("Steal") then
            local Event = v.Steal.Steal.Event
            Event:FireServer()
        end
    end
    if v.Name == "Luggage" then
        if v:FindFirstChild("SmashCash") then
            wait(0.001)
            local Event = v.SmashCash.SmashCash.Event
            Event:FireServer()
        end
    end
    if v.Name == "CrateDrop" then
        v.CrateDrop.CrateDrop.Event:FireServer()
    end
end
messagebox("This feature is disabled until further notice", 3)
end)]]

-- End Rob Tab

-- Xp Farm Tab

local xpRenderList = {}

XpFarmLabel = lib:CreateLabel("Xp Farm", XpFarmTab)
XpFarmLabel2 = lib:CreateLabel("Do not farm over 100 levels per 24h", XpFarmTab)

XpFarmLabelLevel = lib:CreateLabel("Current Level: " ..  game.Players.LocalPlayer.leaderstats.Rank.Value, XpFarmTab)
XpFarmLabelAmount = lib:CreateLabel("Levels Earned: 0", XpFarmTab)

function xpFarmThead()
    local start_xp = game.Players.LocalPlayer.leaderstats.Rank.Value
    XpFarmThreadRenderstep = game:GetService("RunService").RenderStepped:Connect(function()
        FarmedXp = game.Players.LocalPlayer.leaderstats.Rank.Value - start_xp
        XpFarmLabelLevel.Text = "Current Level: " ..  game.Players.LocalPlayer.leaderstats.Rank.Value
        XpFarmLabelAmount.Text = "Levels Earned: " .. FarmedXp
        if 90 < FarmedXp then
            JayhubFunctions["Xp"] = false
            for i=0, #xpRenderList do
                xpRenderList[i]:Disconnect()
            end
            game.Players.LocalPlayer.Character:BreakJoints()
            game:GetService("Players").LocalPlayer:Kick("You have reached the limit of 100 levels per day; Please rejoin the game to receive your rewards")
        end
    end)
end

function xpfarmfunction()
    if JayhubFunctions["Xp"] == true then
        game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("SetTeam", "Police")
        wait(0.75)
        spawn(xpFarmThead)
        for i,v in next, game.Players.LocalPlayer.PlayerGui:GetChildren() do
            if v:IsA'ScreenGui' then
                v:Destroy()
            end
        end
        for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if v.Name == "Handcuffs" then v.Parent = game:GetService("Players").LocalPlayer.Character end
        end
        local p = 0
        for i=1, 50 do
            if 50 > p then
                xpRenderList[p] = game:GetService("RunService").Heartbeat:Connect(function()
                    game:GetService("ReplicatedStorage").Event:FireServer("Eject", game.Players.LocalPlayer)
                end)
                p = p + 1
            else
                break
            end
        end
        --[[
        local Human = game.Players.LocalPlayer.Character.HumanoidRootPart
        Human.Parent = nil
        wait(0.1)
        Human.Parent = game.Players.LocalPlayer.Character]]
    elseif JayhubFunctions["Xp"] == false then

        for i=0, #xpRenderList do
            xpRenderList[i]:Disconnect()
        end
        game.Players.LocalPlayer.Character:BreakJoints()
        game:GetService("Players").LocalPlayer:Kick("Please rejoin the game to receive your rewards")
    end

end
XpFarmBtn = lib:CreateToggle("Xp Farm", XpFarmTab, function(enabled)
    if enabled == true then
        local Confirm = lib:CreateConfirmBox("Please do not farm over 100 levels per day", "Ok", "Cancel")
        if Confirm == true then
            JayhubFunctions["Xp"] = true
            xpfarmfunction()
        elseif Confirm == false then
            return false
        end
    elseif enabled == false then
        JayhubFunctions["Xp"] = false
        xpfarmfunction()
    end
end)

-- End Xp Farm Tab


-- russian man was here have nice day :)  