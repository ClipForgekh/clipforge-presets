#!/usr/bin/env python3
"""
ClipForge Preset Catalog Builder
Generates schema 1 catalog.json with verified SHA-256 hashes, sizes, and branch paths
for all assets committed across git branches in clipforge-presets.
"""

import json
import subprocess
import hashlib
import re
import datetime
import os
import sys

REPO_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def slugify(text: str) -> str:
    text = (text or "").lower().strip()
    text = re.sub(r"[^\w\s-]", "", text)
    text = re.sub(r"[-\s_]+", "-", text)
    return text.strip("-") or "item"

def valid_id(item_id: str) -> bool:
    return bool(re.match(r"^[a-z][a-z0-9]{0,15}\.[A-Za-z][A-Za-z0-9-]{0,63}$", item_id))

def get_git_tree_files(branch: str):
    cmd = ["git", "-C", REPO_DIR, "ls-tree", "-r", f"origin/{branch}"]
    res = subprocess.run(cmd, capture_output=True, text=True, check=True)
    files = {}
    for line in res.stdout.strip().split("\n"):
        if not line:
            continue
        parts = line.split(maxsplit=3)
        if len(parts) == 4:
            mode, obj_type, obj_hash, path = parts
            files[path] = (obj_hash, obj_type)
    return files

def get_blob_bytes_and_sha256(blob_hash: str):
    cmd = ["git", "-C", REPO_DIR, "cat-file", "-p", blob_hash]
    res = subprocess.run(cmd, capture_output=True, check=True)
    data = res.stdout
    sha = hashlib.sha256(data).hexdigest()
    return len(data), sha

