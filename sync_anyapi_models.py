#!/usr/bin/env python3
import os
import sys
import json
import urllib.request
import urllib.error
import time

def main():
    # 1. Grab API key
    api_key = os.environ.get("ANYAPI_API_KEY")
    if not api_key:
        print("Error: ANYAPI_API_KEY environment variable is not set.")
        print("Usage: ANYAPI_API_KEY=sk-... python3 sync_anyapi_models.py")
        sys.exit(1)
        
    base_url = "https://api.anyapi.ai/v1"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }
    
    # 2. Fetch the full model list
    print("Fetching models from AnyAPI...")
    req = urllib.request.Request(f"{base_url}/models", headers=headers)
    try:
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode())
    except urllib.error.URLError as e:
        print(f"Failed to fetch models: {e}")
        sys.exit(1)
        
    models = data.get("data", [])
    model_ids = [m["id"] for m in models if "id" in m]
    print(f"Found {len(model_ids)} models. Testing them sequentially to respect rate limits...\n")
    
    # 3. Test each model
    working_models = []
    
    for mid in model_ids:
        payload = json.dumps({
            "model": mid,
            "messages": [{"role": "user", "content": "Respond with exactly: OK"}],
            "max_tokens": 5
        }).encode("utf-8")
        
        req = urllib.request.Request(f"{base_url}/chat/completions", data=payload, headers=headers)
        
        try:
            # 10-second timeout so offline models don't hang the script indefinitely
            with urllib.request.urlopen(req, timeout=10) as res:
                if res.status == 200:
                    res_body = json.loads(res.read().decode())
                    content = res_body["choices"][0]["message"]["content"].strip()
                    print(f"✅ {mid}: {content}")
                    working_models.append(mid)
        except urllib.error.HTTPError as e:
            # Ignore 404, 403, 500, etc.
            print(f"❌ {mid}: HTTP {e.code}")
        except Exception as e:
            # Ignore timeouts and network drops
            print(f"❌ {mid}: Failed ({e})")
            
        # Brief pause to ensure we don't trip free-tier rate limits
        time.sleep(0.5)

    print(f"\n--- Results ---")
    print(f"Found {len(working_models)} working models out of {len(model_ids)} total.")
    
    if not working_models:
        print("No models responded successfully. Exiting without updating config.")
        sys.exit(0)
        
    # 4. Nondestructively update .opencode/opencode.json
    config_dir = ".opencode"
    config_path = os.path.join(config_dir, "opencode.json")
    
    os.makedirs(config_dir, exist_ok=True)
    
    config = {}
    if os.path.exists(config_path):
        try:
            with open(config_path, "r") as f:
                config = json.load(f)
        except Exception as e:
            print(f"Could not read existing {config_path}: {e}. Starting fresh.")
            
    # Ensure baseline structure
    if "$schema" not in config:
        config["$schema"] = "https://opencode.ai/config.json"
    if "providers" not in config:
        config["providers"] = {}
        
    # Isolate the anyapi block
    if "anyapi" not in config["providers"]:
        config["providers"]["anyapi"] = {
            "name": "AnyAPI",
            "package": "@opencode-ai/ai/providers/openai-compatible",
            "settings": {
                "baseURL": "https://api.anyapi.ai/v1"
            }
        }
        
    if "models" not in config["providers"]["anyapi"]:
        config["providers"]["anyapi"]["models"] = {}
        
    # Inject working models
    for mid in working_models:
        # Create a clean display name (e.g. "deepseek/deepseek-r1" -> "Deepseek R1")
        clean_name = mid.split("/")[-1].replace("-", " ").title()
        
        config["providers"]["anyapi"]["models"][mid] = {
            "name": clean_name,
            "modelID": mid
        }
        
    # Save formatted JSON back to disk
    with open(config_path, "w") as f:
        json.dump(config, f, indent=2)
        
    print(f"\nSuccessfully wrote {len(working_models)} models to {config_path}")

if __name__ == "__main__":
    main()
    