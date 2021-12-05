


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
lib:CreateEsp()
RobTab = lib:CreateTab("Auto Rob")
CarTab = lib:CreateTab("Car Mods")
GunTab = lib:CreateTab("Gun Mods")
MiscTab = lib:CreateTab("Miscellaneous")





TeleportLabel = lib:CreateLabel("Teleports", TeleportsTab)
CharacterLabel = lib:CreateLabel("Character", CharacterTab)
RobLabel = lib:CreateLabel("Auto Rob", RobTab)
CarLabel = lib:CreateLabel("Car Mods", CarTab)
GunLabel = lib:CreateLabel("Gun Mods", GunTab)
MiscLabel = lib:CreateLabel("Miscellaneous", MiscTab)

game:GetService("Players").LocalPlayer.Idled:connect(function()
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0,0),game:GetService("Workspace").CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),game:GetService("Workspace").CurrentCamera.CFrame)
end)

JayhubFunctions = {

    Active = true,
    MainFrameOpen = true,
    StayInCar = false,
    TpSpeed = 350,
    Rob = false,
    Aimbot = false,
    Noclip = false,
    Teleport = false,
    WalkSpeed = false,
    JumpPower = false,
    WalkSpeed_Amn = nil,
    JumpPower_Amn = nil,
    infnitro = false,
    NoCarFlip = false,
    NoTirePop = false,
    RainbowCar = false

}

JailbreakRemotes = {
    Entercar = "bb10f71e",
    Exitcar = "b1f10b63"



}
local NotificationService = require(game:GetService("ReplicatedStorage").Game.Notification)
function Notification(message, duration)
    NotificationService.new({
        Text = message,
        Duration = duration
    })
end

Notification("Collecting Functions...\nThis may take a while", 3)

wait(2)

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

local Functions = {}
local specs
local guns
local PuzzleTable
local NewCarTable = {}
local OldCarTable = {}

local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote
local Hashes = {}
local DoorsTable = {}
for i, v in pairs(getgc(true)) do
    if type(v) == "function" then
        if getfenv(v).script == player.PlayerScripts.LocalScript then
            local upvals = getupvalues(v)
            for j, k in pairs(upvals) do
                if type(k) == 'table' then
                    if rawget(k, 'LastVehicleExit') then
                        Functions['ExitVehicle'] = v
                    end
                    if rawget(k, 'FireServer') then
                        Remote = k
                    end
                    if rawget(k, 'PromptPurchase') then
                        Functions['Fireworks'] = k.Fireworks
                        Functions['GetCarTable'] = k.GetVehiclePacket
                    end
                    if rawget(k, 'Nitro') then
                        NitroTable = k
                    end
                end
                if tostring(upvals[3]) == 'Donut' then
                    Functions['GetItems'] = v
                end
            end
            local const = getconstants(v)
            if table.find(const, "You can't drive this. Hold to hijack it.") then
                Functions["EnterVehicle"] = function(vehicle)
                    getupvalue(v, 3)(vehicle)
                end
                Functions['Eject'] = function(player)
                    local toEject = false
                    for a, b in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
                        for c, d in pairs(b:GetChildren()) do
                            if (d.Name == 'Seat') or (d.Name == 'Passenger') then
                                if d:FindFirstChild("PlayerName").Value == player.Name then
                                    toEject = b
                                    break
                                end
                            end
                        end
                    end
                    if toEject then
                        getupvalue(v, 2)(toEject)
                    end
                end
            end
            if table.find(const, 'Sprint') and table.find(const, 'Crawl') then
                Functions['Crawl'] = function()
                    v({
                        ['Name'] = 'Crawl'
                    }, true, nil)
                end
                Functions['Punch'] = function()
                    v({
                        ['Name'] = 'Punch'
                    }, true, nil)
                end
                Functions['Horn'] = function()
                    v({
                        ['Name'] = 'Horn'
                    }, true, nil)
                end
                Functions['Flip'] = function()
                    v({
                        ['Name'] = 'Flip'
                    }, true, nil)
                end
            end
            if table.find(const, 'PlusCash') then
                Functions['addCash'] = v 
            end
            if table.find(const, "ShouldArrest") then
                local arrest = getupvalue(v, 1)
                local pickpocket = getupvalue(v, 2)
                if type(arrest) == 'function' then
                    for j, k in pairs(getupvalues(arrest)) do
                        if type(k) == 'function' then
                            Functions['Arrest'] = k
                            break
                        end
                    end
                    for j, k in pairs(getupvalues(pickpocket)) do
                        if type(k) == 'function' then
                            Functions['PickPocket'] = k
                            break
                        end
                    end
                end
            elseif table.find(const, "SequenceRequireState") and table.find(const, "State") and table.find(const, "Open") then
                Functions['OpenDoor'] = v
            end
        elseif getfenv(v).script == ReplicatedStorage.Game.TeamChooseUI then
            local proto = getprotos(v)
            for j, k in pairs(proto) do
                local const = getconstants(k)
                if table.find(const, 'Police') then
                    Functions['ChangeTeam'] = k 
                end
            end
        --[[elseif getfenv(v).script == ReplicatedStorage.Game.GunShop.GunShopUI then
            local const = getconstants(v)
            local GunHash
            local Amount = 0
            for ii, vv in pairs(const) do
                print("yes1")
                if type(vv) == 'string' then
                    print("yes2")
                    print(vv)
                    if (string.len(vv) == 8) and table.find(const, 'FireServer') then
                        Amount = Amount + 1
                        print("yesy")
                        if Amount == 2 then
                            print(string.reverse(vv))
                            GunHash = string.reverse(vv)
                            break
                        end
                    end
                end
            end
            Functions['GrabGun'] = function(gunname)
                Remote:FireServer(GunHash, gunname)
            end
        ]]        
        elseif getfenv(v).script == ReplicatedStorage.Game.Garage.GarageUI then
            local const = getconstants(v)
            if table.find(const, 'Type') and table.find(const, 'FireServer') and table.find(const, 'Make') then
                Functions['SpawnVehicle'] = v
            end
        elseif getfenv(v).script == ReplicatedStorage.Game.NukeControl then
            local const = getconstants(v)
            if (const[1] == 'assert') and (const[3] == 'Nuke') then
                Functions['Nuke'] = v 
            end
        end
    elseif type(v) == "table" then
        if rawget(v, 'CircleAction') then
            specs = v.CircleAction.Specs
        end
        if PuzzleTable == nil and type(rawget(v, "Init")) == "function" then
            for pc, qc in next, getupvalues(rawget(v, "Init")) do
                if type(qc) == "table" and rawget(qc, "SetGrid") then
                    PuzzleTable = qc
                    break
                end
            end
        end
    end

end
--[[
Functions["GrabGun"] = function(name)
    local const = getconstants(require(ReplicatedStorage.Game.GunShop.GunShopUI).displayList)
    local GunHash
    local Amount = 0
    for ii, vv in pairs(const) do
        print("yes1")
        if type(vv) == 'string' then
            print("yes2")
            print(vv)
            if (string.len(vv) == 8) and table.find(const, 'FireServer') then
                Amount = Amount + 1
                print("yesy")
                if Amount == 2 then
                    print(string.reverse(vv))
                    GunHash = string.reverse(vv)
                    --break
                end
            end
        end
    end
end]]

Functions['editVehicle'] = getproto(require(ReplicatedStorage.Game.Garage.GarageUI).Init, 1)
Functions['Tase'] = function(target)
    local const = getconstants(require(ReplicatedStorage.Game.Item.Taser).Tase) 
    local TaseHash
    for i, v in pairs(const) do
        if type(v) == 'string' then
            if (string.len(v) == 8) and (i > table.find(const, 'GetPlayerFromCharacter')) then
                TaseHash = string.reverse(v)
                break
            end
        end
    end
    Remote:FireServer(TaseHash, target.Name, target.Character.HumanoidRootPart, target.Character.HumanoidRootPart.Position)
end
Functions['Eat'] = function()
    local eat = getproto(require(ReplicatedStorage.Game.Item.Donut).InputBegan, 1) 
    setupvalue(eat, 1, { 
        Config = {Motion = {Hip = {Springs = {ItemRotation = 1} } } },
        SpringItemRotation = { SetTarget = function() end },
        Local = true,
        LastConsumed = 0
    })
    setupvalue(eat, 2, Remote)
    eat()
end

function Call(table)
   table:Callback(true) 
