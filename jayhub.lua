if game.CoreGui:FindFirstChild("JayHub") then
    JayHub_RemoveGui()
end


repeat wait() until game.Players.LocalPlayer
wait()
repeat wait() until game.Players.LocalPlayer.Character


getgenv().http_request = http_request or request or (http and http.request) or syn.request 
repeat until http_request


function SendRequest(url)
    local response = http_request(
    {
        Url = url,  -- This website helps debug HTTP requests
        Method = "GET"
    }
    )
    return response
end



local GameTable = {
    ["1224212277"] = "mc",
    ["606849621"] = "jailbreak",
    ["142823291"] = "mm2",
    ["537413528"] = "buildaboat",
    ["4787629450"] = "boogabooga",
    ["1262182609"] = "boogabooga",
    ["5901346231"] = "boogabooga",
    ["3527629287"] = "bigpaintball"
}

local GameFound = false
local ScriptData = nil



local success, response = pcall(function()
    for key, value in pairs(GameTable) do
        if game.PlaceId == tonumber(key) then
            GameFound = true
            ScriptData = SendRequest("https://raw.githubusercontent.com/Jack1214060/Jayhub_Source/Master/jayhub_"..value..".lua")
        end
    end
    if not GameFound then
        ScriptData = SendRequest("https://raw.githubusercontent.com/Jack1214060/Jayhub_Source/Master/jayhub_universal.lua")
    end
    if ScriptData and ScriptData.Body then
        loadstring(ScriptData.Body)()
    else
        game.Players.LocalPlayer:Kick("\nSomething isnt right")
        wait(2)
        while true do end
    end

end)


