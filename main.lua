--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- Taken from my GitHub: https://github.com/ImInsane-1337/neverlose-ui

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImInsane-1337/neverlose-ui/refs/heads/main/source/library.lua"))()
local CheatName = "navalua"

Library.Folders = {
    Directory = CheatName,
    Configs = CheatName .. "/Configs",
    Assets = CheatName .. "/Assets",
}

local Accent = Color3.fromRGB(255, 80, 80)
local Gradient = Color3.fromRGB(120, 20, 20)

Library.Theme.Accent = Accent
Library.Theme.AccentGradient = Gradient
Library:ChangeTheme("Accent", Accent)
Library:ChangeTheme("AccentGradient", Gradient)

local Window = Library:Window({
    Name = "navalua",
    SubName = "v1.0",
    Logo = "120959262762131"
})

local KeybindList = Library:KeybindList("Keybinds")

-- FPS Watermark
task.spawn(function()
    while true do
        local FPS = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        Library:Watermark({
            "navalua",
            "by ImInsane",
            120959262762131,
            "FPS: " .. FPS
        })
        task.wait(0.5)
    end
end)

--------------------------------------------------------------------------------
-- 1. LEGIT CATEGORY
--------------------------------------------------------------------------------
Window:Category("Legit")
local LegitPage = Window:Page({Name = "Legit", Icon = "138827881557940"})
local MainSection = LegitPage:Section({Name = "Main Features", Side = 1})

MainSection:Toggle({
    Name = "Enabled",
    Flag = "LegitEnabled",
    Default = false,
    Callback = function(Value)
        print("Legit Status:", Value)
    end
})

MainSection:Slider({
    Name = "Speed Hack",
    Flag = "SpeedSlider",
    Min = 16,
    Max = 100,
    Default = 16,
    Suffix = " studs",
    Callback = function(Value)
        local LP = game.Players.LocalPlayer
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = Value
        end
    end
})

--------------------------------------------------------------------------------
-- 2. RAGE CATEGORY
--------------------------------------------------------------------------------
Window:Category("Rage")
local RagePage = Window:Page({Name = "RageBot", Icon = "138827881557940"})
local RageSection = RagePage:Section({Name = "Rage Features", Side = 1})

RageSection:Toggle({
    Name = "Rage Attack",
    Flag = "RageAttack",
    Default = false,
    Callback = function(Value)
        print("[navalua - RAGE] Attack active:", Value)
        task.spawn(function()
            while Library.Flags.RageAttack do
                task.wait(0.1)
            end
        end)
    end
})

RageSection:Toggle({
    Name = "Spamming Void",
    Flag = "SpamVoid",
    Default = false,
    Callback = function(Value)
        print("[navalua - RAGE] Spamming Void active:", Value)
        task.spawn(function()
            while Library.Flags.SpamVoid do
                task.wait(0.05)
            end
        end)
    end
})

--------------------------------------------------------------------------------
-- 3. VISUALS CATEGORY (ESP & World Settings)
--------------------------------------------------------------------------------
Window:Category("Visuals")
local VisualsPage = Window:Page({Name = "Visuals", Icon = "138827881557940"})
local EspSection = VisualsPage:Section({Name = "ESP Settings", Side = 1})
local WorldSection = VisualsPage:Section({Name = "World Settings", Side = 2})

local EspColor = Color3.fromRGB(255, 0, 0)

EspSection:Toggle({
    Name = "Player ESP",
    Flag = "EspEnabled",
    Default = false,
    Callback = function(Value)
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local hl = player.Character:FindFirstChild("ESPHighlight")
                if Value then
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "ESPHighlight"
                        hl.FillColor = EspColor
                        hl.Parent = player.Character
                    end
                else
                    if hl then hl:Destroy() end
                end
            end
        end
    end
})

EspSection:Label("ESP Color"):Colorpicker({
    Name = "ESP Color",
    Flag = "EspColorPicker",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Value)
        EspColor = Value
    end
})

WorldSection:Slider({
    Name = "Time of Day",
    Flag = "WorldTime",
    Min = 0,
    Max = 24,
    Default = 12,
    Suffix = " hrs",
    Callback = function(Value)
        game:GetService("Lighting").ClockTime = Value
    end
})

--------------------------------------------------------------------------------
-- 4. MISC CATEGORY (Hit Sound)
--------------------------------------------------------------------------------
Window:Category("Misc")
local MiscPage = Window:Page({Name = "Misc", Icon = "138827881557940"})
local SoundSection = MiscPage:Section({Name = "Audio & Hitsound", Side = 1})

SoundSection:Dropdown({
    Name = "Hit Sound",
    Flag = "HitSoundSelect",
    Default = {"Neverlose"},
    Items = {"Neverlose", "Skeet", "COD", "Bameware"},
    Multi = false,
    Callback = function(Value)
        print("Selected Hit Sound:", Value)
    end
})

SoundSection:Button({
    Name = "Test Hit Sound",
    Callback = function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://8640730088"
        sound.Volume = 2
        sound.Parent = game:GetService("SoundService")
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end
})

--------------------------------------------------------------------------------
-- 5. SETTINGS CATEGORY (Config System)
--------------------------------------------------------------------------------
Window:Category("Settings")
local SettingsPage = Library:CreateSettingsPage(Window, KeybindList)

Window:Init()