end
function FindAction(name)
    for i, v in pairs(Actions) do
        if v.Name == name then
            return v
        end
    end
end

function Equip(Name)
    for i, v in pairs(getgc(true)) do
        if type(v) == 'table' then
            if (rawget(v, 'Name') == Name) and rawget(v, 'Frame') then
                require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Equip(Player, v)
                break
            end
        end
    end
end

function Unequip()
    require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Unequip()
end

for i,v in next, getgc(true) do
    if type(v) == "table" and rawget(v, 'Ragdoll') and rawget(v, 'Unragdoll') then
        v.Ragdoll = function() wait(9e9) end
    end
end

function FireRemote(hash, ...)
    local Arguments = ...
    
    
    if Arguments then
        remote:FireServer(hash, unpack(...))
    else
        remote:FireServer(hash)
    end
end

setreadonly(mt, true)

JailbreakMarkers = {
    ["Museum"] = nil,
    ["Power Plant"] = nil
}

for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.WorldMarkersGui:GetChildren()) do
	if v.name == "ImageLabel" then
		if v.ImageLabel.ImageLabel.Image == "rbxassetid://4643749917" then
            JailbreakMarkers["Museum"] = v
        end
        if v.ImageLabel.ImageLabel.Image == "rbxassetid://4643749556" then
            JailbreakMarkers["Power Plant"] = v
        end
    end
end

local GasStation = nil
local DonutShop = nil
for i, v in pairs(game:GetService("Workspace").SmallStores:GetChildren()) do
	if v.Position == Vector3.new(-1583.94, 18.9381, 724.866) then
		GasStation = v
	else
		DonutShop = v
	end
end

spawn(function() 
    wait(0.2)
    Functions['Fireworks'](15)
end)
Notification("Done", 2)


local DiedEvent = nil
function died_thread()
    while JayhubFunctions["Active"] do
        wait(2)
        if DiedEvent then DiedEvent:Disconnect() end
        DiedEvent = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
            if JayhubFunctions["Active"] == true then
                JayhubFunctions["Teleport"] = false
                if JayhubFunctions["Rob"] == true then
                    JayhubFunctions["Rob"] = false
                    wait(5)
                    repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.MainGui.CellTime.Visible == false
                    JayhubFunctions["Rob"] = true
                    AutoRobFunction()
                end
            end
        end)
    end
end
spawn(died_thread)
local PlayerArrestFix
PlayerArrestFix = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.CellTime:GetPropertyChangedSignal("Visible"):Connect(function()
    if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.CellTime.Visible == true then
        if JayhubFunctions["Active"] == true then
            game:GetService("Players").LocalPlayer.Character:BreakJoints()
        end
    end
end)

local CarPropFix
CarPropFix = game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
    if JayhubFunctions["Active"] == true then
        if game:GetService("Players").LocalPlayer.Character.Humanoid.Sit == true then
            wait(0.2)
            OldCarTable["GarageEngineSpeed"] = Functions['GetCarTable']().GarageEngineSpeed
            OldCarTable["Height"] = Functions['GetCarTable']().Height
            OldCarTable["TurnSpeed"] = Functions['GetCarTable']().TurnSpeed
            OldCarTable["Suspension"] = Functions['GetCarTable']().Suspension
            if JayhubFunctions["Teleport"] == false then
                if NewCarTable["GarageEngineSpeed"] then
                    Functions['GetCarTable']().GarageEngineSpeed = NewCarTable["GarageEngineSpeed"]
                end
                if NewCarTable["Height"] then
                    Functions['GetCarTable']().Height = NewCarTable["Height"]
                end
                if NewCarTable["TurnSpeed"] then
                    Functions['GetCarTable']().TurnSpeed = NewCarTable["TurnSpeed"]
                end
                if NewCarTable["Suspension"] then
                    Functions['GetCarTable']().Suspension = NewCarTable["Suspension"]
                end
            end
        end
    end
end)





local RunServiceStepped
RunServiceStepped = game:GetService("RunService").Stepped:connect(function()
    if JayhubFunctions["WalkSpeed"] == true then
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = JayhubFunctions["WalkSpeed_Amn"]
    end
    if JayhubFunctions["JumpPower"] == true then
        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = JayhubFunctions["JumpPower_Amn"]
    end

    if JayhubFunctions["Noclip"] == true then
        game:GetService("Players").LocalPlayer.Character.Head.CanCollide = false
        game:GetService("Players").LocalPlayer.Character.LowerTorso.CanCollide = false
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CanCollide = false
        game:GetService("Players").LocalPlayer.Character.UpperTorso.CanCollide = false
        --game:GetService("Players").LocalPlayer.Character:findFirstChildOfClass("Humanoid"):ChangeState(11)
    end
end)



function RemoveLasers()
    for _,v in pairs(game:GetService("Workspace").Jewelrys:FindFirstChildWhichIsA("Model"):GetChildren()) do
        if v:IsA("Part") and v.Material==Enum.Material.Neon then
            v:Destroy()
        end
        if v.Name == "Lasers" then
            v:Destroy()
        end
    end
    for _,v in pairs(game:GetService("Workspace").Banks:FindFirstChildWhichIsA("Model").Layout:FindFirstChildWhichIsA("Model"):GetDescendants()) do
        if v:IsA("Part") and v.Material==Enum.Material.Neon then
            v:Destroy()
        end
        if v.Name == "Lasers" then
            v:Destroy()
        end
    end
    for _,v in pairs(game:GetService("Workspace").Museum:GetDescendants()) do
        if v:IsA("Part") and v.Material==Enum.Material.Neon then
            v:Destroy()
        end
        if v.Name == "Lasers" then
            v:Destroy()
        end
    end
end

function setgrav(amn)
    if amn == true then
        game:GetService("Workspace").Gravity = 196.2
    else
        game:GetService("Workspace").Gravity = amn
    end
end


function hover(arg)
    if arg == nil then arg = true end
    if arg == true then
        local player = game:GetService("Players").LocalPlayer

        local activePlayer = player.Character
        repeat
            wait()
        until activePlayer:FindFirstChild("UpperTorso")
        local b = Instance.new("BodyForce")
        b.Name = "BF"
        b.Force = Vector3.new(0,0,0)
        b.Parent = activePlayer.PrimaryPart
        local playerMass = 0
        for _,obj in pairs(activePlayer:GetDescendants()) do
            if obj:IsA("BasePart") then
                playerMass = playerMass+obj:GetMass()
            end
        end
        playerMass = playerMass 
        local hoverForce = playerMass * game:GetService("Workspace").Gravity
        activePlayer.PrimaryPart.BF.Force = Vector3.new(0,hoverForce,0)
    elseif arg == false then
        if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BF") then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BF"):Destroy()
        end
    elseif arg == "data" then
        if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BF") then
            return true
        else
            return false
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
    Notification("Discord Server copied to clipboard", 3)
end)

ResetBtn = lib:CreateButton("Reset Player", HomeTab, function()
    game:GetService("Players").LocalPlayer.Character:BreakJoints()
end)

getgenv().JayHub_RemoveGui = function()
    for key, value in pairs(JayhubFunctions) do 
        value = false
    end
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 16
    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = 50
    RunServiceStepped:Disconnect()
    PlayerArrestFix:Disconnect()
    CarPropFix:Disconnect()
    lib:DestroyGui()
end

KillGuiBtn = lib:CreateButton("Kill Gui", HomeTab, function()
    JayHub_RemoveGui()
end)



-- End Home Tab

-- Teleports Tab

function findnearestcar(carnum)
    carnum = carnum or 1
    dictionary = {}
    local car = nil
    for i, v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
        if v.name == "Camaro" then
            for _, o in pairs(v:GetChildren()) do
                if o:IsA("Part") then
                    dictionary[v] = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - o.Position).Magnitude
                    break
                end
            end
        end
    end

    local array = {}
    for _, value in pairs(dictionary) do
        table.insert(array, tonumber(value))
    end
    table.sort(array)
    if array[carnum] then
        local key = array[carnum]
        for i, v in pairs(dictionary) do
            if v == key then
                if i.Seat.Player.Value ~= true then
                    return i
                end
            end
        end
    end
end



