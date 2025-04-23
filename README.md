## Roblox Parallax Camera Module

A reusable, beginner-friendly module that adds a smooth, mouse-driven parallax look-around effect to your Roblox camera. Tweak a few values in one place and drop it into your project!

---

## 🚀 Features

- **Easy Configuration**  
  All key settings (camera position, look-at target, FOV, max offsets) live in one `Config` table.

- **True Horizontal Parallax**  
  Uses the camera’s `RightVector` and `UpVector` for accurate side-to-side and vertical shifts.

- **Lightweight & Performant**  
  Precomputes basis vectors once; only minimal math each frame.

- **Self-Documenting**  
  Clear section headers and inline comments make it simple to understand and extend.

---

## 📥 Installation

1. **Copy** the `ParallaxCamera.lua` module into your project (e.g. under `StarterPlayerScripts`).
2. **Require** and **initialize** in a LocalScript:

   ```lua
   -- In StarterPlayerScripts/CameraController.script
   local ParallaxCamera = require(script:WaitForChild("ParallaxCamera"))
   ParallaxCamera:Start({
       CameraPosition    = Vector3.new(20, 100, 0),
       LookAtPosition    = Vector3.new(0, 100, 0),
       FieldOfView       = 65,
       MaxSideOffset     = 55,
       MaxVerticalOffset = 5,
   })
   ```

---

## ⚙️ Configuration

All configurable values live in a single table:

```lua
local Config = {
    -- Camera placement in world space
    CameraPosition    = Vector3.new(0, 10, 0),
    -- The point the camera always looks toward
    LookAtPosition    = Vector3.new(10, 8, 5),
    -- Field of view (degrees)
    FieldOfView       = 55,

    -- Max horizontal shift (studs)
    MaxSideOffset     = 5,
    -- Max vertical shift (studs)
    MaxVerticalOffset = 5,
}
```

- **CameraPosition**: Change to move your camera’s origin.  
- **LookAtPosition**: Change where the camera aims at rest.  
- **FieldOfView**: Wider FOV feels more dynamic; narrower is more focused.  
- **MaxSideOffset / MaxVerticalOffset**: Increase for bolder movement; decrease for subtler effect.

---

## 🎮 Usage Example

```lua
local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")

-- Require the module
local ParallaxCamera = require(path.to.ParallaxCamera)

-- Start it with defaults or custom Config
ParallaxCamera:Start({
    CameraPosition    = Vector3.new(5, 15, 5),
    LookAtPosition    = Vector3.new(15, 10, 10),
    FieldOfView       = 70,
    MaxSideOffset     = 10,
    MaxVerticalOffset = 8,
})
```

1. Place the above in a **LocalScript** under **StarterPlayerScripts**.  
2. Adjust the table values to taste.  
3. Playtest to see your new parallax in action!

---

## 🛠️ Advanced Tips

- **Smoothing**: Wrap the CFrame update in `CFrame:Lerp(currentCFrame, targetCFrame, alpha)` for eased motion.  
- **Dynamic Targets**: Point the camera at a moving object by updating `LookAtPosition` each frame.  
- **Toggle On/Off**: Add a boolean flag to enable or disable the effect at runtime.  

---

## 🤝 Contributing

1. Fork this repo.  
2. Create a feature branch (`git checkout -b feat/my-awesome-feature`).  
3. Commit your changes (`git commit -m "Add awesome feature"`).  
4. Push to the branch (`git push origin feat/my-awesome-feature`).  
5. Open a Pull Request—we’ll review and merge!
