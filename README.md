# Roblox Camera Parallax Effect

This script creates a parallax effect for 3D GUI elements in Roblox by adjusting the camera's position based on the player's mouse movements. 

## How It Works

The script uses the `RenderStepped` event to continuously update the camera's position and create a parallax effect. As the player moves their mouse, the camera subtly shifts its viewpoint, making GUI elements appear more dynamic and three-dimensional.

## Script Overview

Here's a breakdown of the script and its components:

### Options

- `maxLookUp`: The maximum vertical angle the camera can look up. 
- `maxLookSide`: The maximum horizontal angle the camera can look to the sides.
- `cameraPos`: The initial position of the camera in the 3D space.
- `lookAtPos`: The initial position the camera is looking at.
- `FOV`: The Field of View of the camera.

### Variables

- `player`: The local player using the camera.
- `camera`: The current camera in the workspace.
- `cameraCFrame`: The initial CFrame (position and orientation) of the camera.
- `mouse`: The local player's mouse.

### Parallax Effect

The parallax effect is created by recalculating the camera's `CFrame` on each frame based on the player's mouse position. The new camera position is calculated to simulate a depth effect.

## Options

- **`maxLookUp`**: Adjusts the maximum angle the camera can tilt upwards. Increase or decrease this value to control the vertical movement sensitivity.
  
  ```lua
  local maxLookUp = 5
  ```

- **`maxLookSide`**: Adjusts the maximum angle the camera can tilt to the sides. Increase or decrease this value to control the horizontal movement sensitivity.
  
  ```lua
  local maxLookSide = 5
  ```

- **`cameraPos`**: Sets the initial position of the camera. Change the `Vector3` values to place the camera at a different starting position.
  
  ```lua
  local cameraPos = Vector3.new(0, 10, 0)
  ```

- **`lookAtPos`**: Sets the initial point the camera looks at. Change the `Vector3` values to alter where the camera is initially focused.
  
  ```lua
  local lookAtPos = Vector3.new(10, 8, 5)
  ```

- **`FOV`**: Sets the Field of View of the camera. Modify this value to change how wide or narrow the camera's view is.
  
  ```lua
  local FOV = 55
  ```

## Customization

To customize the effect, adjust the values of the options at the beginning of the script. For instance, increasing `maxLookUp` and `maxLookSide` will make the camera more responsive to mouse movements, enhancing the parallax effect.

```lua
local maxLookUp = 10
local maxLookSide = 10
```

You can also change the initial camera position and the point it looks at to better fit your scene.

```lua
local cameraPos = Vector3.new(5, 15, 5)
local lookAtPos = Vector3.new(15, 10, 10)
```