function tweenModel(model, Val1, Val2, Val3, speed)
    speed = speed or JayhubFunctions["TpSpeed"]
    n = Vector3.new(0, 0, 0)

    



    local CFrameValue = Instance.new("CFrameValue")
    CFrameValue.Value = model:GetPrimaryPartCFrame()



    local stepconn = game:GetService("RunService").Stepped:Connect(function()
        model:SetPrimaryPartCFrame(CFrame.new(CFrameValue.Value.X, Val2, CFrameValue.Value.Z))
        model.Engine.Velocity, model.Engine.RotVelocity = n, n
    end)

    local function Bet(Val1, Val2)
        local Resp = (Vector3.new(Val1.X) - Vector3.new(Val2.X)).magnitude + (Vector3.new(Val1.Y) - Vector3.new(Val2.Y)).magnitude + (Vector3.new(Val1.Z) - Vector3.new(Val2.Z)).magnitude
        return Resp / speed
    end

    local Ang = nil
    local Pos = Vector3.new(Val1, Val2, Val3)
    local Cff




    Cff = CFrame.new(Pos.X, Pos.Y, Pos.Z)





    local Time = Bet(CFrameValue.Value, Cff.p)
    local Speed = TweenInfo.new(Time, Enum.EasingStyle.Linear)
    local CF = {Value = Cff}

    local tween = game:GetService("TweenService"):Create(CFrameValue, Speed, CF)
    tween:Play()
    tween.Completed:connect(function()
        CFrameValue:Destroy()
    end)
    wait(Time)
    stepconn:Disconnect()
    wait(0.4)

    

end



function tpplr(x, y, z, val4, val5, val6)
    local hover_data = hover("data")
    hover(false)



    local function Bet(Val1, Val2)
        local Resp = (Vector3.new(Val1.X) - Vector3.new(Val2.X)).magnitude + (Vector3.new(Val1.Y) - Vector3.new(Val2.Y)).magnitude + (Vector3.new(Val1.Z) - Vector3.new(Val2.Z)).magnitude
        return Resp / 110
    end

    local function Tlprt(Val1, Val2, Val3, Val4, Val5, Val6)
        local CFrameValue = Instance.new("CFrameValue")
        CFrameValue.Value = game:GetService("Players").LocalPlayer.Character:GetPrimaryPartCFrame()
    


        local stepconn = game:GetService("RunService").Stepped:Connect(function()
            game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(CFrameValue.Value.X, CFrameValue.Value.Y, CFrameValue.Value.Z), Vector3.new(Val4, Val5, Val6)))
        end)
        local Ang = nil
        local Pos = Vector3.new(Val1, Val2, Val3)
        local Cff

        if Val4 ~= nil and Val5 ~= nil and Val6 ~= nil then
        Ang = Vector3.new(Val4, Val5, Val6)
        end

        if Val4 ~= nil and Val5 ~= nil and Val6 ~= nil then
            Cff = CFrame.new(Pos.X, Pos.Y, Pos.Z) * CFrame.Angles(Val4, Val5, Val6)
        else
            Cff = CFrame.new(Pos.X, Pos.Y, Pos.Z)
        end

        local HRP = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        if not HRP:FindFirstChild("Pos") then
        local Pos = Instance.new("BodyForce", HRP)
        Pos.Name = "Pos"
        end


        HRP.Pos.Force = Vector3.new(0,2393,0)
        local Time = Bet(CFrameValue.Value, Cff.p)
        local Speed = TweenInfo.new(Time, Enum.EasingStyle.Linear)
        local CF = {Value = Cff}
    
        local tween = game:GetService("TweenService"):Create(CFrameValue, Speed, CF)
        tween:Play()
        tween.Completed:connect(function()
            CFrameValue:Destroy()
        end)
        local DiedEvent
        DiedEvent = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
            tween:Cancel()
        end)
        local ArrestedEvent
        ArrestedEvent = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.CellTime:GetPropertyChangedSignal("Visible"):Connect(function()
            if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.CellTime.Visible == true then
                tween:Cancel()
            end
        end)
        tween.Completed:Wait()
        stepconn:Disconnect()
        DiedEvent:Disconnect()
        ArrestedEvent:Disconnect()
        game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(x, y, z))
        wait(0.2)

        HRP.Pos.Force = Vector3.new(0,0,0)
    end
    if Val4 ~= nil and Val5 ~= nil and Val6 ~= nil then
        Tlprt(x, y, z, val4, val5, val6)
    else
        Tlprt(x, y, z)
    end

    hover(hover_data)
end


function tp(x, y, z, amount)
    -- note: try tping player inside vehicle instead
    amount = amount or 1
    local hover_data = hover("data")
    hover(false)
    repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.MainGui.CellTime.Visible == false
    if JayhubFunctions["Teleport"] == false then
        JayhubFunctions["Teleport"] = true
        local insidecar = false
        for i,v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
            if v:findFirstChild("Seat") then
                if v.Seat:findFirstChild("PlayerName") then
                    if v.Seat.PlayerName.Value == game:GetService("Players").LocalPlayer.Name then
                        insidecar = true
                    end
                end
            end
        end

        if not insidecar then
            local car = findnearestcar()
            if not car then Functions['SpawnVehicle']({Type = "Chassis", Make = "Camaro"}) wait(1) end
            
            local plrcframe = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
            local seatcframe = car.Engine.CFrame

            if car:FindFirstChild("Model") and car.Model:FindFirstChild("Body") then
                car.Model.Body.CanCollide = false
            end
            if car:FindFirstChild("Step") then
                car.Step.CanCollide = false
            end

            wait()
            local plrVector = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position

            Functions["EnterVehicle"](car.Seat)

            wait(0.2)
            if not game:GetService("Players").LocalPlayer.Character.Humanoid.Sit == true then
                if amount > 1 then    
                    car = findnearestcar(amount)
                else
                    car = findnearestcar()
                end
                if amount < 5 and car then
                    wait(0.4)
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = car.Engine.CFrame
                    if car:FindFirstChild("Model") and car.Model:FindFirstChild("Body") then
                        car.Model.Body.CanCollide = false
                    end
                    if car:FindFirstChild("Step") then
                        car.Step.CanCollide = false
                    end

                    --[[for i=1, 30 do
                        wait()
                        if game:GetService("Players").LocalPlayer.Character.Humanoid.Sit == true then break end
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = car.Engine.CFrame
                        Functions["EnterVehicle"](car.Seat)
                    end]]
                    tpplr(car.Engine.CFrame.X, car.Engine.CFrame.Y, car.Engine.CFrame.Z)
                    Functions["EnterVehicle"](car.Seat)
                else
                    print("Tp Failed")
                    JayhubFunctions["Teleport"] = false
                    return
                end

                wait(0.3)
                if game:GetService("Players").LocalPlayer.Character.Humanoid.Sit == false then
                    JayhubFunctions["Teleport"] = false
                    tp(x, y, z, amount+1)
                    return
                end
                wait()
            end

            
        end
        for i,v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
            if v:findFirstChild("Seat") then
                if v.Seat.PlayerName.Value == game:GetService("Players").LocalPlayer.Name then
                    local car_cframe = v.Engine.CFrame
                    local Org_Weight = v.Weight.Size

                    v.Weight.Size = Vector3.new(2.33, 3, 16)

                    v:SetPrimaryPartCFrame(CFrame.new(car_cframe.X, 300, car_cframe.Z))


                    tweenModel(v, x, 300, z)

                    

                    
                    local plrcframe = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame

                    v.Weight.Size = Org_Weight
                    v:SetPrimaryPartCFrame(CFrame.new(x, y, z))

                    
                    

                    wait(0.3)
                    
                    if JayhubFunctions["StayInCar"] ~= true then
                        Functions['ExitVehicle']()
            
                        wait(0.5)
                        
                        game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(x, y, z))


                    end

                    if v:FindFirstChild("Model") and v:FindFirstChild("Body") then
                        v.Model.Body.CanCollide = true
                    end
                    if v:FindFirstChild("Step") then
                        v.Step.CanCollide = true
                    end

                    
                    
    

                    break
                    
                end
            end
        end
        JayhubFunctions["Teleport"] = false
        hover(hover_data)
    else
        Notification("Your already teleporting", 2)
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

--[[TpSpeedSlider = lib:CreateSlider("Tp Speed", 30, 350, TeleportsTab, function(value) 
    JayhubFunctions["TpSpeed"] = value
end)

lib:SetSlider(TpSpeedSlider, 350)

StayInCarToggle = lib:CreateToggle("Stay In Car", TeleportsTab, function(enabled)
    if enabled == true then
        JayhubFunctions["StayInCar"] = true
    elseif enabled == false then
        JayhubFunctions["StayInCar"] = false
    end
end)]]

