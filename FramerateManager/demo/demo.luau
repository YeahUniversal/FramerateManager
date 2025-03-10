local FramerateManager = require(script.FramerateManager)

local function TestJob(deltaTime)
	print("Job running at",1/deltaTime,"frames per second.")
end

local job = FramerateManager.CreateHBJob(TestJob,{FrameRate = 1})

task.wait(3)

job:Remove()

print("Job removed")