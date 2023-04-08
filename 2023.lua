-- Whitelist
local Whitelist = {
	3340505623,
	3114123821,
	1623982975
}

if not table.find(Whitelist, game.Players.LocalPlayer.UserId) then
    game.Players.LocalPlayer:Kick("Your aren't whitelisted.")
else
	game.StarterGui:SetCore("SendNotification", {
    	Title = "ZackHub Login";
        Text = "Whitelisted.";
        Icon = "rbxassetid://8621787398";
        Duration = "1";
    })
end

-- Message
game.StarterGui:SetCore("SendNotification", {
	Title = "Decrypted Hub";
		Text = "Loaded!";
		Icon = "rbxassetid://8621787398";
		Duration = "1";
})

-- [[ Toggles ]] --
local Game = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
getgenv().autoPunch = false;
getgenv().autoReset = false;
getgenv().orbFarm = false;
getgenv().resettime = 16;

-- // Library Setup \\ --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Decrypted Hub - "..Game, "Ocean")
-- Tabs
local autofarm = Window:NewTab("Autofarm")
local credit = Window:NewTab("Credits")
-- Sections
local Tank = autofarm:NewSection("Tank Farming")
local Credits = credit:NewSection("Credits to:")

-- // Credits Section \\ --
Credits:NewLabel("Owner : Decrypted")
Credits:NewLabel("Helper : Dxveloper_Zack")
Credits:NewLabel("UI Library : Kavo Library")

-- // Autofarm Section \\ --
Tank:NewKeybind("Hide Gui", "Set Keybind to hide Decrypted Hub.", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)

Tank:NewButton("Safezone", "Teleports to safezone for farming.", function()
	game.Players.LocalPlayer.character.HumanoidRootPart.CFrame = CFrame.new(-2503.50146, 97.0075302, -2057.61035) + Vector3.new(0,0,0)
end)

Tank:NewToggle("Autopunch", "Does Heavy punches.", function(state)
	if state then
		getgenv().autoPunch = true;
		punch()
	else
		getgenv().autoPunch = false;
		punch()
	end
end)

Tank:NewToggle("Autoreset", "Resets after given time.", function(state)
	if state then
		getgenv().autoReset = true;
		reset()
	else
		getgenv().autoReset = false;
		reset()
	end
end)

Tank:NewSlider("Reset Time", "Customize when your character gets reset.", 100, 0, function(s)
	getgenv().resettime = s
end)


Tank:NewToggle("Orb Farm", "Farms orbs.", function(state)
	if state then
		getgenv().orbFarm = true;
		orbfarm()
	else
		getgenv().orbFarm = false;
		orbfarm()
	end
end)

-- [[ FUNCTIONS ]] --
function punch()
	spawn(function()
		while autoPunch == true do
			local Target = game.ClientStorage.Events.Punch;
			Target:FireServer(0.4, 0.1, 1);
			wait()
		end
	end)
end

function reset()
	spawn(function()
		while autoReset == true do
			wait(getgenv().resettime)
			game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 0
		end
	end)
end

function orbfarm()
	spawn(function()
		local playerHead = game.Players.LocalPlayer.Character.Head
		while orbFarm == true do
			for i, v in pairs(game:GetService("Workspace").ExperienceOrbs:GetDescendants()) do
				if v.Name == "TouchInterest" and v.Parent then
					firetouchinterest(playerHead, v.Parent, 0)
					firetouchinterest(playerHead, v.Parent, 1)
				end
			end
			wait()
		end
	end)
end