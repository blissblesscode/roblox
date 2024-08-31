--[[
ꕤ ──────୨ৎ────✦────୨ৎ────✦────୨ৎ────✦────୨ৎ──── ꕤ
This script is made by Vita (BissBassBussBoss). 
The purpose of this script is to prevent any player from 
exploiting any wall in your game.

I’ve created this because I heard some developers are 
struggling (or perhaps lazy) to prevent hackers or exploiters 
from passing through walls. 
For example, some players use an infinity yield.

Please help attribute or credit my name for this script, as 
I'm not gaining any profit from making this script or project. 
Feel free to use it. I give this script from 
my heart, not just my mind. ❤️❤️❤️

The license is available on my GitHub repository (MIT License).
ꕤ ──────୨ৎ────✦────୨ৎ────✦────୨ৎ────✦────୨ৎ──── ꕤ
--]]

-- basic properties of the game
local WS  = game:GetService("Workspace")
local dir = script.Parent 
-- the directory (dir) is just a default directory, you can 
-- change it or adding a new directory. for example; dir1 or dir2 
-- if you confused you can check at the developer marketplace

-- This is a folder of all anti-clip parts
local partFolder = dir:WaitForChild("antiClips", 1) 

-- This is a part to locate where the player should be teleported
local teleportTo = dir:WaitForChild("startSpot", 1) 

-- Function to teleport player to the spot
local function giveEffect(player)
	if teleportTo then
		player.Character.HumanoidRootPart.CFrame = teleportTo.CFrame
	else
		print("The startSpot is not found in the map")
		-- you can remove the "else" and "print" debug
	end
end

-- Function to handle player touching the part or block
local function playerTouch(part)
	part.Touched:Connect(
		function(hit)
			local player = game.Players:GetPlayerFromCharacter(hit.Parent)

			if player then
				giveEffect(player)
			else
				print("The sensor try to redetecting")
			end
		end)
end

-- Function to ensure CanTouch is enabled
local function checkTouch(part)
	if not part.CanTouch then
		part.CanTouch = true
	end
end

-- Apply playerTouch and checkTouch functions to each part in the folder
for _, part in ipairs(partFolder:GetChildren()) do
	playerTouch(part)
	checkTouch(part)

	part:GetPropertyChangedSignal("CanTouch"):Connect(function()
		checkTouch(part)
	end)
end
