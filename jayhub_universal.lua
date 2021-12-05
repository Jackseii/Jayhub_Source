

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
lib:CreateEsp()


game:GetService("Players").LocalPlayer.Idled:connect(function()
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
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
    lib:DestroyGui()
end

KillGuiBtn = lib:CreateButton("Kill Gui", HomeTab, function()
    JayHub_RemoveGui()
end)



-- End Home Tab


