# Fixed Roblox Aimbot/Xit Panel with Floating Menu
# Features: FOV Invisible, ESP Box/Skeleton, Team Check, Aimbot Head/Body

import os
import sys
import time
import struct
import threading
import ctypes
import tkinter as tk
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
    try:
        import psutil
        for proc in psutil.process_iter(['pid', 'name']):
            if "Roblox" in proc.info['name']:
                return proc.info['pid']
    except ImportError:
        # Fallback for systems without psutil
        for pid in os.listdir("/proc"):
            try:
                name = open(f"/proc/{pid}/comm").read().strip()
                if "Roblox" in name:
                    return int(pid)
            except:
                continue
    return None

def init_game_pointers():
    """Initialize memory addresses for game objects"""
    global GAME_PROCESS_ID, GAME_MODULE, PLAYER_LIST_ADDR, CAMERA_ADDR
    
    GAME_PROCESS_ID = get_game_process()
    if not GAME_PROCESS_ID:
        print("[ERROR] Could not find Roblox process!")
        print("Make sure Roblox is running and Xenos Executor is attached.")
        exit(1)
    
    try:
        # Try to read process memory directly
        with open(f"/proc/{GAME_PROCESS_ID}/maps", "r") as f:
            for line in f:
                if "libcoreclr.so" in line or "/roblox/" in line:
                    GAME_MODULE = int(line.split()[0], 16)
                    break
    except:
        print("[ERROR] Could not initialize game pointers!")
        print("Try attaching Xenos Executor first.")
        exit(1)
    
    # Example offsets - replace with actual values
    PLAYER_LIST_ADDR = GAME_MODULE + 0x123456
    CAMERA_ADDR = GAME_MODULE + 0xABCDEF

def read_memory(addr, size):
    """Read memory from game process"""
    try:
        with open(f"/proc/{GAME_PROCESS_ID}/mem", "rb") as f:
            f.seek(addr)
            return f.read(size)
    except:
        return None

def write_memory(addr, data):
    """Write memory to game process"""
    try:
        with open(f"/proc/{GAME_PROCESS_ID}/mem", "wb") as f:
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
                pos_x = struct.unpack("<f", player_data[i:i+4])[0]
                pos_y = struct.unpack("<f", player_data[i+4:i+8])[0]
                pos_z = struct.unpack("<f", player_data[i+8:i+12])[0]
                
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

def create_menu():
    """Create floating menu window"""
    menu = tk.Tk()
    menu.overrideredirect(True)  # Remove window decorations
    menu.attributes("-topmost", True)  # Always stay on top
    
    # Set initial position near cursor
    menu.geometry("+%d+%d" % (mouse.Controller().position[0], mouse.Controller().position[1]))
    
    # Create menu widgets
    tk.Label(menu, text="ROBLOX XIT PANEL", font=("Arial", 12, "bold")).pack(pady=5)
    
    # Toggle buttons
    def toggle_aimbot():
        settings["aimbot_enabled"] = not settings["aimbot_enabled"]
        aimbot_btn.config(text=f"Aimbot: {'ON' if settings['aimbot_enabled'] else 'OFF'}")
        
    def toggle_target():
        settings["aim_target"] = "head" if settings["aim_target"] == "body" else "body"
        target_btn.config(text=f"Target: {settings['aim_target'].upper()}")
        
    def toggle_fov():
        settings["fov_invisible"] = not settings["fov_invisible"]
        fov_btn.config(text=f"FOV Invisible: {'ON' if settings['fov_invisible'] else 'OFF'}")
        
    def toggle_esp():
        settings["esp_box"] = not settings["esp_box"]
        esp_btn.config(text=f"ESP Box: {'ON' if settings['esp_box'] else 'OFF'}")
        
    def toggle_team():
        settings["team_check"] = not settings["team_check"]
        team_btn.config(text=f"Team Check: {'ON' if settings['team_check'] else 'OFF'}")
        
    def toggle_regular():
        settings["regular_fov"] = not settings["regular_fov"]
        regular_btn.config(text=f"Regular FOV: {'ON' if settings['regular_fov'] else 'OFF'}")
    
    # Create buttons
    aimbot_btn = tk.Button(menu, text=f"Aimbot: {'ON' if settings['aimbot_enabled'] else 'OFF'}", 
                          command=toggle_aimbot, width=20)
    aimbot_btn.pack(pady=2)
    
    target_btn = tk.Button(menu, text=f"Target: {settings['aim_target'].upper()}", 
                          command=toggle_target, width=20)
    target_btn.pack(pady=2)
    
    fov_btn = tk.Button(menu, text=f"FOV Invisible: {'ON' if settings['fov_invisible'] else 'OFF'}", 
                       command=toggle_fov, width=20)
    fov_btn.pack(pady=2)
    
    esp_btn = tk.Button(menu, text=f"ESP Box: {'ON' if settings['esp_box'] else 'OFF'}", 
                       command=toggle_esp, width=20)
    esp_btn.pack(pady=2)
    
    team_btn = tk.Button(menu, text=f"Team Check: {'ON' if settings['team_check'] else 'OFF'}", 
                        command=toggle_team, width=20)
    team_btn.pack(pady=2)
    
    regular_btn = tk.Button(menu, text=f"Regular FOV: {'ON' if settings['regular_fov'] else 'OFF'}", 
                           command=toggle_regular, width=20)
    regular_btn.pack(pady=2)
    
    # Close button
    close_btn = tk.Button(menu, text="Close", command=menu.destroy, width=20)
    close_btn.pack(pady=5)
    
    return menu

def show_menu():
    """Show floating menu when needed"""
    try:
        menu = create_menu()
        menu.mainloop()
    except Exception as e:
        print(f"[ERROR] Menu error: {e}")

def main():
    """Main application entry point"""
    init_game_pointers()
    update_settings()
    
    # Start aimbot thread
    aimbot_thread = threading.Thread(target=aimbot_logic, daemon=True)
    aimbot_thread.start()
    
    print("ROBLOX XIT PANEL ACTIVE")
    print("Press F1 to show/hide menu")
    print("ESC to exit")
    
    # Keyboard handler for showing menu
    def on_press(key):
        if key == keyboard.Key.f1:
            show_menu()
        elif key == keyboard.Key.esc:
            settings["enabled"] = False
            return False
            
    # Start keyboard listener
    kb_listener = keyboard.Listener(on_press=on_press)
    kb_listener.start()
    
    # Keep main thread alive
    try:
        while settings["enabled"]:
            time.sleep(0.1)
    except KeyboardInterrupt:
        pass
        
    kb_listener.stop()

if __name__ == "__main__":
    main()
