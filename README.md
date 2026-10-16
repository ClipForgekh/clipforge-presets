# ClipForge Presets Hub

This repository hosts official and community presets, color grading 3D LUTs, kinetic typography templates, transitions, velocity curves, and video effects for [ClipForge](https://github.com/ClipForgekh/ClipForge).

---

## 🌐 Interactive Web Catalog (`index.html`)

An interactive, searchable preset browser is published at the root of the `main` branch:

* **Local Browser:** Open [`index.html`](./index.html) directly in any web browser to search, filter by category, preview live thumbnails, and copy download links.
* **GitHub Pages Preview:** When GitHub Pages is enabled on `main`, the catalog is live at:  
  `https://clipforgekh.github.io/clipforge-presets/`

---

## ⚡ How to Fetch Files via Raw GitHub & CDN URLs

All files across all branches are publicly accessible through direct raw endpoints and edge CDNs without cloning the entire repository.

### 1. Direct GitHub Raw Endpoints
Format:
```
https://raw.githubusercontent.com/ClipForgekh/clipforge-presets/<branch>/<folder>/<item_slug>/<file>
```

#### Real Examples:
* **Hald CLUT 512×512 LUT (Pristine Cool):**
  ```
  https://raw.githubusercontent.com/ClipForgekh/clipforge-presets/filters/filters/pristine-cool_762437/filter.png
  ```
* **Hald CLUT 512×512 LUT (Floral Haze):**
  ```
  https://raw.githubusercontent.com/ClipForgekh/clipforge-presets/filters/filters/floral-haze_768779/filter.png
  ```
* **Filter Parameter Manifest:**
  ```
  https://raw.githubusercontent.com/ClipForgekh/clipforge-presets/filters/filters/pristine-cool_762437/manifest.json
  ```
* **Velocity Speed Curve Config (Flash):**
  ```
  https://raw.githubusercontent.com/ClipForgekh/clipforge-presets/velocity-curves/velocity/flash_729830/manifest.json
  ```
* **Master Presets Catalog (All 2,732 items):**
  ```
  https://raw.githubusercontent.com/ClipForgekh/clipforge-presets/main/catalog.json
  ```

---

### 2. Fast Global CDN (via jsDelivr)
For zero-latency edge caching and CORS-enabled WebGL canvas texture loading in ClipForge:

Format:
```
https://cdn.jsdelivr.net/gh/ClipForgekh/clipforge-presets@<branch>/<path>
```

#### Real Examples:
* **Direct WebGL LUT Texture:**
  ```
  https://cdn.jsdelivr.net/gh/ClipForgekh/clipforge-presets@filters/filters/pristine-cool_762437/filter.png
  ```
* **Master Catalog:**
  ```
  https://cdn.jsdelivr.net/gh/ClipForgekh/clipforge-presets@main/catalog.json
  ```

---

## 📦 Published Branches & Inventory

To prevent repository bloat and maintain fast cloning times, each category is published on its own dedicated branch:

| Category | Branch Name | Item Count | Contents & Formats | Direct Branch Link |
| :--- | :--- | :---: | :--- | :---: |
| **Catalog & Index** | `main` | 1 | `catalog.json`, `index.html`, `README.md` | [Browse `main`](https://github.com/ClipForgekh/clipforge-presets/tree/main) |
| **Color Filters** | `filters` | 49 | 512×512 Level-8 Hald CLUTs + GLSL shaders | [Browse `filters`](https://github.com/ClipForgekh/clipforge-presets/tree/filters) |
| **Velocity Curves** | `velocity-curves` | 5 | Non-linear speed ramp timing configs | [Browse `velocity-curves`](https://github.com/ClipForgekh/clipforge-presets/tree/velocity-curves) |
| **Text Templates** | `text-templates` | 314 | Kinetic typography & animated subtitle packages | [Browse `text-templates`](https://github.com/ClipForgekh/clipforge-presets/tree/text-templates) |
| **Video Effects** | `video-effects` | 1,888 | GLSL shaders, scene graphs, particle configs | [Browse `video-effects`](https://github.com/ClipForgekh/clipforge-presets/tree/video-effects) |
| **Voice Effects** | `voice-effects` | 415 | DSP voice changer parameter maps | [Browse `voice-effects`](https://github.com/ClipForgekh/clipforge-presets/tree/voice-effects) |
| **Stickers & Overlays**| `stickers-overlays` | 15 | Motion graphic overlays and sticker packages | [Browse `stickers-overlays`](https://github.com/ClipForgekh/clipforge-presets/tree/stickers-overlays) |
| **Beauty Retouch** | `beauty-retouch` | 14 | Facial retouch & skin smoothing shaders | [Browse `beauty-retouch`](https://github.com/ClipForgekh/clipforge-presets/tree/beauty-retouch) |
| **AI Styles** | `ai-styles` | 27 | AI style transfer and painting presets | [Browse `ai-styles`](https://github.com/ClipForgekh/clipforge-presets/tree/ai-styles) |
| **Miscellaneous** | `misc-presets` | 5 | Utility templates and presets | [Browse `misc-presets`](https://github.com/ClipForgekh/clipforge-presets/tree/misc-presets) |
| **Total** | | **2,732** | | |

---

## 💻 Programmatic Usage in ClipForge

### In TypeScript / WebGL Preview (`desktop/src/app/`):
```typescript
export async function loadRemoteFilterLut(slug: string): Promise<HTMLImageElement> {
  const url = `https://cdn.jsdelivr.net/gh/ClipForgekh/clipforge-presets@filters/filters/${slug}/filter.png`;
  const img = new Image();
  img.crossOrigin = "anonymous";
  return new Promise((resolve, reject) => {
    img.onload = () => resolve(img);
    img.onerror = reject;
    img.src = url;
  });
}
```

### In Rust FFmpeg Export (`crates/core`):
```rust
pub async fn download_filter_for_export(slug: &str, cache_dir: &Path) -> Result<PathBuf, String> {
    let target = cache_dir.join(format!("{}.png", slug));
    if target.exists() {
        return Ok(target);
    }
    let url = format!(
        "https://raw.githubusercontent.com/ClipForgekh/clipforge-presets/filters/filters/{}/filter.png",
        slug
    );
    let bytes = reqwest::get(&url)
        .await
        .map_err(|e| e.to_string())?
        .bytes()
        .await
        .map_err(|e| e.to_string())?;

    tokio::fs::write(&target, bytes).await.map_err(|e| e.to_string())?;
    Ok(target)
}
```