local locations_array = {
    [1] = "Jail In",
    [2] = "Jail Out",
    [3] = "Bank",
    [4] = "Jewelry",
    [5] = "Crim Base",
    [6] = "Cave Base",
    [7] = "Police Station 1",
    [8] = "Police Station 2",
    [9] = "1m",
    [10] = "Radio",
    [11] = "Bridge1",
    [12] = "Bridge2",
    [13] = "Museum",
    [14] = "Donut Shop",
    [15] = "Gas Station",
    [16] = "Pet Store",
    [17] = "Gun Shop",
    [18] = "Server",
    [19] = "Military Base",
    [20] = "Ski",
    [21] = "Power Plant",
    [22] = "Jetpack",
    [23] = "Airport",
    [24] = "Cove"
}

local locations = { 
    ["Jail In"] = CFrame.new(-1218.9178466797, 18.447998046875, -1758.7291259766),
    ["Jail Out"] = CFrame.new(-1169.9268798828, 18.395830154419, -1385.6032714844),
    ["Bank"] = CFrame.new(8.4118766784668, 18.265832901001, 773.60656738281), 
    ["Jewelry"] = CFrame.new(68.45622253418, 18.263645172119, 1311.7567138672), 
    ["Crim Base"] = CFrame.new(-235, 17.225, 1623), 
    ["Cave Base"] = CFrame.new(1638, 48.136, -1767), 
    ["Police Station 1"] = CFrame.new(-1193.8762207031, 18.898077011108, -1580.7943115234),
    ["Police Station 2"] = CFrame.new(731.24591064453, 38.845108032227, 1110.5113525391),
    ["1m"] = CFrame.new(351.762, 20, -1700.921), 
    ["Radio"] = CFrame.new(1034.241, 98.43, 1104.152), 
    ["Bridge1"] = CFrame.new(598, 60.669, 1032), 
    ["Bridge2"] = CFrame.new(666, 60.32, 1702), 
    ["Museum"] = CFrame.new(1075.503, 136.328, 1228.639), 
    ["Donut Shop"] = CFrame.new(87.516311645508, 19.215835571289, -1501.5932617188),
    ["Gas Station"] = CFrame.new(-1533.5056152344, 18.396123886108, 659.26196289063),
    ["Pet Store"] = CFrame.new(251.24588012695, 19.215835571289, -1609.0970458984),
    ["Gun Shop"] = CFrame.new(-20, 15.968, -1756), 
    ["Server"] = CFrame.new(64, 16.066, 1137), 
    ["Military Base"] = CFrame.new(813, 18.899, -315), 
    ["Ski"] = CFrame.new(17.537, 18.844, 2372.027), 
    ["Power Plant"] = CFrame.new(680.33, 37, 2358.23), 
    ["Jetpack"] = CFrame.new(1375.901, 173.199, 2585.686), 
    ["Airport"] = CFrame.new(-1592, 40.072, 2859), 
    ["Cove"] = CFrame.new(1875.797, 40, 1895.154)
}


for i, v in ipairs(locations_array) do
    lib:CreateButton(v, TeleportsTab, function()
        tp(locations[v].X, locations[v].Y, locations[v].Z)
    end)
end
 

TpPlayerTextBox = lib:CreateTextbox("Tp to Player", "Plr Name", true, TeleportsTab, function(value) 
    local Players_Tp = game:GetService("Players")
    local Tp_Plr = value
    local target = findObject(Players_Tp,Tp_Plr)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        tp(target.Character.HumanoidRootPart.Position.X,target.Character.HumanoidRootPart.Position.Y,target.Character.HumanoidRootPart.Position.Z)
    end
end)

-- Character Tab

NoclipBtn = lib:CreateToggle("Noclip", CharacterTab, function(enabled)
    if enabled == true then
        JayhubFunctions["Noclip"] = true
    elseif enabled == false then
        JayhubFunctions["Noclip"] = false
    end
end)

WalkSpeedSlider = lib:CreateSlider("WalkSpeed", 16, 100, CharacterTab, function(value) 
    JayhubFunctions["WalkSpeed_Amn"] = value
    JayhubFunctions["WalkSpeed"] = true
end)

JumpPowerSlider = lib:CreateSlider("JumpPower", 50, 500, CharacterTab, function(value) 
    JayhubFunctions["JumpPower_Amn"] = value
    JayhubFunctions["JumpPower"] = true
end)

UnlockFovBtn = lib:CreateButton("Unlock Fov", CharacterTab, function()
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = 1000000
    game:GetService("Players").LocalPlayer.CameraMinZoomDistance = 0
end)


-- End Character Tab

-- Rob Tab

--[[

function CheckPoliceRadius(amn)
    local PoliceTeamPlayers = game:GetService("Teams").Police:GetPlayers()
    local Bank = game:GetService("Workspace").Banks:GetChildren()[1].Layout:GetChildren()[1]
    for oc = 1, #PoliceTeamPlayers do
        local pc = PoliceTeamPlayers[oc]
        if pc.Character and pc.Character:FindFirstChild("HumanoidRootPart") and pc.Character:FindFirstChild("Humanoid") then
            local qc = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
            if
                (Bank.Door.Hinge.Position - qc).Magnitude < amn and pc.Character.Humanoid.Health > 0 and
                    workspace:FindPartOnRayWithWhitelist(
                        Ray.new(qc, Bank.TriggerDoor.Position - Bank.Door.Hinge.CFrame.lookVector * 3 - qc),
                        {Bank.Decoration, Bank.Parent.Parent.TopFloor}
                    ) == nil
             then
                return true
            end
        end
    end
    return false
end]]

local Robs_array = {
    [1] = "Power Plant",
    [2] = "Jewl",
    [3] = "Bank",
    [4] = "Museum",
    [5] = "Train",
    [6] = "SteamEngine"
}

local Robs = {
    PowerPlant = true,
    Jewl = true,
    Bank = true,
    Museum = true,
    Train = true,
    SteamEngine = true

}

local Robbed = {
    PowerPlant = false,
    Jewl = false,
    Bank = false,
    Museum = false,
    Train = false,
    SteamEngine = false

    
}

function lookAt(chr,target) --assume chr is a character and target is a brick to look towards
	if chr.PrimaryPart then --just make sure the character's HRP has loaded
		local chrPos=chr.PrimaryPart.Position --get the position of the HRP
		local tPos=target.Position --get the position of the target
		local newCF=CFrame.new(chrPos,tPos) --create our CFrame
		chr:SetPrimaryPartCFrame(newCF) --set the HRP's CFrame to our result, thus moving the character!
	end
end

local RobCheckEnabled = false

local MuseumRoof = nil
for i, v in pairs(game:GetService("Workspace").Museum.Roof.Hole:GetChildren()) do
    if v:findFirstChild("Texture") then
        MuseumRoof = v
    end
end

function RobCheck()
    if RobCheckEnabled == false then
        RobCheckEnabled = true
        while true do
            wait()
            if Robbed["Power Plant"] and (not game:GetService("Workspace").PowerPlant.Piston.Piston:FindFirstChildOfClass("TouchTransmitter") or JailbreakMarkers["Power Plant"].ImageLabel.ImageColor3 == Color3.new(1, 0, 0))then
                Robbed["Power Plant"] = false
            end
            if Robbed["Jewl"] and game:GetService("Workspace").Jewelrys:FindFirstChildWhichIsA("Model").Extra.Sign.Decal.Transparency == 0 then
                Robbed["Jewl"] = false
            end
            if Robbed["Bank"] and game:GetService("Workspace").Banks:FindFirstChildWhichIsA("Model").Extra.Sign.Decal.Transparency == 0 then
                Robbed["Bank"] = false
            end
            if not MuseumRoof then
                MuseumRoof = nil
                for i, v in pairs(game:GetService("Workspace").Museum.Roof.Hole:GetChildren()) do
                    if v:findFirstChild("Texture") then
                        MuseumRoof = v
                    end
                end
            end
            if Robbed["Museum"] and MueseumRoof and MuseumRoof.Transparency ~= 1 then
                Robbed["Museum"] = false
            end
            if Robbed["Train"] and not game:GetService("Workspace").Trains:FindFirstChild("BoxCar") then
                Robbed["Train"] = false
            end
            if Robbed["SteamEngine"] and not game:GetService("Workspace").Trains:FindFirstChild("SteamEngine") then
                Robbed["SteamEngine"] = false
            end
        end
    end
