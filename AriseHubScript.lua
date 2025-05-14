--[[ 
	Arise Hub Script
	Autorizado pelos criadores do Arise Crossover
	Feito para Delta Executor
--]]

-- AntiBan Básico
pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
end)

-- Interface Neon Azul (usando UI Library leve)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Arise Hub", "Sentinel")

-- Variáveis
local LocalPlayer = game.Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")

-- Aba: Menu
local menu = Window:NewTab("Menu")
local menuSection = menu:NewSection("Sistema")

menuSection:NewButton("Rejoin", "Reconecta ao servidor", function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

menuSection:NewButton("Server Hop", "Muda para outro servidor", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/1gtVMUz3"))()
end)

-- Aba: AutoFarm
local autofarm = Window:NewTab("AutoFarm")
local farmSection = autofarm:NewSection("Farm")

farmSection:NewToggle("Ativar AutoFarm", "Farme automático de inimigos", function(state)
	_G.AutoFarm = state
	while _G.AutoFarm do
		task.wait()
		-- Identifica e ataca o inimigo mais próximo
		for _, mob in pairs(Workspace:GetDescendants()) do
			if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
				if mob:FindFirstChild("NameTag") and mob.NameTag:FindFirstChild("Title") then
					local tag = mob.NameTag.Title.Text
					if tag == "Boss" or tag == "Enemy" then
						repeat
							pcall(function()
								LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
								game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
							end)
							task.wait(0.3)
						until mob.Humanoid.Health <= 0 or not _G.AutoFarm
					end
				end
			end
		end
	end
end)

-- Aba: Montarias
local mount = Window:NewTab("Montarias")
local mountSection = mount:NewSection("Auto Captura")

mountSection:NewToggle("Auto Mount", "Captura montarias no mapa", function(state)
	_G.AutoMount = state
	while _G.AutoMount do
		task.wait(2)
		for _, v in pairs(Workspace:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("MountTag") then
				pcall(function()
					LocalPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
				end)
			end
		end
	end
end)

-- Aba: Teleportes
local tp = Window:NewTab("Teleportes")
local tpSection = tp:NewSection("Locais")

local teleportLocations = {
	["Leveling City"] = CFrame.new(100, 5, -300),
	["Grass Village"] = CFrame.new(320, 5, -700),
	["Brum Island"] = CFrame.new(600, 5, -1000),
	["Faceheal Town"] = CFrame.new(800, 5, -1300),
	["Lucky Kingdom"] = CFrame.new(1050, 5, -1600),
	["Nipon City"] = CFrame.new(1350, 5, -1900),
	["Mori Town"] = CFrame.new(1600, 5, -2100),
}

for name, cf in pairs(teleportLocations) do
	tpSection:NewButton("Ir para " .. name, "", function()
		LocalPlayer.Character.HumanoidRootPart.CFrame = cf
	end)
end

-- Aba: Guildas e Rank
local guild = Window:NewTab("Guildas")
local guildSection = guild:NewSection("Teleportes")

guildSection:NewButton("Rank Up Sala (Leveling)", "", function()
	LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(110, 5, -280)
end)

guildSection:NewButton("Guilda das Sombras (Mori)", "", function()
	LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1610, 5, -2110)
end)

-- Aba: Misc
local misc = Window:NewTab("Misc")
local miscSection = misc:NewSection("Diversos")

miscSection:NewKeybind("Mostrar/Esconder GUI", "Atalho para abrir e fechar GUI", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)
