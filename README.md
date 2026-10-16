# ClipForge Presets Hub

This repository hosts community and official presets, color grading LUTs, kinetic typography templates, transitions, and video effects for [ClipForge](https://github.com/ClipForgekh/ClipForge).

---

## Architecture & Branch Strategy

To keep the repository lightweight, fast to clone, and within GitHub repository boundaries:

* **`main` Branch (Index & Manifest):** Contains this `README.md`, [`catalog.json`](./catalog.json) (metadata for all 2,732 presets), and automated download/sync scripts.
* **Category Branches (Target Packages):** Each category of presets is stored on its own dedicated branch:
  * [`filters`](https://github.com/ClipForgekh/clipforge-presets/tree/filters) — Color Grading LUTs (512×512 Hald CLUTs + WebGL/FFmpeg shaders).
  * [`velocity-curves`](https://github.com/ClipForgekh/clipforge-presets/tree/velocity-curves) — Non-linear speed curves and ramps.
  * [`text-templates`](https://github.com/ClipForgekh/clipforge-presets/tree/text-templates) — Animated kinetic typography templates.
  * [`stickers-overlays`](https://github.com/ClipForgekh/clipforge-presets/tree/stickers-overlays) — Motion graphic overlays and stickers.
  * [`video-effects`](https://github.com/ClipForgekh/clipforge-presets/tree/video-effects) — GLSL shader effect bundles.

---

## Category Inventory

| Category | Branch Name | Item Count | Asset Type |
| :--- | :--- | :---: | :--- |
| **Filters** | `filters` | 49 | 512×512 Level-8 Hald CLUTs (`filter.png`) + GLSL |
| **Velocity Curves** | `velocity-curves` | 5 | Speed ramp control points & timing configs |
| **Text Templates** | `text-templates` | 314 | Typography styles, animations, font references |
| **Video Effects** | `video-effects` | 1,888 | Multi-pass GLSL shaders & AmazingEngine bundles |
| **Voice Effects** | `voice-effects` | 415 | DSP voice changer parameter maps |
| **Stickers & Overlays**| `stickers-overlays` | 15 | Animated WebP/PNG motion overlays |
| **AI Styles** | `ai-styles` | 27 | Style transfer & portrait prompt presets |
| **Beauty Retouch** | `beauty-retouch` | 14 | Facial retouch & skin smoothing shaders |

---

## Integration in ClipForge

ClipForge automatically queries [`catalog.json`](./catalog.json) to display available presets in the Inspector panel. When a user applies a preset, ClipForge fetches the package, verifies its SHA-256/MD5 checksum, and caches it locally in:

```
~/.clipforge/presets/<category>/<preset_id>/
├── .verified
├── manifest.json
└── assets/
```