end

function TpSafeSpot()
    if JayhubFunctions["Rob"] then
        tp(91.584968566895, 106.79482269287, 1510.330078125)
    end
end

AutoRobLabel = lib:CreateLabel("Status: Offline", RobTab)

function RobSmallStoresLoop()
    while JayhubFunctions["Rob"] == true do
        local Condition = false
        local Count = 0

        for i=1,#specs do
            local s = specs[i]
            if s and s.Name and s.Name == "Rob" and game:GetService("Workspace").SmallStores:IsAncestorOf(s.Part) then
                spawn(function()
                    s:Callback(true)
                end)
            end
        end

        repeat
            wait(1)
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
end

function RobPowerPlant()
    if JayhubFunctions["Rob"] and Robs["Power Plant"] and not Robbed["Power Plant"] and (game:GetService("Workspace").PowerPlant.Piston.Piston:FindFirstChildOfClass("TouchTransmitter") or JailbreakMarkers["Power Plant"].ImageLabel.ImageColor3 ~= Color3.new(1, 0, 0)) then
        print("Power Plant")
        if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PowerPlantRobberyGui") then
            game:GetService("Players").LocalPlayer.PlayerGui.PowerPlantRobberyGui.Price.TextLabel.Text = "Uranium Value: $6000"
        end
        AutoRobLabel.Text = "Status: Teleporting to Power Plant..."
        JayhubFunctions["Noclip"] = false
        RemoveLasers()
        tp(locations["Power Plant"].X, locations["Power Plant"].Y, locations["Power Plant"].Z)
        tpplr(695.92980957031, 38.039028167725, 2360.0446777344)
        wait(2)
        if PuzzleTable.IsOpen then
            AutoRobLabel.Text = "Status: Solving First Puzzle..."
            for pc, qc in ipairs(PuzzleTable.Grid) do
                for rc, sc in ipairs(qc) do
                    qc[rc] = sc + 1
                end
            end

            local response
            response = http_request(
                {
                    Url = "https://numberlink-solver.sagesapphire.repl.co",
                    Method = "POST",
                    Body = game:GetService("HttpService"):JSONEncode({Matrix = PuzzleTable.Grid}),
                    Headers = {["Content-Type"] = "application/json"}
                }
                )

            if type(response) == "table" and response.Success then
                PuzzleTable.Grid = game:GetService("HttpService"):JSONDecode(response.Body).Solution
                for pc, qc in ipairs(PuzzleTable.Grid) do
                    for rc, sc in ipairs(qc) do
                        qc[rc] = sc - 1
                    end
                end
                PuzzleTable.OnConnection()
                wait(2)

                if not PuzzleTable.IsOpen then
                    AutoRobLabel.Text = "Status: Robbing Power Plant..."
                    tpplr(756.45843505859, 40.419082641602, 2324.6062011719)
                    tpplr(824.4736328125, 33.178951263428, 2294.107421875)
                    tpplr(812.71673583984, 13.6046285629272, 2152.0651855469)
                    tpplr(787.36383056641, 5.171820640564, 2154.5505371094)
                    wait(1)
                    AutoRobLabel.Text = "Status: Solving Second Puzzle..."
                    tpplr(787.33459472656, 5.6052656173706, 2144.587890625)
                    wait(2)
                    if PuzzleTable.IsOpen then
                        for sc, tc in ipairs(PuzzleTable.Grid) do
                            for uc, vc in ipairs(tc) do
                                tc[uc] = vc + 1
                            end
                        end
        
                        local response
                        response = http_request(
                            {
                                Url = "https://numberlink-solver.sagesapphire.repl.co",
                                Method = "POST",
                                Body = game:GetService("HttpService"):JSONEncode({Matrix = PuzzleTable.Grid}),
                                Headers = {["Content-Type"] = "application/json"}
                            }
                            )
        
                        if type(response) == "table" and response.Success then
                            PuzzleTable.Grid = game:GetService("HttpService"):JSONDecode(response.Body).Solution
                            for sc, tc in ipairs(PuzzleTable.Grid) do
                                for uc, vc in ipairs(tc) do
                                    tc[uc] = vc - 1
                                end
                            end
                            PuzzleTable.OnConnection()
                        end
                    end
                end
            end
        end
        if JayhubFunctions["Rob"] then
            local hrpcframe = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
            game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(hrpcframe.X, hrpcframe.Y+200, hrpcframe.Z))
            tpplr(691.41717529297, 38.039031982422, 2350.6018066406)
            AutoRobLabel.Text = "Status: Teleporting to Cave Base..."
            tp(1648.8262939453, 50.427543640137, -1741.0322265625)
        end
        AutoRobLabel.Text = "Status: Waiting for Cooldown..."
        wait(1)
        if game:GetService("Players").LocalPlayer.PlayerGui:findFirstChild("PowerPlantRobberyGui") then
            local MoneyValue = string.split(game:GetService("Players").LocalPlayer.PlayerGui.PowerPlantRobberyGui.Price.TextLabel.Text, "$")[2]
            repeat wait() MoneyValue = string.split(game:GetService("Players").LocalPlayer.PlayerGui.PowerPlantRobberyGui.Price.TextLabel.Text, "$")[2] until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PowerPlantRobberyGui") or not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PowerPlantRobberyGui").Enabled or MoneyValue == "6,000" or MoneyValue == "5,550" or MoneyValue == "5,500" or MoneyValue == "5,400" or MoneyValue == "0"
            if JayhubFunctions["Rob"] then
                AutoRobLabel.Text = "Status: Claiming Cash..."
                tpplr(1635.3220214844, 50.58438873291, -1804.4055175781)
            end
        end
        wait(1)
        AutoRobLabel.Text = "Status: Teleporting to Safe Spot..."
        JayhubFunctions["Noclip"] = false
        TpSafeSpot()
        Robbed["Power Plant"] = true
    end
end

function RobJewl()
    if JayhubFunctions["Rob"] and Robs["Jewl"] and not Robbed["Jewl"] and game:GetService("Workspace").Jewelrys:FindFirstChildWhichIsA("Model").Extra.Sign.Decal.Transparency ~= 0 then
        print("Jewl")
        JayhubFunctions["Noclip"] = true
        AutoRobLabel.Text = "Status: Teleporting to Jewl..."
        game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text = "$0 / $4,000"
        RemoveLasers()
        tp(91.887580871582, 18.583641052246, 1302.7012939453)
        AutoRobLabel.Text = "Status: Robbing Jewl..."
        wait(1)
        for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:IsA("Model") and v.name == "Cases" then
                for i2, v2 in pairs(v:GetChildren()) do
                    v2.CanCollide = false
                end
            end
        end
        for i, v in pairs(game:GetService("Workspace").Jewelrys:FindFirstChildWhichIsA("Model").Boxes:GetChildren()) do
            if v.Transparency ~= 1 then
                v.CanCollide = false
                tp((v.CFrame.X - 3), v.CFrame.Y, v.CFrame.Z, v.CFrame.X, v.CFrame.Y, v.CFrame.Z) 
                lookAt(game:GetService("Players").LocalPlayer.Character, v)
                local PunchAmount = 0
                while v.Transparency ~= 1 do 
                    wait(0.5)
                    if JayhubFunctions["Rob"] == false or game:GetService("Workspace").Jewelrys:FindFirstChildWhichIsA("Model").Extra.Sign.Decal.Transparency == 0 then break end
                    if PunchAmount > 20 then 
                        v.Transparency = 1
                    end
                    Functions['Punch']()
                    PunchAmount = PunchAmount + 1
                end
                wait()
                break
            end
        end


        for i=1,#specs do
            local s = specs[i]
            if s and s.Name and s.Name == "Grab Jewel" then
                s:Callback(true)
                local MoneyUiAmount = game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text
                local Earned = string.split(MoneyUiAmount, " / ")[1]
                local Max = string.split(MoneyUiAmount, " / ")[2]
                if Earned ~= nil and Earned == Max then break end
                if JayhubFunctions["Rob"] == false then break end
                wait()
            end
        end

        
        wait(0.1)
        for i, v in pairs(game:GetService("Workspace").Jewelrys:FindFirstChildWhichIsA("Model").Boxes:GetChildren()) do
            local MoneyUiAmount = game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text
            local Earned = string.split(string.split(MoneyUiAmount, " / ")[1], "$")[2]
            local Max = string.split(string.split(MoneyUiAmount, " / ")[2], "$")[2]
            if Earned ~= nil and Earned == Max then break end
            if JayhubFunctions["Rob"] == false or game:GetService("Workspace").Jewelrys:FindFirstChildWhichIsA("Model").Extra.Sign.Decal.Transparency == 0 then break end
            if v.Transparency ~= 1 then
                v.CanCollide = false
                tp((v.CFrame.X - 3), v.CFrame.Y, v.CFrame.Z, v.CFrame.X, v.CFrame.Y, v.CFrame.Z) 
                lookAt(game:GetService("Players").LocalPlayer.Character, v)
                local PunchAmount = 0
                while v.Transparency ~= 1 do 
                    wait(0.5)
                    if JayhubFunctions["Rob"] == false or game:GetService("Workspace").Jewelrys:FindFirstChildWhichIsA("Model").Extra.Sign.Decal.Transparency == 0 then break end
                    if PunchAmount > 20 then 
                        v.Transparency = 1
                    end
                    Functions['Punch']()
                    PunchAmount = PunchAmount + 1
                end
                wait()
            end
        end
        if JayhubFunctions["Rob"] then
            AutoRobLabel.Text = "Status: Teleporting to Crim Base..."
            wait()
            tpplr(-310.50311279297, 18.263668060303, 1601.7966308594)
            wait(1)
        end
        JayhubFunctions["Noclip"] = false
        AutoRobLabel.Text = "Status: Teleporting to Safe Spot..."
        TpSafeSpot()
        Robbed["Jewl"] = true
        JayhubFunctions["Noclip"] = false
    end