def build():
    print(f"Building ClipForge Preset Catalog in {REPO_DIR}...")
    catalog_path = os.path.join(REPO_DIR, "catalog.json")
    with open(catalog_path, "r", encoding="utf-8") as f:
        existing = json.load(f)

    legacy_presets = existing.get("presets", [])
    print(f"Existing legacy presets: {len(legacy_presets)}")

    # Index presets by id and title
    preset_by_id = {str(p["id"]): p for p in legacy_presets if "id" in p}

    schema1_items = []
    used_ids = set()

    # 1. Process 'filters' branch
    print("\nScanning 'filters' branch...")
    filter_files = get_git_tree_files("filters")
    
    # Group files by package directory under filters/
    packages = {}
    for path, (blob_hash, obj_type) in filter_files.items():
        if path.startswith("filters/") and not "__MACOSX" in path:
            parts = path.split("/")
            if len(parts) >= 3:
                pkg = parts[1]
                packages.setdefault(pkg, {})[path] = blob_hash

    print(f"Found {len(packages)} packages in filters branch")

    for pkg_name, pkg_files in sorted(packages.items()):
        # Check for manifest.json
        manifest_path = f"filters/{pkg_name}/manifest.json"
        manifest = {}
        if manifest_path in pkg_files:
            blob_hash = pkg_files[manifest_path]
            cmd = ["git", "-C", REPO_DIR, "cat-file", "-p", blob_hash]
            try:
                manifest = json.loads(subprocess.run(cmd, capture_output=True, text=True).stdout)
            except Exception:
                pass

        # Identify Hald CLUT image
        chosen_path = None
        if f"filters/{pkg_name}/filter.png" in pkg_files:
            chosen_path = f"filters/{pkg_name}/filter.png"
        else:
            candidates = [p for p in pkg_files if p.endswith("/filter.png") or p.endswith("/filter_bg.png")]
            if candidates:
                chosen_path = sorted(candidates)[0]

        if not chosen_path:
            continue

        blob_hash = pkg_files[chosen_path]
        size, sha = get_blob_bytes_and_sha256(blob_hash)

        # Get package metadata
        pid = str(manifest.get("id", ""))
        title = manifest.get("title") or pkg_name.rsplit("_", 1)[0].replace("-", " ").title()
        category = manifest.get("category", "filter")
        cover = manifest.get("cover")

        # Make clean id
        clean_slug = slugify(title)
        pid_suffix = pid[:6] if pid else "lut"
        item_id = f"cf.lut-{clean_slug}-{pid_suffix}"[:64]
        if not valid_id(item_id):
            item_id = f"cf.lut-{pid_suffix}"

        if item_id in used_ids:
            item_id = f"{item_id[:58]}-{len(used_ids)}"
        used_ids.add(item_id)

        item = {
            "id": item_id,
            "kind": "lut",
            "name": title[:80],
            "category": category[:40],
            "version": "1.0.0",
            "branch": "filters",
            "files": [
                {
                    "path": chosen_path,
                    "sha256": sha,
                    "bytes": size,
                    "branch": "filters"
                }
            ],
            "license": "LicenseRef-ClipForge",
            "attribution": "ClipForge Community"
        }
        if cover:
            item["preview"] = {
                "path": cover,
                "sha256": "",
                "bytes": 0
            }

        schema1_items.append(item)

    print(f"Added {len(schema1_items)} verified LUT filter presets to schema 1 items.")

    # 2. Process 'voice-effects' branch
    print("\nScanning 'voice-effects' branch...")
    voice_files = get_git_tree_files("voice-effects")
    voice_packages = {}
    for path, (blob_hash, obj_type) in voice_files.items():
        if path.startswith("voice-effects/") and not "__MACOSX" in path:
            parts = path.split("/")
            if len(parts) >= 3:
                pkg = parts[1]
                voice_packages.setdefault(pkg, {})[path] = blob_hash

    voice_count = 0
    for pkg_name, pkg_files in sorted(voice_packages.items()):
        manifest_path = f"voice-effects/{pkg_name}/manifest.json"
        manifest = {}
        if manifest_path in pkg_files:
            blob_hash = pkg_files[manifest_path]
            cmd = ["git", "-C", REPO_DIR, "cat-file", "-p", blob_hash]
            try:
                manifest = json.loads(subprocess.run(cmd, capture_output=True, text=True).stdout)
            except Exception:
                pass

        audio_files = [p for p in pkg_files if p.endswith((".wav", ".mp3", ".ogg", ".m4a", ".aac"))]
        if not audio_files:
            continue

        chosen_audio = sorted(audio_files)[0]
        blob_hash = pkg_files[chosen_audio]
        size, sha = get_blob_bytes_and_sha256(blob_hash)

        # Max sound bytes in ClipForge is 10 MB
        if size > 10 * 1024 * 1024:
            continue

        pid = str(manifest.get("id", ""))
        title = manifest.get("title") or pkg_name.rsplit("_", 1)[0].replace("-", " ").title()
        category = manifest.get("category", "voice-effect")
        cover = manifest.get("cover")

        clean_slug = slugify(title)
        pid_suffix = pid[:6] if pid else "snd"
        item_id = f"cf.snd-{clean_slug}-{pid_suffix}"[:64]
        if not valid_id(item_id):
            item_id = f"cf.snd-{pid_suffix}"

        if item_id in used_ids:
            item_id = f"{item_id[:58]}-{len(used_ids)}"
        used_ids.add(item_id)

        item = {
            "id": item_id,
            "kind": "sound",
            "name": title[:80],
            "category": category[:40],
            "version": "1.0.0",
            "branch": "voice-effects",
            "files": [
                {
                    "path": chosen_audio,
                    "sha256": sha,
                    "bytes": size,
                    "branch": "voice-effects"
                }
            ],
            "license": "LicenseRef-ClipForge",
            "attribution": "ClipForge Community"
        }
        if cover:
            item["preview"] = {
                "path": cover,
                "sha256": "",
                "bytes": 0
            }

        schema1_items.append(item)
        voice_count += 1

    print(f"Added {voice_count} verified sound presets to schema 1 items.")
    print(f"Total schema 1 items: {len(schema1_items)}")

    # Construct complete catalog document
    now_iso = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    catalog_doc = {
        "schema": 1,
        "version": "1.0.0",
        "generated": now_iso,
        "repository": "https://github.com/ClipForgekh/clipforge-presets",
        "total_presets": len(legacy_presets),
        "total_items": len(schema1_items),
        "items": schema1_items,
        "presets": legacy_presets
    }

    with open(catalog_path, "w", encoding="utf-8") as f:
        json.dump(catalog_doc, f, indent=2, ensure_ascii=False)

    print(f"✅ Successfully written catalog.json ({os.path.getsize(catalog_path):,} bytes)")

if __name__ == "__main__":
    build()
