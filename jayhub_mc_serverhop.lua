wait(6)

game.Workspace:WaitForChild(game.Players.LocalPlayer.Name)
repeat
    wait()
until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpawnGUI") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Chat")

wait(2)

if game:GetService("Stats"):FindFirstChild("PerformanceStats") then
    game:GetService("Stats").PerformanceStats:Destroy()
end


local function getexploit()
    local exploit =
        (syn and not is_sirhurt_closure and not pebc_execute and "Synapse") or
        (secure_load and "Sentinel") or
        (is_sirhurt_closure and "Sirhurt") or
        (pebc_execute and "ProtoSmasher") or
        (KRNL_LOADED and "Krnl") or
        (WrapGlobal and "WeAreDevs") or
        (isvm and "Proxo") or
        (shadow_env and "Shadow") or
        (jit and "EasyExploits") or
        (getscriptenvs and "Calamari") or
        (unit and not syn and "Unit") or
        (OXYGEN_LOADED and "Oxygen") or
        (IsElectron and "Electron") or
        ("Unknown")
  
    return exploit
end
  

local Exploit_name = getexploit()

--local TouchInterestCFrame = game:GetService("Workspace").CriminalBase1.TouchEnd.CFrame


game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("SetTeam", "Prisoners")
game:GetService("StarterPlayer").StarterPlayerScripts.UI["UI_Mainmenu"]:Destroy()
game.workspace.CurrentCamera.CameraType = "Custom"
game.workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.PlayerGui.SpawnGUI:Destroy()
game.Lighting:WaitForChild("Blur").Size = 0
game:GetService("Players").LocalPlayer.PlayerGui.Minimap.Enabled = true
game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Enabled = true
game:GetService("Players").LocalPlayer.PlayerGui.MessageGUI.Enabled = true
game:GetService("Players").LocalPlayer.PlayerGui.MarkerGUI.Enabled = true
game.workspace.Camera:Destroy()
Camera = Instance.new("Camera")
Camera.Parent = workspace
Camera.CameraType = "Custom"
Camera.CameraSubject = game.Players.LocalPlayer.Character

getgenv().queue_on_teleport = queue_on_teleport or onteleport or syn.queue_on_teleport
repeat until queue_on_teleport



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
    do_queue_on_teleport = do_queue_on_teleport or true
    if do_queue_on_teleport == true then
        if Exploit_name ~= "Electron" then
            queue_on_teleport("loadstring(game:HttpGet('https://jack1214060.xyz/jayhub/madcity/serverhop',true))()")
        elseif Exploit_name == "Electron" then
            queue_on_teleport[[loadstring(game:HttpGet('https://jack1214060.xyz/jayhub/madcity/serverhop',true))()]]
        end
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





local function Bet(Val1, Val2)
    local Resp = (Vector3.new(Val1.X) - Vector3.new(Val2.X)).magnitude + (Vector3.new(Val1.Y) - Vector3.new(Val2.Y)).magnitude + (Vector3.new(Val1.Z) - Vector3.new(Val2.Z)).magnitude
    return Resp / 205
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



wait(.25)
--[[if game:GetService("Players").LocalPlayer.PlayerGui.MainGUI:findFirstChild("TeleportEffect") then
    game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.TeleportEffect:Destroy()
end
game:GetService("Workspace").Pyramid.Tele.Core2.CanCollide = false
game:GetService("Workspace").Pyramid.Tele.Core2.Transparency = 1
game:GetService("Workspace").Pyramid.Tele.Core2.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
wait()
game:GetService("Workspace").Pyramid.Tele.Core2.CFrame = CFrame.new(math.huge, math.huge, math.huge)
game:GetService("Workspace").Pyramid.Tele.Core2.Transparency = 0
game:GetService("Workspace").Pyramid.Tele.Core2.CanCollide = true
wait(1.5)]]
game:GetService("Players").LocalPlayer.Character.NameTag:Destroy()
game:GetService("Players").LocalPlayer.Character.RightFoot:Destroy()
game:GetService("Players").LocalPlayer.Character.RightUpperLeg:Destroy()
game:GetService("Players").LocalPlayer.Character.RightLowerLeg:Destroy()
game:GetService("Players").LocalPlayer.Character.LeftFoot:Destroy()
game:GetService("Players").LocalPlayer.Character.LeftUpperLeg:Destroy()
game:GetService("Players").LocalPlayer.Character.LeftLowerLeg:Destroy()
game:GetService("RunService").RenderStepped:Connect(function()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
        if v:IsA("Accessory") or v:IsA("Tool") then v:Destroy()
        end
    end
end)
pcall(function()
    for i, v in pairs(game:GetService("Workspace").SmartRender.Default.Chunk4.Builds["Desert Props"]:GetDescendants()) do
        if v.name == "MeshPart" and v.Parent.name == "Model" then
            v:Destroy()
        end
    end
end)

