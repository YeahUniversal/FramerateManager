local RunService = game:GetService("RunService")

type funcSettings = {
	FrameRate:number?,
	Paused:boolean?,
}

local FramerateManager = {}
FramerateManager.__index = FramerateManager

FramerateManager.HBTasks = {}

function FramerateManager.new(job:(deltaTime:number)->(),Fsettings:funcSettings)
	local self = setmetatable({},FramerateManager)
	self.Paused = Fsettings.Paused or false
	self.FrameRate = Fsettings.FrameRate
	self.LastFrameTime = tick()
	self.Job = job
	
	table.insert(FramerateManager.HBTasks,self)
	
	return self
end

function FramerateManager:Update(delta)
	self.Job(delta)
end

function FramerateManager:SetPaused(bool:boolean)
	if not bool then
		self.LastFrameTime = tick()
	end
	self.Paused = bool
end

function FramerateManager:Remove()
	local pos = table.find(FramerateManager.HBTasks,self)
	table.remove(FramerateManager.HBTasks,pos)
end

RunService.Heartbeat:Connect(function(delta)
	for _,job in FramerateManager.HBTasks do
		if not job.Paused then
			local estimatedTime
			if job.FrameRate then
				estimatedTime = tick() - job.LastFrameTime -- Time elapsed between frames with set maximum fps

				if estimatedTime < job.FrameRate then -- skip job if it's not time to run by frameRate.
					continue
				end
			end
			job.LastFrameTime = tick()

			local runningTask = task.spawn(job.Update,job,estimatedTime or delta)
		end
	end
end)

return FramerateManager