end

function RobBank()
    if JayhubFunctions["Rob"] and Robs["Bank"] and not Robbed["Bank"] and game:GetService("Workspace").Banks:FindFirstChildWhichIsA("Model").Extra.Sign.Decal.Transparency ~= 0 then
        print("Bank")
        JayhubFunctions["Noclip"] = true
        AutoRobLabel.Text = "Status: Teleporting to Bank..."
        game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text = "$0 / $4,000"
        RemoveLasers()
        tp(locations["Bank"].X, locations["Bank"].Y, locations["Bank"].Z)
        tpplr(23.835094451904, 18.814105987549, 841.74920654297)
        local Layout = game:GetService("Workspace").Banks:FindFirstChildWhichIsA("Model").Layout:FindFirstChildWhichIsA("Model")

        AutoRobLabel.Text = "Status: Teleporting to Safe..."
        if Layout.Name == "TheMint" then
            tpplr(64.226089477539, 0.26346385478973, 744.40417480469)
            tpplr(63.582851409912, 0.26346385478973, 731.9150390625)
        elseif Layout.Name == "Presidential" then
            tpplr(61.040740966797, -7.0358719825745, 933.28210449219)
            tpplr(33.638515472412, -7.3664565086365, 886.34051513672)
        elseif Layout.Name == "Underwater" then
            tpplr(149.40748596191, -7.7609286308289, 800.83197021484)
            tpplr(163.46586608887, -7.7109742164612, 800.56658935547)
        elseif Layout.Name == "Remastered" then
            tpplr(29.992742538452, 1.2637476921082, 815.74597167969)
            tpplr(17.731721878052, 1.3638143539429, 815.33404541016)
        elseif Layout.Name == "Deductions" then
            tpplr(32.645782470703, 1.2646967172623, 894.61016845703)
            tpplr(21.551696777344, 1.3645014762878, 893.91729736328)
        elseif Layout.Name == "Corridor" then
            tpplr(171.29415893555, -8.0368385314941, 861.34295654297)
            tpplr(189.37225341797, -7.9368543624878, 862.68933105469)
        elseif Layout.Name == "TheBlueRoom" then
            tpplr(-46.36462020874, -0.13841599225998, 853.03070068359)
            tpplr(-62.598155975342, -0.038214772939682, 853.16790771484)
        else
            print("Error: "..Layout.Name)
            AutoRobLabel.Text = "Status: Unsupported Bank"
        end
        AutoRobLabel.Text = "Status: Robbing Bank..."

        local CheckLoop = true
        local LoopRan = 0
        while CheckLoop do
            wait(1)
            --if not CheckPoliceRadius(19) then AutoRobLabel.Text = "Status: Escaping Police..." break end
            local MoneyUiAmount = game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text
            local Earned = string.split(string.split(MoneyUiAmount, " / ")[1], "$")[2]
            local Max = string.split(string.split(MoneyUiAmount, " / ")[2], "$")[2]
            if Earned ~= nil and Earned == Max then CheckLoop = false end
            if LoopRan > 350 or game:GetService("Workspace").Banks:FindFirstChildWhichIsA("Model").Extra.Sign.Decal.Transparency == 0 or JayhubFunctions["Rob"] == false then CheckLoop = false end
            LoopRan = LoopRan + 1
        end
        local hrpcframe = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
        game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(hrpcframe.X, hrpcframe.Y+100, hrpcframe.Z))
        AutoRobLabel.Text = "Status: Teleporting to Safe Spot..."
        TpSafeSpot()
        Robbed["Bank"] = true
        JayhubFunctions["Noclip"] = false
    end
end



function RobMuseum()
    if JayhubFunctions["Rob"] and Robs["Museum"] and not Robbed["Museum"] and MuseumRoof.Transparency == 1 and game:GetService("Workspace").Museum.Dino:findFirstChild("DinoBone") then
        print("Museum")
        JayhubFunctions["Noclip"] = true
        game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text = "$0 / $4,000"
        AutoRobLabel.Text = "Status: Teleporting to Museum..."
        RemoveLasers()
        tp(locations["Museum"].X, locations["Museum"].Y, locations["Museum"].Z)
        tpplr(1078.8481445313, 105.47541046143, 1196.1976318359)
        AutoRobLabel.Text = "Status: Robbing Museum..."
        for j=1, 10 do
            wait()
            local MoneyUiAmount = game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text
            local Earned = string.split(MoneyUiAmount, " / ")[1]
            local Max = string.split(MoneyUiAmount, " / ")[2]
            if Earned ~= nil and Earned == Max then break end
            if JayhubFunctions["Rob"] == false then break end
            for i=1,#specs do
                local s = specs[i]
                if s and s.Name and s.Name:sub(1,5)=="Grab " and game:GetService("Workspace").Museum:IsAncestorOf(s.Part) then
                    s:Callback(true)
                    local MoneyUiAmount = game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text
                    local Earned = string.split(MoneyUiAmount, " / ")[1]
                    local Max = string.split(MoneyUiAmount, " / ")[2]
                    if Earned ~= nil and Earned == Max then break end
                    if JayhubFunctions["Rob"] == false then break end
                    wait()
                end
            end
        end

        wait(1)
        if JayhubFunctions["Rob"] then
            local hrpcframe = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
            game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(hrpcframe.X, hrpcframe.Y+60, hrpcframe.Z))
            AutoRobLabel.Text = "Status: Teleporting to Cave Base..."
            tp(1648.8262939453, 50.427543640137, -1741.0322265625)
        end
        AutoRobLabel.Text = "Status: Waiting for Cooldown..."
        wait(4)
        if JayhubFunctions["Rob"] then
            AutoRobLabel.Text = "Status: Claiming Cash..."
            tpplr(1635.3220214844, 50.58438873291, -1804.4055175781)
        end
        wait(1)
        AutoRobLabel.Text = "Status: Teleporting to Safe Spot..."
        TpSafeSpot()
        Robbed["Museum"] = true
        JayhubFunctions["Noclip"] = false

    end
end

