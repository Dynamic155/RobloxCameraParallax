# Roblox Parallax Camera

A lightweight LocalScript module that tilts your camera based on mouse position — smooth, frame-rate independent, and easy to drop into any project.

---

## Features

- **Single config table** — camera position, FOV, offsets, smoothing, dead zone, and axis inversion all live in one place
- **Frame-rate independent smoothing** — uses `1 - exp(-Smoothing * dt)` so the feel is identical at 30 fps and 240 fps
- **Dead zone** — a configurable centre region that ignores tiny mouse movements, preventing camera drift from hand tremor
- **Axis inversion** — flip horizontal or vertical parallax with a boolean, no math changes needed
- **Accurate basis vectors** — offsets are applied along the camera's own `RightVector` and `UpVector`, not world axes

---

## Installation

Copy `ParallaxCamera.lua` into `StarterPlayerScripts`, then require it from a LocalScript in the same location:

```lua
-- StarterPlayerScripts/CameraController (LocalScript)
local ParallaxCamera = require(script:WaitForChild("ParallaxCamera"))
ParallaxCamera:Start({
    CameraPosition    = Vector3.new(20, 100, 0),
    LookAtPosition    = Vector3.new(0, 100, 0),
    FieldOfView       = 65,
    MaxSideOffset     = 5,
    MaxVerticalOffset = 5,
})
```

---

## Configuration

Every option is optional — omit any key to use the default.

```lua
{
    -- Camera
    CameraPosition    = Vector3.new(10, 100, 0), -- World position of the camera
    LookAtPosition    = Vector3.new(0, 100, 0),  -- Resting look-at point
    FieldOfView       = 65,                       -- Degrees

    -- Parallax feel
    MaxSideOffset     = 5,     -- Max horizontal shift in studs
    MaxVerticalOffset = 5,     -- Max vertical shift in studs
    Smoothing         = 8,     -- 1 (floaty) → 20 (snappy)
    InvertX           = false, -- Flip horizontal direction
    InvertY           = false, -- Flip vertical direction

    -- Dead zone: fraction of screen treated as "no movement" (0–0.4)
    DeadZone          = 0.05,
}
```

**Smoothing** — lower values feel like the camera is on a spring; higher values feel more direct. Around 5–10 is a good starting range.

**DeadZone** — `0.05` means the inner 5% of the screen on each side produces no movement. Raise it if the camera feels restless; set it to `0` to disable entirely.

**MaxSideOffset / MaxVerticalOffset** — these are in studs. Values above ~15 tend to feel disorienting unless your `LookAtPosition` is far away.

---

## Usage Example

```lua
local ParallaxCamera = require(script:WaitForChild("ParallaxCamera"))

ParallaxCamera:Start({
    CameraPosition    = Vector3.new(5, 15, 5),
    LookAtPosition    = Vector3.new(15, 10, 10),
    FieldOfView       = 70,
    MaxSideOffset     = 10,
    MaxVerticalOffset = 8,
    Smoothing         = 6,
    DeadZone          = 0.08,
})
```

Place the LocalScript under `StarterPlayerScripts`, hit Play, and move your mouse around.

---

## Notes

- The module sets `camera.CameraType` to `Scriptable` on start. If something else in your project also controls the camera, this will conflict.
- `LookAtPosition` can be updated each frame if you want the camera to track a moving object — just expose it through the module's state or restart with a new config.
- To temporarily disable the effect, add an `Enabled` flag to the config and guard the render loop with it.

---

## Contributing

1. Fork the repo
2. Branch off `main` — `git checkout -b feat/your-feature`
3. Commit with a short message describing what changed and why
4. Open a PR against `main`