pcall(function()
    wait(1)
    local Human = game.Players.LocalPlayer.Character.HumanoidRootPart
    Human.Parent = nil
    wait(0.1)
    Human.Parent = game.Players.LocalPlayer.Character
    wait(0.1)
    local miniHeistNames = {
        "CashRegister",
        "Cash",
        "DiamondBox",
        "Safe",
        "TV",
        "Phone",
        "Laptop",
        "Luggage",
        "ATM",
        "TipJar"
    }

    local patchedHeistNames = {
        "TreasurePyramid",
        "PlaneCrate"
    }
    --print("Small")
    for i,v in pairs(game.workspace.ObjectSelection:GetChildren()) do
        for ii,vv in pairs(miniHeistNames) do
            if v.Name == vv then
                if v:FindFirstChild("SmashCash") then
                    v.SmashCash.SmashCash.Event:FireServer()
                wait(0.1)
                elseif v:FindFirstChild("Cash") then
                    v.Cash.Cash.Event:FireServer()
                wait(0.1)
                elseif v:FindFirstChild("StealTV") then
                    v.StealTV.StealTV.Event:FireServer()
                wait(0.1)
                elseif v:FindFirstChild("Steal") then
                    v.Steal.Steal.Event:FireServer()
                wait(0.1)
                elseif v:FindFirstChild("ATM") then
                    v.ATM.ATM.Event:FireServer()
                end
            end
        end
    end
end)


--[[wait(9)

if game.ReplicatedStorage.HeistStatus.Pyramid.Locked.Value == false or game.ReplicatedStorage.HeistStatus.Pyramid.Robbing.Value == true then
    print("Pmid")
    wait()

end
wait(3)
pcall(function()
    print("Gold Train")
    for i = 1, 15 do
        game.ReplicatedStorage.RemoteEvent:FireServer("GoldTrain")
    end
end)

wait(3)
if game.ReplicatedStorage.HeistStatus.Casino.Locked.Value == false or game.ReplicatedStorage.HeistStatus.Casino.Robbing.Value == true then
    pcall(function() 
        game:GetService("Workspace").ObjectSelection.HackComputer.NoHack.HackComputer.Event:FireServer()
        wait(0.3)
        game:GetService("Workspace").ObjectSelection.Lever1.Lever.Lever.Event:FireServer()
        wait(0.25)
        game:GetService("Workspace").ObjectSelection.Lever2.Lever.Lever.Event:FireServer()
        wait(0.25)
        game:GetService("Workspace").ObjectSelection.Lever3.Lever.Lever.Event:FireServer()
        wait(0.25)
        game:GetService("Workspace").ObjectSelection.Lever4.Lever.Lever.Event:FireServer()
        wait(0.25)
    end)
end

wait(3)
if game.ReplicatedStorage.HeistStatus.Club.Locked.Value == false or game.ReplicatedStorage.HeistStatus.Club.Robbing.Value == true then
    pcall(function()
        print("Club")
        game:GetService("Workspace").Club.TouchStart.CanCollide = false
        game:GetService("Workspace").Club.TouchStart.Transparency = 1
        game:GetService("Workspace").Club.TouchStart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
        wait(1)
        game:GetService("Workspace").ObjectSelection.HackKeyPad.HackKeyPad.HackKeyPad.Event:FireServer()
    end)
end

    
pcall(function()
    for i,v in pairs(game.Workspace.ObjectSelection:GetChildren()) do
        if v.Name == "TreasurePyramid" and v:FindFirstChild("TreasurePyramid") then
            v.TreasurePyramid.TreasurePyramid.Event:FireServer()
            wait(0.5)
        end
    end
end)

wait(3)

print("Jewl")
game:GetService("Workspace").Heists.JewelryStore.EssentialParts.JewelryVent.Vent.Texture:Destroy()
game:GetService("Workspace").Heists.JewelryStore.EssentialParts.JewelryVent.Vent.CanCollide = false
game:GetService("Workspace").Heists.JewelryStore.EssentialParts.JewelryVent.Vent.Transparency = 1
game:GetService("Workspace").Heists.JewelryStore.EssentialParts.JewelryVent.Vent.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
wait(0.25)
pcall(function()
    for i,b in pairs(game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes:GetChildren()) do
        if b.Name == "JewelBox" then
            wait()
            for i = 1, 3 do
                game.workspace.Heists.JewelryStore.EssentialParts.JewelryBoxes.JewelryManager.Event:FireServer(b)
            end
            wait()
        end
    end
end)

wait(5)
pcall(function()
    for i,v in pairs(game.Workspace.ObjectSelection:GetChildren()) do
        if v.Name == "Trayy" then
            v.Trayy.Trayy.Event:FireServer()
            wait(0.35)
        end
    end
end)

wait(6)
pcall(function()
    for i,v in pairs(game.Workspace.ObjectSelection:GetChildren()) do
        if v.Name == "ClubDiamond" then
            v.ClubDiamond.ClubDiamond.Event:FireServer()
            wait(0.25)
        end
    end
end)
pcall(function()
    for i,v in pairs(game.Workspace.ObjectSelection:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Parent:IsA("Script") and v.Parent.Parent:IsA("Part") and v.Parent.Parent.Parent:IsA("Model") and v.Parent.Parent.Name == "Files" then
            wait(1)
            v:FireServer()
        end
    end
end)

wait(20)
game:GetService("Workspace").CriminalBase1.TouchEnd.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(2)
game:GetService("Workspace").CriminalBase1.TouchEnd.CFrame = TouchInterestCFrame
wait(1)
game:GetService("Workspace").CriminalBase1.TouchEnd.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(2)
game:GetService("Workspace").CriminalBase1.TouchEnd.CFrame = TouchInterestCFrame]]

wait(1)
game.Players.LocalPlayer.Character:BreakJoints()
wait(0.1)
Teleport()
wait(20)
print("Teleport Failed")
wait(1)
game:GetService("TeleportService"):Teleport(1224212277, LocalPlayer)
