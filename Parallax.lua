-- Options:
local maxLookUp = 5
local maxLookSide = 5
local cameraPos = Vector3.new(0, 10, 0)
local lookAtPos = Vector3.new(10, 8, 5)
local FOV = 55

-- Variables
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable

local cameraCFrame = CFrame.new(cameraPos, lookAtPos)
camera.CFrame = cameraCFrame
camera.FieldOfView = FOV
local mouse = player:GetMouse()

-- Parallax Effect
game:GetService("RunService").RenderStepped:Connect(function()
	local mouseX = (mouse.X - (workspace.CurrentCamera.ViewportSize.X / 2)) / workspace.CurrentCamera.ViewportSize.X
	local mouseY = (mouse.Y - (workspace.CurrentCamera.ViewportSize.Y / 2)) / workspace.CurrentCamera.ViewportSize.Y
	mouseX = -mouseX

	local lookX = math.clamp(mouseX * maxLookSide, -maxLookSide, maxLookSide)
	local lookY = math.clamp(mouseY * maxLookUp, -maxLookUp, maxLookUp)

	local newLookAtPos = lookAtPos + Vector3.new(lookX, -lookY, 0)
	local newCameraCFrame = CFrame.new(cameraPos, newLookAtPos)

	camera.CFrame = newCameraCFrame
end)
