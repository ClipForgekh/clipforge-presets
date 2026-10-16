import json
import urllib.request
import hashlib
import zipfile
import io
import os
import re
import sys
import subprocess
from concurrent.futures import ThreadPoolExecutor

def slugify(text):
    text = (text or "").lower().strip()
    text = re.sub(r"[^\w\s-]", "", text)
    text = re.sub(r"[-\s]+", "-", text)
    return text or "item"

def download_item(item, base_dir):
    pid = str(item["id"])
    title = item.get("title", f"item_{pid}")
    url = item.get("url")
    expected_md5 = item.get("md5")
    slug = f"{slugify(title)}_{pid[:6]}"
    target_dir = os.path.join(base_dir, slug)

    if os.path.exists(os.path.join(target_dir, ".verified")):
        return f"Already installed: {title}"

    if not url or not expected_md5:
        return f"Skipped (no url/md5): {title}"

    try:
        req = urllib.request.Request(url, headers={"User-Agent": "CapCut/9.6.0"})
        with urllib.request.urlopen(req, timeout=20) as resp:
            data = resp.read()
            h = hashlib.md5(data).hexdigest()
            if h != expected_md5:
                return f"Checksum mismatch for {title}: {h} != {expected_md5}"

            os.makedirs(target_dir, exist_ok=True)
            try:
                with zipfile.ZipFile(io.BytesIO(data)) as z:
                    z.extractall(target_dir)
            except zipfile.BadZipFile:
                # If it is a raw file rather than zip
                with open(os.path.join(target_dir, "asset.bin"), "wb") as bf:
                    bf.write(data)

            # Write manifest.json
            with open(os.path.join(target_dir, "manifest.json"), "w", encoding="utf-8") as mf:
                json.dump(item, mf, indent=2)

            # Write .verified marker
            with open(os.path.join(target_dir, ".verified"), "w", encoding="utf-8") as vf:
                vf.write(expected_md5)

            return f"Success: {title} ({len(data)} bytes)"
    except Exception as e:
        return f"Error {title}: {e}"

def process_branch(branch_name, folder_name=None, max_workers=12):
    if not folder_name:
        folder_name = branch_name

    with open("catalog.json", "r", encoding="utf-8") as f:
        catalog = json.load(f)

    items = [p for p in catalog["presets"] if p.get("branch") == branch_name]
    print(f"\n==================================================")
    print(f"Processing branch: {branch_name} ({len(items)} items)")
    print(f"==================================================")

    if not items:
        print(f"No items found for branch {branch_name}")
        return

    # Checkout new/existing branch from main
    subprocess.run(["git", "checkout", "main"], check=True)
    subprocess.run(["git", "checkout", "-B", branch_name], check=True)

    os.makedirs(folder_name, exist_ok=True)

    print(f"Downloading {len(items)} items using {max_workers} worker threads...")
    with ThreadPoolExecutor(max_workers=max_workers) as ex:
        futures = [ex.submit(download_item, item, folder_name) for item in items]
        results = [f.result() for f in futures]

    success_count = sum(1 for r in results if r.startswith("Success") or r.startswith("Already"))
    print(f"Downloaded {success_count}/{len(items)} successfully.")

    # Generate README for this folder
    readme_lines = [
        f"# ClipForge {branch_name.replace('-', ' ').title()}",
        "",
        f"This branch contains **{success_count} {branch_name.replace('-', ' ')}** packages.",
        "",
        "## Inventory",
        "",
        "| Thumbnail | Name | ID | VIP |",
        "| :---: | :--- | :---: | :---: |"
    ]
    subdirs = sorted([d for d in os.listdir(folder_name) if os.path.isdir(os.path.join(folder_name, d))])
    for sub in subdirs:
        mpath = os.path.join(folder_name, sub, "manifest.json")
        if os.path.exists(mpath):
            with open(mpath, "r", encoding="utf-8") as mf:
                m = json.load(mf)
            title = m.get("title", sub)
            pid = str(m.get("id", ""))
            cover = m.get("cover", "")
            is_vip = "Yes" if m.get("is_vip") else "Free"
            img_tag = f"<img src=\"{cover}\" width=\"50\" height=\"50\" />" if cover else "—"
            readme_lines.append(f"| {img_tag} | **{title}** (`{sub}`) | `{pid}` | `{is_vip}` |")

    with open(os.path.join(folder_name, "README.md"), "w", encoding="utf-8") as rf:
        rf.write("\n".join(readme_lines) + "\n")

    # Git add, commit, push
    print(f"Staging and committing {folder_name}/...")
    subprocess.run(["git", "add", folder_name], check=True)
    commit_msg = f"feat({branch_name}): add {success_count} {branch_name} packages"
    subprocess.run(["git", "commit", "-m", commit_msg], check=True)

    print(f"Pushing branch {branch_name} to origin...")
    subprocess.run(["git", "push", "-u", "origin", branch_name], check=True)
    print(f"✅ Successfully pushed branch {branch_name} to GitHub!")

    # Switch back to main
    subprocess.run(["git", "checkout", "main"], check=True)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        for b in sys.argv[1:]:
            process_branch(b)
    else:
        print("Usage: python3 sync_branch.py <branch_name> [<branch_name2> ...]")