function RobTrain()
    if JayhubFunctions["Rob"] and Robs["Train"] and not Robbed["Train"] and game:GetService("Workspace").Trains:FindFirstChild("BoxCar") then
        print("Train")
        AutoRobLabel.Text = "Status: Robbing Train..."
        wait(3)
        Functions['ExitVehicle']()
        JayhubFunctions["Noclip"] = true
        game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text = "$0 / $4,000"

        local current_boxcar
        for _,child in ipairs(game:GetService("Workspace").Trains:GetChildren()) do
            if child.Name=="BoxCar" and child.Model.Rob:FindFirstChild("Gold") then
                current_boxcar = child
                break
            end
        end

        local gold = current_boxcar.Model.Rob.Gold
        local v30=Vector3.new()

        local trainDoorSpec,trainVaultSpec
        for i=1,#specs do
            local s = specs[i]
            if not s then
            elseif trainDoorSpec==nil and s.Name=="Open Door" and tostring(s.Part)=="RoofDoorClosed" and current_boxcar:IsAncestorOf(s.Part) then
                trainDoorSpec = s
            elseif trainVaultSpec==nil and s.Name=="Breach Vault" and current_boxcar:IsAncestorOf(s.Part) then
                trainVaultSpec = s
            end
        end
        local stepconn = game:GetService("RunService").Stepped:Connect(function()
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(gold.CFrame.X, gold.CFrame.Y+2, gold.CFrame.Z)+(gold.CFrame.lookVector*3)
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.RotVelocity=v30,v30
        end)

        if trainDoorSpec then
            trainDoorSpec:Callback(true)
        end
        if trainVaultSpec then
            trainVaultSpec:Callback(true)
        end

        local CheckLoop = true
        local LoopRan = 0
        while CheckLoop do
            wait(1)
            local MoneyUiAmount = game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text
            local Earned = string.split(MoneyUiAmount, " / ")[1]
            local Max = string.split(MoneyUiAmount, " / ")[2]
            if Earned ~= nil and Earned == Max then CheckLoop = false end
            if LoopRan > 10 and Earned == "$0" then break end
            if LoopRan > 250 or not game:GetService("Workspace").Trains:FindFirstChild("BoxCar") or JayhubFunctions["Rob"] == false then CheckLoop = false end
            LoopRan = LoopRan + 1
        end
        
        stepconn:Disconnect()
        wait(1)
        AutoRobLabel.Text = "Status: Teleporting to Safe Spot..."
        TpSafeSpot()
        Robbed["Train"] = true
        JayhubFunctions["Noclip"] = false

    end
end

function RobSteamEngine()
    if JayhubFunctions["Rob"] and Robs["SteamEngine"] and not Robbed["SteamEngine"] and game:GetService("Workspace").Trains:FindFirstChild("SteamEngine") then
        print("SteamEngine")
        AutoRobLabel.Text = "Status: Robbing Steam Engine..."
        wait(3)
        Functions['ExitVehicle']()
        game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text = "$0 / $4,000"

        local grabNum=0
        for j=1,2 do
            for i=1,#specs do
                local s = specs[i]
                if s and s.Enabled and s.Name and s.Name:sub(1,5)=="Grab " and game:GetService("Workspace").Trains:IsAncestorOf(s.Part) then
                    if j==2 or s.Name:sub(7)=="briefcase" then
                        wait(1.35)
                        local MoneyUiAmount = game:GetService("Players").LocalPlayer.PlayerGui.RobberyMoneyGui.Container.Bottom.Progress.Amount.Text
                        local Earned = string.split(MoneyUiAmount, " / ")[1]
                        local Max = string.split(MoneyUiAmount, " / ")[2]
                        if Earned ~= nil and Earned == Max then break end
                        if not game:GetService("Workspace").Trains:FindFirstChild("SteamEngine") or JayhubFunctions["Rob"] == false then break end
                        s:Callback(true)
                        grabNum=grabNum+1
                        if JayhubFunctions["Rob"] == false or grabNum>9 then
                            break
                        end
                    end
                end
            end
            if JayhubFunctions["Rob"] == false or grabNum>9 then
                break
            end
        end
        if JayhubFunctions["Rob"] then
            AutoRobLabel.Text = "Status: Teleporting to Cave Base..."
            tp(1648.8262939453, 50.427543640137, -1741.0322265625)
        end
        AutoRobLabel.Text = "Status: Waiting for Cooldown..."
        wait(4)
        if JayhubFunctions["Rob"] then
            AutoRobLabel.Text = "Status: Claiming Cash..."
            tpplr(1635.3220214844, 50.58438873291, -1804.4055175781)
        end
        wait(1)
        AutoRobLabel.Text = "Status: Teleporting to Safe Spot..."
        TpSafeSpot()
        Robbed["SteamEngine"] = true
    end
end

function AutoRobFunction()
    if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.CellTime.Visible == true then
        AutoRobLabel.Text = "Status: Waiting for Release..."
    end
    repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.MainGui.CellTime.Visible == false
    AutoRobLabel.Text = "Status: Starting..."
    
    local MuseumRoof = nil
    for i, v in pairs(game:GetService("Workspace").Museum.Roof.Hole:GetChildren()) do
        if v:findFirstChild("Texture") then
            MuseumRoof = v
        end
    end

    for i, v in pairs(game:GetService("Workspace").Buildings:GetChildren()) do
        if v:IsA("MeshPart") then
            v.CanCollide = false
        end
    end

    --[[local touch = nil
    for i, v in pairs(game:GetService("Workspace").Tele:GetChildren()) do
        if v:IsA("Part") then
            touch = v
        end
    end

    local touchcframe = touch.CFrame

    Functions["ExitVehicle"]()
    touch.Transparency = 1 
    touch.CanCollide = false
    touch.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
    wait(1)
    touch.CFrame = touchcframe
    touch.Transparency = 0
    touch.CanCollide = true
    wait(1)]]
    if JayhubFunctions["StayInCar"] == true then
        lib:SetToggle(StayInCarToggle)
        JayhubFunctions["StayInCar"] = false
    end
    tp(91.584968566895, 106.79482269287, 1510.330078125)
    game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(91.584968566895, 106.79482269287, 1510.330078125))
    spawn(RobCheck)
    spawn(RobSmallStoresLoop)
    repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.MainGui.CellTime.Visible == false
    while JayhubFunctions["Rob"] == true do
        wait()

        pcall(RobPowerPlant)
        pcall(RobJewl)
        pcall(RobBank)
        pcall(RobMuseum)
        pcall(RobTrain)
        pcall(RobSteamEngine)
     
        AutoRobLabel.Text = "Status: Waiting..."            
    end
    hover(false)
    AutoRobLabel.Text = "Status: Offline"
    
end



AutoRobToggle = lib:CreateToggle("Auto Rob", RobTab, function(enabled)
    if enabled == true then
        JayhubFunctions["Rob"] = true
        spawn(AutoRobFunction)
    elseif enabled == false then
        JayhubFunctions["Rob"] = false
    end
end)



RobSmallStoreBtn = lib:CreateButton("Rob Small Stores", RobTab, function()
    for i=1,#specs do
        local s = specs[i]
        if s and s.Name and s.Name == "Rob" and game:GetService("Workspace").SmallStores:IsAncestorOf(s.Part) then
            spawn(function()
                s:Callback(true)
            end)
        end
    end
end)

ToggleRobsLabel = lib:CreateLabel("Toggle Robs", RobTab)

for i, v in ipairs(Robs_array) do
    local Toggle_1 = lib:CreateToggle(v, RobTab, function(enabled)
        if enabled == true then
            Robs[v] = true
        elseif enabled == false then
            Robs[v] = false
        end
    end)
    lib:SetToggle(Toggle_1)
end



-- End Rob Tab

-- Car Tab



GetCamaroBtn = lib:CreateButton("Get Camaro", CarTab, function()
    local car = findnearestcar()
    for i=1, 30 do
        wait()
        if game:GetService("Players").LocalPlayer.Character.Humanoid.Sit == true then break end
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = car.Seat.CFrame
        Functions["EnterVehicle"](car.Seat)
    end
end)

CarNoclipToggle = lib:CreateToggle("Car Noclip", CarTab, function(enabled)
    if enabled == true then
        local car
        for i,v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
            if v:findFirstChild("Seat") then
                if v.Seat:findFirstChild("PlayerName") then
                    if v.Seat.PlayerName.Value == game:GetService("Players").LocalPlayer.Name then
                        car = v
                    end
                end
            end
        end

        if car:FindFirstChild("Model") and car.Model:FindFirstChild("Body") then
            car.Model.Body.CanCollide = false
        end
        if car:FindFirstChild("Step") then
            car.Step.CanCollide = false
        end
        if not JayhubFunctions["Noclip"] then
            JayhubFunctions["Noclip"] = true
            spawn(function() lib:SetToggle(NoclipBtn) end)
        end
    elseif enabled == false then
        local car
        for i,v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
            if v:findFirstChild("Seat") then
                if v.Seat:findFirstChild("PlayerName") then
                    if v.Seat.PlayerName.Value == game:GetService("Players").LocalPlayer.Name then
                        car = v
                    end
                end
            end
        end

        if car:FindFirstChild("Model") and car.Model:FindFirstChild("Body") then
            car.Model.Body.CanCollide = true
        end
        if car:FindFirstChild("Step") then
            car.Step.CanCollide = true
        end
        if JayhubFunctions["Noclip"] then
            JayhubFunctions["Noclip"] = false
            spawn(function() lib:SetToggle(NoclipBtn) end)
        end
    end
end)

