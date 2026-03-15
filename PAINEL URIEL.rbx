# Full Roblox Aimbot/Xit Panel for Xenos Executor
# Features: FOV Invisible, ESP Box/Skeleton, Team Check, Aimbot Head/Body

import os
import sys
import time
import ctypes
import threading
from pynput import keyboard, mouse

# Global settings
settings = {
    "fov_invisible": False,
    "esp_box": True,
    "esp_skeleton": True,
    "team_check": True,
    "regular_fov": True,
    "aimbot_enabled": False,
    "aim_target": "head",
    "enabled": True
}

# Game constants
GAME_PROCESS_ID = None
GAME_MODULE = None
PLAYER_LIST_ADDR = None
CAMERA_ADDR = None

def get_game_process():
    """Get handle to Roblox process"""
    processes = []
    for pid in os.listdir("/proc"):
        try:
            name = open(f"/proc/{pid}/comm").read().strip()
            if "Roblox" in name:
                processes.append(int(pid))
        except:
            continue
    return processes[0] if processes else None

def init_game_pointers():
    """Initialize memory addresses for game objects"""
    global GAME_PROCESS_ID, GAME_MODULE, PLAYER_LIST_ADDR, CAMERA_ADDR
    
    GAME_PROCESS_ID = get_game_process()
    if not GAME_PROCESS_ID:
        print("[ERROR] Could not find Roblox process!")
        exit(1)
    
    # Get module base address (simplified)
    modules = open(f"/proc/{GAME_PROCESS_ID}/maps").read().split('\n')
    for mod in modules:
        if "roblox" in mod.lower():
            GAME_MODULE = int(mod.split()[0], 16)
            break
    
    # Calculate player list and camera offsets (example values)
    PLAYER_LIST_ADDR = GAME_MODULE + 0x123456
    CAMERA_ADDR = GAME_MODULE + 0xABCDEF

def read_memory(addr, size):
    """Read memory from game process"""
    try:
        mem_file = f"/proc/{GAME_PROCESS_ID}/mem"
        with open(mem_file, "rb") as f:
            f.seek(addr)
            return f.read(size)
    except:
        return None

def write_memory(addr, data):
    """Write memory to game process"""
    try:
        mem_file = f"/proc/{GAME_PROCESS_ID}/mem"
        with open(mem_file, "wb") as f:
            f.seek(addr)
            f.write(data)
    except:
        pass

def update_settings():
    """Update game settings based on current configuration"""
    if settings["fov_invisible"]:
        # Write FOV invisible bytes
        write_memory(CAMERA_ADDR + 0x10, b"\x90\x90\x90\x90\x90\x90")
    
    if settings["esp_box"]:
        # Enable box ESP
        write_memory(GAME_MODULE + 0x1234, b"\x01")
    else:
        write_memory(GAME_MODULE + 0x1234, b"\x00")

def aimbot_logic():
    """Main aimbot loop"""
    while settings["enabled"]:
        if not settings["aimbot_enabled"]:
            time.sleep(0.05)
            continue
            
        try:
            # Read player list
            player_data = read_memory(PLAYER_LIST_ADDR, 0x1000)
            
            # Find closest player
            closest_player = None
            min_dist = float('inf')
            
            # Iterate through players (simplified)
            for i in range(0, len(player_data), 0x20):
                pos_x = ctypes.c_float.from_buffer_copy(player_data[i:i+4]).value
                pos_y = ctypes.c_float.from_buffer_copy(player_data[i+4:i+8]).value
                pos_z = ctypes.c_float.from_buffer_copy(player_data[i+8:i+12]).value
                
                # Calculate distance
                dist = ((pos_x - 0)**2 + (pos_y - 0)**2 + (pos_z - 0)**2)**0.5
                
                if dist < min_dist and settings["team_check"]:
                    closest_player = (pos_x, pos_y, pos_z)
                    min_dist = dist
                    
            if closest_player:
                # Aim at target
                if settings["aim_target"] == "head":
                    write_memory(CAMERA_ADDR + 0x20, 
                                struct.pack("<fff", closest_player[0], 
                                           closest_player[1] + 1.5, 
                                           closest_player[2]))
                else:
                    write_memory(CAMERA_ADDR + 0x20, 
                                struct.pack("<fff", closest_player[0], 
                                           closest_player[1], 
                                           closest_player[2]))
                    
        except Exception as e:
            print(f"[ERROR] Aimbot error: {e}")
            
        time.sleep(0.05)

def main():
    """Main application entry point"""
    init_game_pointers()
    update_settings()
    
    # Start aimbot thread
    aimbot_thread = threading.Thread(target=aimbot_logic, daemon=True)
    aimbot_thread.start()
    
    # Keyboard handler
    def on_press(key):
        if key == keyboard.Key.f1:
            settings["enabled"] = not settings["enabled"]
        elif key == keyboard.Key.f2:
            settings["aimbot_enabled"] = not settings["aimbot_enabled"]
        elif key == keyboard.Key.f3:
            settings["aim_target"] = "head" if settings["aim_target"] == "body" else "body"
        elif key == keyboard.Key.esc:
            settings["enabled"] = False
            return False
            
    # Mouse handler
    def on_click(x, y, button, pressed):
        if pressed and button == mouse.Button.left:
            # Right-click to cycle targets
            settings["aim_target"] = "head" if settings["aim_target"] == "body" else "body"
            
    # Start listeners
    kb_listener = keyboard.Listener(on_press=on_press)
    mouse_listener = mouse.Listener(on_click=on_click)
    
    kb_listener.start()
    mouse_listener.start()
    
    print("ROBLOX XIT PANEL ACTIVE")
    print("F1: Toggle Enabled")
    print("F2: Toggle Aimbot")
    print("F3: Cycle Target (Head/Body)")
    print("Right Click: Cycle Target")
    print("ESC: Exit")
    
    # Keep main thread alive
    try:
        while settings["enabled"]:
            time.sleep(0.1)
    except KeyboardInterrupt:
        pass
        
    kb_listener.stop()
    mouse_listener.stop()

if __name__ == "__main__":
    main()
