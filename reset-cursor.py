import json
import uuid
import os
import random
import string

def generate_machine_id():
    return ''.join(random.choices(string.hexdigits.lower(), k=64))

def generate_mac_id():
    return ''.join(random.choices(string.hexdigits.lower(), k=64))

def update_telemetry_config():
    roaming = os.getenv('APPDATA')
    config_path = os.path.join(roaming, 'Cursor', 'User', 'globalStorage', 'storage.json')
    machine_id_path = os.path.join(roaming, 'Cursor', 'machineid')
    
    try:
        # update storage.json
        with open(config_path, 'r') as f:
            config = json.load(f)
        
        config["telemetry.macMachineId"] = generate_mac_id()
        config["telemetry.sqmId"] = "{" + str(uuid.uuid4()).upper() + "}"
        config["telemetry.machineId"] = generate_machine_id()
        config["telemetry.devDeviceId"] = str(uuid.uuid4())
        
        with open(config_path, 'w') as f:
            json.dump(config, f, indent=4)
        
        # update machineid file
        with open(machine_id_path, 'w') as f:
            f.write(str(uuid.uuid4()))
            
        print("Telemetry values updated successfully")
        
    except Exception as e:
        print(f"Error updating config: {e}")

update_telemetry_config()