spawn(function()
    while wait() do
        if JayhubFunctions["infnitro"] then
            if NitroTable then
                NitroTable.Nitro = math.huge
            end
        end
    end
end)

InfNitroToggle = lib:CreateToggle("Infinite Nitro", CarTab, function(enabled)
    if enabled == true then
        JayhubFunctions["infnitro"] = true
    elseif enabled == false then
        JayhubFunctions["infnitro"] = false
    end
end)

spawn(function()
    while wait() do
        if JayhubFunctions["NoCarFlip"] then
            Functions['Flip']()
        end
    end
end)



NoCarFlipToggle = lib:CreateToggle("No Car Flip", CarTab, function(enabled)
    if enabled == true then
        JayhubFunctions["NoCarFlip"] = true
    elseif enabled == false then
        JayhubFunctions["NoCarFlip"] = false
    end
end)

spawn(function()
    while wait() do
        if JayhubFunctions["NoTirePop"] then
            if Functions['GetCarTable']() then
                Functions['GetCarTable']().TireHealth = math.huge
            end
        end
    end
end)

NoTirePopToggle = lib:CreateToggle("No Tire Pop", CarTab, function(enabled)
    if enabled == true then
        JayhubFunctions["NoTirePop"] = true
    elseif enabled == false then
        JayhubFunctions["NoTirePop"] = false
    end
end)

local Colors = {'Red', 'Yellow', 'White', 'Blue', 'Green'}
spawn(function()
    while wait(0.5) do
        if JayhubFunctions["RainbowCar"] then
            setupvalue(Functions['editVehicle'], 1, Remote)
            for i, v in pairs(Colors) do
                Functions['editVehicle']({Name = v}, {Name = 'BodyColor'})
                wait(0.5)
            end
        end
    end
end)

RainbowCarToggle = lib:CreateToggle("Rainbow Car", CarTab, function(enabled)
    if enabled == true then
        JayhubFunctions["RainbowCar"] = true
    elseif enabled == false then
        JayhubFunctions["RainbowCar"] = false
    end
end)

CarSpeedSlider = lib:CreateSlider('Car Speed', 0, 150, CarTab, function(value)
    if Functions['GetCarTable']() then
        Functions['GetCarTable']().GarageEngineSpeed = value
        NewCarTable["GarageEngineSpeed"] = value
    end
end)


CarHeightSlider = lib:CreateSlider('Car Height', 0, 250, CarTab,function(value)
    if Functions['GetCarTable']() then
        Functions['GetCarTable']().Height = value
        NewCarTable["Height"] = value
    end
end)

CarTurnSpeedSlider = lib:CreateSlider('Turn Speed', 0, 20, CarTab, function(value)
    if Functions['GetCarTable']() then
        Functions['GetCarTable']().TurnSpeed = value
        NewCarTable["TurnSpeed"] = value
    end
end)

CarSuspensionSlider = lib:CreateSlider('Suspension', 0, 100, CarTab, function(value)
    if Functions['GetCarTable']() then
        Functions['GetCarTable']().Suspension = value
        NewCarTable["Suspension"] = value
    end
end)

lib:SetSlider(CarSuspensionSlider, 4)

ResetCarBtn = lib:CreateButton("Reset Car", CarTab, function()
    Functions['GetCarTable']().GarageEngineSpeed = OldCarTable["GarageEngineSpeed"]
    Functions['GetCarTable']().Height = OldCarTable["Height"]
    Functions['GetCarTable']().TurnSpeed = OldCarTable["TurnSpeed"]
    Functions['GetCarTable']().Suspension = OldCarTable["Suspension"]
    NewCarTable["GarageEngineSpeed"] = OldCarTable["GarageEngineSpeed"]
    NewCarTable["Height"] = OldCarTable["Height"]
    NewCarTable["TurnSpeed"] = OldCarTable["TurnSpeed"]
    NewCarTable["Suspension"] = OldCarTable["Suspension"]
    lib:SetSlider(CarSpeedSlider, OldCarTable["GarageEngineSpeed"])
    lib:SetSlider(CarHeightSlider, OldCarTable["Height"])
    lib:SetSlider(CarTurnSpeedSlider, OldCarTable["TurnSpeed"])
    lib:SetSlider(CarSuspensionSlider, OldCarTable["Suspension"])
end)





-- End Car Tab

-- Gun Tab

lib:CreateButton('Grab Guns', GunTab, function()
    --[[for i, v in pairs(ReplicatedStorage.Game.Item:GetChildren()) do
        print(v.Name)
        Functions['GrabGun'](v.Name)
    end]]
    for i, v in pairs(game:GetService("Workspace").Givers:GetChildren()) do
        if v.Name ~= "Station" and v.Name ~= "Station2" then
            if v:FindFirstChild('ClickDetector') then
                fireclickdetector(v:FindFirstChild('ClickDetector'))
            end   
        end
    end
end)

local OldMags = {}

InfAmmoToggle = lib:CreateToggle('Infinite Ammo', GunTab, function(value)
    for i, v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
        local config = require(v)
        if value then
            OldMags[v] = config.MagSize
        end
        config.MagSize = value and 9e9 or OldMags[v]
    end
end)

AutoFireToggle = lib:CreateToggle('Auto Fire', GunTab, function(value)
    for i, v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
        local config = require(v)
        config.FireAuto = value
    end
end)

ReloadTimeSlider = lib:CreateSlider('Reload Time', 0, 7, GunTab,function(value)
    for i, v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
        local config = require(v)
        config.ReloadTime = value
    end
end)

lib:SetSlider(ReloadTimeSlider, 1)


FireFrequencySlider = lib:CreateSlider('Fire Frequency', 0, 10000, GunTab, function(value)
    for i, v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
        local config = require(v)
        config.FireFreq = value
    end
end)

lib:SetSlider(FireFrequencySlider, 15)



-- End Gun Tab

-- Misc Tab

--[[GetKeycardBtn = lib:CreateButton("Get Keycard", MiscTab, function()
    local Police = game:GetService("Teams").Police:GetPlayers()
    for i=1, #Police do
        v = Police[i]
        if not v.Character:FindFirstChild('InVehicle') then
            local PlrLocation = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
            local TargetLocation = v.Character.HumanoidRootPart.CFrame
            tp(TargetLocation.X, TargetLocation.Y, TargetLocation.Z)
            for i=1, 5 do
                Functions["PickPocket"](v)
            end
            wait(1)
            tp(PlrLocation.X, PlrLocation.Y, PlrLocation.Z)
            break
        end
    end
end)]]

NoWaitBtn = lib:CreateButton("No Wait", MiscTab, function()
    for i=1,#specs do
        local s = specs[i]
        if s and s.Name and s.Duration and s.Timed then
            s.Timed = false
            s.Duration = 0
        end
    end
end)

MakeGameBetterBtn = lib:CreateButton("Make Game Better", MiscTab, function()
    local LetsGo = Instance.new("Sound", game:GetService("Workspace"))
    LetsGo.SoundId = "rbxassetid://6741738180"
    LetsGo.Name = "LetsGo"
    if not LetsGo.IsLoaded then
        Notification("Loading...", 1)
        LetsGo.Loaded:wait()
    end
    Notification("Try using a prompt", 2)
    for i=1,#specs do
        local s = specs[i]
        if s and s.Name and s.Callback then
            if s.Duration then s.Duration = 0 end 
            if s.Timed then s.Timed = false end
            s.Duration = 0
            s.Name = "DaBaby"
            s.Callback = function()
                local NotificationService = require(game:GetService("ReplicatedStorage").Game.Notification)
                function Notification(message, duration)
                    NotificationService.new({
                        Text = message,
                        Duration = duration
                    })
                end
                Notification("LESS GOOOOOOOO", 5)
                wait(0.4)
                if game:GetService("Workspace"):FindFirstChild("LetsGo") then
                    game:GetService("Workspace").LetsGo:Play()
                end
                wait(3.5)
                
            end
        end
    end

end)


-- End Misc Tab

