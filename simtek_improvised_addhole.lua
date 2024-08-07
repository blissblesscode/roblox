local function addHole(result)
	-- you can place these variables at the top or outside the function scope
	-- also add a sound in the ReplicatedStorage with a name called "bulletImpact"
	local RS = game:GetService("ReplicatedStorage")
	local holet = RS:WaitForChild("Hole")
	local holeSound = RS:WaitForChild("bulletImpact")
	local debris = game:GetService("Debris")
	
	if result.Instance then
		local hole = holet:Clone()
		local wc = Instance.new("WeldConstraint", hole)
		local sound = holeSound:Clone()
		
		hole.Parent = result.Instance
		hole.Position = result.Position
		hole.CFrame = CFrame.new(hole.Position, hole.Position + result.Normal)
		
		-- to make the hole object sticks to any object or non humanoid target
		wc.Part0 = hole
		wc.Part1 = result.Instance

		-- Play the bulletImpact sound
		sound.Parent = hole
		sound:Play()

		-- Check if the target is an npc or player and if yes then the bullet will not appear
		local target = result.Instance.Parent
		local hum = target:FindFirstChild("Humanoid")
		local hrp = target:FindFirstChild("HumanoidRootPart")
		
		if hum or hrp then
			debris:AddItem(hole, 0)
		else
			debris:AddItem(hole, 5)
		end
	end
end