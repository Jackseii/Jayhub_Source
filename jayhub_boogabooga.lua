

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
        if idx == "JumpPower" then 
            return 50 
        end 
    end 
    return oldIndex(tbl, idx)
end)

setreadonly(mt, true)


lib = Library:CreateMain()


HomeTab = lib:CreateTab("Home", true)
TeleportsTab = lib:CreateTab("Teleports")
CharacterTab = lib:CreateTab("Character")
lib:CreateEsp()

TeleportLabel = lib:CreateLabel("Teleports", TeleportsTab)
CharacterLabel = lib:CreateLabel("Character", CharacterTab)

game:GetService("Players").LocalPlayer.Idled:connect(function()
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

JayhubFunctions = {

    MainFrameOpen = true,
    Tp_Bypassed = false,
    Noclip = false,
    Teleport = false,
    WalkSpeed = false,
    JumpPower = false,
    JumpPower_Amn = nil

}

local Jayhub_Active = true






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

local RunServiceStepped
RunServiceStepped = game:GetService("RunService").Stepped:connect(function()
    if JayhubFunctions["JumpPower"] == true then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = JayhubFunctions["JumpPower_Amn"]
    end
end)

getgenv().JayHub_RemoveGui = function()
    for key, value in pairs(JayhubFunctions) do
        value = false
    end
    Jayhub_Active = false
    RunServiceStepped:Disconnect()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    lib:DestroyGui()
end

KillGuiBtn = lib:CreateButton("Kill Gui", HomeTab, function()
    JayHub_RemoveGui()
end)



-- End Home Tab




for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren())do
    if v:IsA("Part") then
        v.Touched:connect(function(obj)
            if JayhubFunctions["Noclip"] == true then
                obj.CanCollide = false
            elseif JayhubFunctions["Noclip"] == false then
                obj.CanCollide = true
            end
        end)
    end
end


function tp_method(x, y, z)
    local valtomove = 10
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

local Tp_Part = nil

function tp(x, y, z)
    if JayhubFunctions["Tp_Bypassed"] == false then
        print(1)
        for i,v in pairs(game:GetService("Workspace").Deployables:GetChildren()) do
            if v:IsA("Model") and v.name == "Raft" then
                print(2)
                local plrcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.VehicleSeat.CFrame
                wait(1)
                v:MoveTo(Vector3.new(x, y, z))
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
                wait(1)
                Tp_Part = v
                JayhubFunctions["Tp_Bypassed"] = true
                break
            end
        end
    end
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

TpObjectTextBox = lib:CreateTextbox("Tp to Closest Object", "Object Name", true, TeleportsTab, function(thing) 
    local humanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
    local dictionary = {}
    local object = findObject(game:GetService("Workspace"),thing)
    local object2 = findObject(game:GetService("Workspace").Critters,thing)
    local object3 = findObject(game:GetService("Workspace").Deployables,thing)

    if object then
        for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:IsA("Model") and v.Name == object.Name then
                for _, o in pairs(v:GetChildren()) do
                    if o:IsA("Part") then
                        dictionary[v] = (humanoidRootPart.Position - o.Position).Magnitude
                        break
                    end
                end
            end
        end
    elseif object2 then
        for i, v in pairs(game:GetService("Workspace").Critters:GetChildren()) do
            if v:IsA("Model") and v.Name == object2.Name then
                for _, o in pairs(v:GetChildren()) do
                    if o:IsA("Part") then
                        dictionary[v] = (humanoidRootPart.Position - o.Position).Magnitude
                        break
                    end
                end
            end
        end

    elseif object3 then
        for i, v in pairs(game:GetService("Workspace").Deployables:GetChildren()) do
            if v:IsA("Model") and v.Name == object3.Name then
                for _, o in pairs(v:GetChildren()) do
                    if o:IsA("Part") then
                        dictionary[v] = (humanoidRootPart.Position - o.Position).Magnitude
                        break
                    end
                end
            end
        end

    end
    
    local array = {}
    for _, value in pairs(dictionary) do
        table.insert(array, tonumber(value))
    end
    table.sort(array)
    if array[1] then
        local key = array[1]
        for i, v in pairs(dictionary) do
            --print("Is " .. key .. " equivalent to " .. v)
            if v == key then
                for _, v in pairs(i:GetChildren()) do
                    if v:IsA("Part") then
                        tp(v.CFrame.X, v.CFrame.Y, v.CFrame.Z)
                        break
                    end
                end
                
                break
            end
        end
    end

end)

-- End Teleports Tab

--Character Tab



local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local hum = game.Players.LocalPlayer.Character.HumanoidRootPart
local wkey = false

mouse.KeyDown:connect(function(key)
    if JayhubFunctions["WalkSpeed"] == true then
        if key == "w" then
            wkey = true
            while wkey do
                hum.CFrame = hum.CFrame + hum.CFrame.lookVector * 4
                wait()
            end
        end
    end
end)

mouse.KeyUp:connect(function(key)
    if key == "w" then
        wkey = false
    end
end)


NoclipButton = lib:CreateToggle("Noclip", CharacterTab, function(enabled)
    if enabled == true then
        JayhubFunctions["Noclip"] = true
    elseif enabled == false then
        JayhubFunctions["Noclip"] = false
    end
end)

WalkSpeedBtn = lib:CreateToggle("WalkSpeed", CharacterTab, function(enabled)
    if enabled == true then
        JayhubFunctions["WalkSpeed"] = true
    elseif enabled == false then
        JayhubFunctions["WalkSpeed"] = false
    end
end)

JumpPowerSlider = lib:CreateSlider("JumpPower", 50, 500, CharacterTab, function(value) 
    JayhubFunctions["JumpPower_Amn"] = value
    JayhubFunctions["JumpPower"] = true
end)


-- End Character Tab



local jhrhie = false
function died_thread()
    while Jayhub_Active do
        wait(3)
        if jhrhie then jhrhie:Disconnect() end
        jhrhie = game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
            if Jayhub_Active == true then
                JayhubFunctions["Tp_Bypassed"] = false
                if Tp_Part then
                    Tp_Part:Destroy()
                end
                wait(3)
                game:GetService("ReplicatedStorage").Events.SpawnFirst:FireServer()
                wait(3)
                game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                wait(2)
                for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren())do
                    if v:IsA("Part") then
                        v.Touched:connect(function(obj)
                            if JayhubFunctions["Noclip"] == true then
                                obj.CanCollide = false
                            elseif JayhubFunctions["Noclip"] == false then
                                obj.CanCollide = true
                            end
                        end)
                    end
                end

                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                local hum = game.Players.LocalPlayer.Character.HumanoidRootPart
                local wkey = false

                mouse.KeyDown:connect(function(key)
                    if JayhubFunctions["WalkSpeed"] == true then
                        if key == "w" then
                            wkey = true
                            while wkey do
                                hum.CFrame = hum.CFrame + hum.CFrame.lookVector * 4
                                wait()
                            end
                        end
                    end
                end)

                mouse.KeyUp:connect(function(key)
                    if key == "w" then
                        wkey = false
                    end
                end)

            end
        end)
    end
end
spawn(died_thread)