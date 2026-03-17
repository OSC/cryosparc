#!/usr/bin/env python

import json
import argparse
import os

def update_cluster_configs(version, worker_bin_path=None, account=None):
    # Paths based on the repository structure
    script_path = 'lanes/ascend/cluster_script.sh'
    info_path = 'lanes/ascend/cluster_info.json'

    # Modify worker_bin_path in cluster_info.json
    if os.path.exists(info_path):
        with open(info_path, 'r') as f:
            data = json.load(f)
        
        # Update the specific key
        data['worker_bin_path'] = worker_bin_path
        
        with open(info_path, 'w') as f:
            json.dump(data, f, indent=4)
        print(f"Successfully updated {info_path} with path: {worker_bin_path}")
    else:
        print(f"Error: {info_path} not found.")

    # Replace {{ account }} in cluster_script.sh
    if not account:
       return       

    if os.path.exists(script_path):
        with open(script_path, 'r') as f:
            content = f.read()
        
        # Replace the placeholder with the provided account value
        updated_content = content.replace('{{ account }}', account)
        
        with open(script_path, 'w') as f:
            f.write(updated_content)
        print(f"Successfully updated {script_path} with account: {account}")
    else:
        print(f"Error: {script_path} not found.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Configure CryoSPARC lane files for OSC Ascend.")
    
    # Arguments for the features
    parser.add_argument("--version", required=True, help="The CryoSPARC version")
    parser.add_argument("--account", required=False, default=None, help="The CryoSPARC project account (e.g., PAS1234)")
    parser.add_argument("--worker-path", required=False, default=None, help="The absolute path to the cryosparcw binary")

    args = parser.parse_args()

    if not args.worker_path:
        args.worker_path = f"/apps/cryosparc-worker/{args.version}/bin/cryosparcw"

    update_cluster_configs(args.version, args.worker_path, args.account)
