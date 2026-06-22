--===== CONFIGURATION =====--
local Config = {
	-- Camera
	CameraPosition    = Vector3.new(18, 16.5, -27),
	LookAtPosition    = Vector3.new(0, 1.5, 0),
	FieldOfView       = 65,

	-- Parallax feel
	MaxSideOffset     = 5,
	MaxVerticalOffset = 5,
	Smoothing         = 8,      -- Higher = snappier, lower = floatier (1–20 recommended)
	InvertX           = true,  -- Flip horizontal parallax
	InvertY           = true,  -- Flip vertical parallax

	-- Dead zone: fraction of screen centre treated as "no movement" (0 to 0.4)
	DeadZone          = 0.15,
}

--===== SERVICES =====--
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")

--===== LOCALS =====--
local player = Players.LocalPlayer
local mouse  = player:GetMouse()
local camera = workspace.CurrentCamera

--===== INIT =====--
camera.CameraType  = Enum.CameraType.Scriptable
camera.FieldOfView = Config.FieldOfView

local baseCFrame  = CFrame.new(Config.CameraPosition, Config.LookAtPosition)
local rightVector = baseCFrame.RightVector
local upVector    = baseCFrame.UpVector
camera.CFrame = baseCFrame

-- Smoothed normalised offsets (start at centre)
local smoothNormX = 0
local smoothNormY = 0

--===== HELPERS =====--

-- Applies a dead zone and remaps the remaining range back to [-1, 1]
local function applyDeadZone(value, zone)
	local sign = value >= 0 and 1 or -1
	local abs  = math.abs(value)
	if abs < zone then return 0 end
	return sign * (abs - zone) / (1 - zone)
end

--===== RENDER LOOP =====--
RunService.RenderStepped:Connect(function(dt)
	local vw = camera.ViewportSize.X
	local vh = camera.ViewportSize.Y

	-- Raw normalised mouse position [-0.5, 0.5]
	local rawX = (mouse.X / vw) - 0.5
	local rawY = (mouse.Y / vh) - 0.5

	-- Dead zone + optional inversion
	local targetX = applyDeadZone(rawX, Config.DeadZone) * (Config.InvertX and  1 or -1)
	local targetY = applyDeadZone(rawY, Config.DeadZone) * (Config.InvertY and -1 or  1)

	-- Exponential smoothing (frame-rate independent)
	local alpha   = 1 - math.exp(-Config.Smoothing * dt)
	smoothNormX   = smoothNormX + (targetX - smoothNormX) * alpha
	smoothNormY   = smoothNormY + (targetY - smoothNormY) * alpha

	-- Map to world-space offsets
	local offsetX = smoothNormX * Config.MaxSideOffset
	local offsetY = smoothNormY * Config.MaxVerticalOffset

	-- Shift the look-at point so the camera rotates, not slides
	local adjustedLookAt = Config.LookAtPosition
		+ rightVector * offsetX
		+ upVector    * offsetY

	camera.CFrame = CFrame.new(Config.CameraPosition, adjustedLookAt)
end)
