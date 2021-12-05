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

local mt = getrawmetatable(game)
local oldIndex = mt.__index 
setreadonly(mt, false)

mt.__index = newcclosure(function(tbl, idx)
    if not checkcaller() then 
        if idx == "WalkSpeed" then
            return 16 
        elseif idx == "JumpPower" then 
            return 50 
        end 
    end 
    return oldIndex(tbl, idx)
end)

setreadonly(mt, true)

function modify(str,val) 
    for i,v in pairs(getgc(true))do 
        if type(v)=="table" and rawget(v,str) then 
            v[str]=val 
        end 
    end 
end

lib = Library:CreateMain()


HomeTab = lib:CreateTab("Home", true)
TeleportsTab = lib:CreateTab("Teleports")
CharacterTab = lib:CreateTab("Character")
lib:CreateEsp()
GunTab = lib:CreateTab("Gun Mods")
MiscTab = lib:CreateTab("Miscellaneous")

TeleportLabel = lib:CreateLabel("Teleports", TeleportsTab)
CharacterLabel = lib:CreateLabel("Character", CharacterTab)
GunLabel = lib:CreateLabel("Gun Mods", GunTab)
MiscLabel = lib:CreateLabel("Miscellaneous", MiscTab)

game:GetService("Players").LocalPlayer.Idled:connect(function()
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

JayhubFunctions = {

    MainFrameOpen = true,
    Aimbot = false,
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

-- Gun Tab
local PLAYER  = game.Players.LocalPlayer
local MOUSE   = PLAYER:GetMouse()
local CC      = game.Workspace.CurrentCamera
local AIMBOT_ENABLED = false

local TRACK = nil
local FREE_FOR_ALL = false

function GetNearestPlayerToMouse()
	local PLAYERS      = {}
	local PLAYER_HOLD  = {}
	local DISTANCES    = {}
	for i, v in pairs(game.Players:GetPlayers()) do
		if v ~= PLAYER then
			table.insert(PLAYERS, v)
		end
	end
	for i, v in pairs(PLAYERS) do
		if FREE_FOR_ALL == false then
			if v and (v.Character) ~= nil and v.TeamColor ~= PLAYER.TeamColor then
				local AIM = v.Character:FindFirstChild("Head")
				if AIM ~= nil then
					local DISTANCE                 = (AIM.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
					local RAY                      = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (MOUSE.Hit.p - CC.CoordinateFrame.p).unit * DISTANCE)
					local HIT,POS                  = game.Workspace:FindPartOnRay(RAY, game.Workspace)
					local DIFF                     = math.floor((POS - AIM.Position).magnitude)
					PLAYER_HOLD[v.Name .. i]       = {}
					PLAYER_HOLD[v.Name .. i].dist  = DISTANCE
					PLAYER_HOLD[v.Name .. i].plr   = v
					PLAYER_HOLD[v.Name .. i].diff  = DIFF
					table.insert(DISTANCES, DIFF)
				end
			end
		elseif FREE_FOR_ALL == true then
			local AIM = v.Character:FindFirstChild("Head")
			if AIM ~= nil then
				local DISTANCE                 = (AIM.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
				local RAY                      = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (MOUSE.Hit.p - CC.CoordinateFrame.p).unit * DISTANCE)
				local HIT,POS                  = game.Workspace:FindPartOnRay(RAY, game.Workspace)
				local DIFF                     = math.floor((POS - AIM.Position).magnitude)
				PLAYER_HOLD[v.Name .. i]       = {}
				PLAYER_HOLD[v.Name .. i].dist  = DISTANCE
				PLAYER_HOLD[v.Name .. i].plr   = v
				PLAYER_HOLD[v.Name .. i].diff  = DIFF
				table.insert(DISTANCES, DIFF)
			end
		end
	end
	
	if unpack(DISTANCES) == nil then
		return false
	end
	
	local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
	if L_DISTANCE > 20 then
		return false
	end
	
	for i, v in pairs(PLAYER_HOLD) do
		if v.diff == L_DISTANCE then
			return v.plr
		end
	end
	return false
end







MOUSE.KeyDown:connect(function(KEY)
    KEY = KEY:lower():byte()
    print(KEY)
    if JayhubFunctions["Aimbot"] == true then
        if KEY == 114 then
            if AIMBOT_ENABLED == false then
                AIMBOT_ENABLED = true
            elseif AIMBOT_ENABLED == true then
                wait()
                TRACK = false
                AIMBOT_ENABLED = false
            end
        end
    end
end)

AimBotToggle = lib:CreateButton("Aimbot (R)", GunTab, function()
    if JayhubFunctions["Aimbot"] ~= true then
        JayhubFunctions["Aimbot"] = true
    end
end)

FreeForAllToggle = lib:CreateToggle("Free For All (For Aimbot)", GunTab, function(enabled)
    if enabled == true then
        FreeForAllToggle = true
    elseif enabled == false then
        FREE_FOR_ALL = false
    end
end)

game:GetService('RunService').RenderStepped:connect(function()
	if AIMBOT_ENABLED then
		local TARGET = GetNearestPlayerToMouse()
		if (TARGET ~= false) then
			local AIM = TARGET.Character:FindFirstChild("Head")
			if AIM then
				CC.CoordinateFrame = CFrame.new(CC.CoordinateFrame.p, AIM.CFrame.p)
			end
		end
	end
end)

UnlockAllGunsGtn = lib:CreateButton("Unlock All Guns", GunTab, function()
    local a = require(game:GetService("ReplicatedStorage").Framework.Library)
    local b = a.GunCmds.DoesOwnGun
    local c = a.Network.Fire
    a.GunCmds.DoesOwnGun = function()
        return true
    end
    a.Network.Fire = function(d, e, ...)
        if d == "Request Respawn" and not b(game:GetService("Players").LocalPlayer, e) then
            return c(d, "1")
        end
        return c(d, e, ...)
    end

end)

--[[local KillAll = false

function KillAllFunction()
    wait(2)
    JayhubFunctions["Noclip"] = true
    for i,v in pairs(game:GetService("Workspace")["__MAP"]:GetChildren()) do
        v:Destroy()
    end
    for i,v in pairs(getgc(true)) do 
        if type(v)=="table" and rawget(v,"velocity") then 
            v.automatic=true 
        end 
    end
    modify("velocity",1000000)
    modify("firerate",0) 
    modify("burstDelay",0)
    modify("LoadedAmmo",math.huge)
    while KillAll do
        wait()
        for i, v in pairs(game.Players:GetChildren()) do
            if FREE_FOR_ALL == false then
                if v and (v.Character) ~= nil and v.TeamColor ~= game.Players.LocalPlayer.TeamColor then
                    if not KillAll then break end
                    local AimRunService
                    local Aim
                    AimRunService = game:GetService('RunService').RenderStepped:connect(function()
                        AIM = v.Character:FindFirstChild("Head")
                        if AIM then
                            CC.CoordinateFrame = CFrame.new(CC.CoordinateFrame.p, AIM.CFrame.p)
                            mouse1click()
                        end
                    end)
                    
                    local Condition = false
                    repeat
                        if not AIM or not AIM:FindFirstChild("Character") or not AIM.Character:FindFirstChild("HumanoidRootPart") then
                            Condition = true
                        end
                        wait(1)
                        Count = Count + 1
                        if Count == 3 then
                            Condition = true
                        end
                        if Count > 3 then
                            Condition = true
                        end
                        if KillAll == false then
                            Condition = true
                        end
                    until Condition
                    AimRunService:Disconnect()

                end
            end
        end
    end
end




KillAllToggle = lib:CreateToggle("Kill All", GunTab, function(enabled)
    if enabled == true then
        KillAll = true
        spawn(KillAllFunction)
    elseif enabled == false then
        KillAll = false
    end
end)]]

AutomaticBtn = lib:CreateButton("Fully Automatic", GunTab, function()
    for i,v in pairs(getgc(true)) do 
        if type(v)=="table" and rawget(v,"velocity") then 
            v.automatic=true 
        end 
    end
end)

NoRecoilBtn = lib:CreateButton("No Recoil", GunTab, function()
    modify("velocity",1000000)
end)


RapidFireBtn = lib:CreateButton("Rapid Fire", GunTab, function()
    modify("firerate",0) 
    modify("burstDelay",0)
end)

InfAmmoBtn = lib:CreateButton("Infinite Ammo", GunTab, function()
    modify("LoadedAmmo",math.huge)
end)

ZoomBtn = lib:CreateButton("Zoom", GunTab, function()
    modify("zoomAmount",5)
end)


-- End Gun Tab

-- Misc Tab





DeleteMapBtn = lib:CreateButton("Clear Map", MiscTab, function()
    JayhubFunctions["Noclip"] = true
    for i,v in pairs(game:GetService("Workspace")["__MAP"]:GetChildren()) do
        v:Destroy()
    end
end)

DestroyBarriersBtn = lib:CreateButton("Destroy Barriers", MiscTab, function()
    game:GetService("Workspace")["__MAP"].SpawnShields.Red:Destroy()
    game:GetService("Workspace")["__MAP"].SpawnShields.Blue:Destroy()
end)


-- End Misc Tab

