local ArcHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cagus17/C-Ui-Lib/refs/heads/main/Lib/Source.lua"))()
local ArchubGui = ArcHub:Create({
	["NameHub"] = "Cagus Hub",
	["Color"] = Color3.fromRGB(0, 85, 0),
	MinimizeKey = Enum.KeyCode.LeftControl
})

local Tab1 = ArchubGui:TabCreate({
	["Name"] = "Menu",
	["Color"] = Color3.fromRGB(0, 170, 255)
})

local Tab2 = ArchubGui:TabCreate({
	["Name"] = "Vip",
	["Color"] = Color3.fromRGB(0, 170, 255)
})

local Section1 = Tab1:Section({
	["Name"] = "Farming",
	["Color"] = Color3.fromRGB(0, 170, 255)
})

local Toggle = Section1:Toggle({
	["Title"]= "Auto Farm",
	["Default"] = false,
	["Multi"] = true,
	["Options"] = {"Option 1", "Option 2"},
	["Selecting"] = {"Option 1"},
	["Callback"] = function(Value) 
		print(Value)
	end
})
Toggle:Set(false)
--Section1:Label("Label")
local Slider = Section1:Slider({
	["Title"] = "Contras",
	["Min"] = 0,
	["Max"] = 100,
	["Increment"] = 1,
	["Default"] = 30,
	["Callback"] = function(Value) 
		print(Value)
	end
})
Slider:Set(30)

local Input = Section1:TextBox({
	["Title"] = "Cord Pos",
	["Callback"] = function(Value) 
		print(Value)
	end
})
Input:Set("Input Text")