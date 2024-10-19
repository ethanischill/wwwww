local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Private @ethanischill",
    SubTitle = "...",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "list" }),
}
Window:SelectTab(1)

getgenv().Settings = {
    Main = {
        myToggle = false,
    },
}

-- Roblox Variables

local VIM = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Backpack = Player.Backpack
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Game Variables

local rods = {}
for i,v in pairs(game:GetService("ReplicatedStorage").resources.items.rods:GetChildren()) do
    table.insert(rods,v.Name)
end

-- Functions

local function equipTool(tool)
    for i,v in pairs(Character:GetChildren()) do
        if v.Name == tool then
            return
        end
    end
    for i,v in pairs(Backpack:GetChildren()) do
        if v.Name == tool then
            v.Parent = Character
            return
        end
    end
end

local function equipRod()
    for i,v in pairs(rods) do
        if Character:FindFirstChild(v) then
            return
        end
    end
    for i,v in pairs(rods) do
        if Backpack:FindFirstChild(v) then
            equipTool(v)
            return
        end
    end
end

-- Main


local myToggle = Tabs.Main:AddToggle("Toggle", 
{
    Title = "Toggle", 
    Default = false,
    Callback = function(Value)
    getgenv().Settings.Main.myToggle = Value
        if getgenv().Settings.Main.myToggle then
            while getgenv().Settings.Main.myToggle do
                -- whatever you want toggle to do
                task.wait()
            end
        end
    end 
})

Tabs.Main:AddButton({
    Title = "Carbon Crate Dupe",
    Description = "",
    Callback = function()
        equipRod()
        equipTool("Carbon Crate")
    end
})