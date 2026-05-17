# 🔮 wzBlips (Wizard Blips)
<p align="center">
  <img src="https://img.shields.io/badge/FiveM-Resource-orange.svg" alt="FiveM">
  <img src="https://img.shields.io/badge/FXVersion-Cerulean-blue.svg" alt="FX Version">
  <img src="https://img.shields.io/badge/Author-WizardXSC-purple.svg" alt="Author">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
</p>

---

## 🌟 Overview
**wzBlips** is a premium, lightweight, and modern map blip manager designed specifically for **FiveM** servers. It features support for custom scaleform typography, allowing server owners to render map blips with elegant, custom fonts (defaulting to the beautiful **Fire Sans**). 

This resource offers a dual-mode integration: you can define static map blips through an easy-to-use configuration file, or dynamically generate and manage blips on-the-fly using powerful, performant developer exports.

---

## ✨ Features
* 🖋️ **Custom Font Rendering:** Elevate your UI and map aesthetics with the included custom `Fire Sans` typography scaleform.
* ⚙️ **Fully Configuration-Driven:** Easily register static map blips with custom coordinates, scales, color schemes, and short-range toggles.
* 🚀 **High Performance:** Client-side registration runs on standard Lua threads with zero overhead once initialized.
* 🔌 **Developer-Friendly API:** Simple exports to register or fetch registered blips from external scripts dynamically.
* 📦 **Standalone:** Zero dependencies. Compatible with ESX, QBCore, or any custom FiveM framework.

---

## 📂 File Structure
```bash
wzBlips/
├── stream/
│   └── firesans.gfx       # Scaleform font resource for Fire Sans
├── client.lua             # Client runtime & dynamic export handler
├── config.lua             # Master static configuration
└── fxmanifest.lua         # FiveM resource manifest
```

---

## 🛠️ Installation

1. **Download & Extract:**
   Download and place the `wzBlips` folder directly into your server's `resources` directory (e.g., `resources/[standalone]/wzBlips`).

2. **Add to server.cfg:**
   Open your `server.cfg` file and add the start command:
   ```cfg
   ensure wzBlips
   ```

3. **Configure & Enjoy:**
   Modify the static blips inside the [config.lua](file:///c:/Users/Basilis/Downloads/wzBlips/config.lua) file, restart the resource, and watch your gorgeous map blips load in!

---

## 🔧 Configuration
The script is configured via [config.lua](file:///c:/Users/Basilis/Downloads/wzBlips/config.lua). Below is a structured example with detailed options:

```lua
Config = {}

-- Enable or disable custom Fire Sans Scaleform rendering on the map blips
Config.EnableCustomFont = true

Config.Blips = {
    { 
        title = "Mission Row PD",       -- Name of the blip shown on the map legend
        colour = 38,                    -- Blip color ID (Blue)
        id = 60,                        -- Sprite ID (Police badge)
        scale = 0.8,                    -- Visual size of the blip on the map
        coords = vector3(441.8, -982.0, 30.6), -- Location vector
        shortRange = true               -- True: Only shows up close or on minimap; False: Always visible globally
    },
    { 
        title = "Pillbox Medical", 
        colour = 49, 
        id = 61, 
        scale = 0.8, 
        coords = vector3(294.0, -1448.0, 29.5), 
        shortRange = true 
    }
}
```

> [!TIP]
> * For a complete list of **Blip Sprites (IDs)**, refer to the [FiveM Documentation - Blip Sprites](https://docs.fivem.net/docs/game-references/blips/#blip-sprites).
> * For **Blip Colors (IDs)**, refer to the [FiveM Documentation - Blip Colors](https://docs.fivem.net/docs/game-references/blips/#blip-colors).

---

## 🔌 Developer API (Exports)

`wzBlips` includes dynamic client-side exports to integrate seamlessly into other systems (e.g., jobs, car dealerships, robberies, or dynamically updating points of interest).

### 1. `CreateBlip`
Dynamically registers a new blip using the script's core logic (and custom font rendering).

```lua
-- Signature
exports['wzBlips']:CreateBlip(title, colour, id, scale, coords, shortRange)

-- Example Usage
exports['wzBlips']:CreateBlip(
    "Custom Shop",                      -- Title
    5,                                  -- Colour (Yellow)
    52,                                 -- Sprite ID (Shopping Bag)
    0.7,                                -- Scale
    vector3(-707.0, -913.0, 19.0),      -- Coords
    true                                -- Short Range
)
```

### 2. `GetBlips`
Fetches a list of all currently tracked blips registered through the resource.

```lua
-- Signature
local activeBlips = exports['wzBlips']:GetBlips()

-- Example Usage
CreateThread(function()
    local blipsList = exports['wzBlips']:GetBlips()
    for _, blipData in ipairs(blipsList) do
        print(string.format("Registered Blip: %s at %s", blipData.title, tostring(blipData.coords)))
    end
end)
```

---

## 🎨 Custom Scaleform Font Details
This resource utilizes the custom font file `stream/firesans.gfx`. It registers the font file into FiveM's game engine dynamically:
```lua
RegisterFontFile('firesans')
RegisterFontId('Fire Sans')
```
And maps it using HTML text tags on the native scaleform strings:
```lua
AddTextComponentString('<font face="Fire Sans">Blip Name</font>')
```
This is fully modular. If you ever wish to replace the font, simply drop your custom `.gfx` file in the stream folder, change the registration identifiers, and you are good to go!

---
