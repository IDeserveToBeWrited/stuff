import os
import re

def read_flags_from_base_file(file_path):
    with open(file_path, 'rb') as file:
        data = file.read()

        # Define the regex pattern with comments to explain each part
        pattern = re.compile(
            r'\{\n.+?u32 item_type: 3(?:\n.+)+?u32 flags: (.+?)',
            re.MULTILINE | re.DOTALL | re.UNICODE
        )
        
        match = pattern.search(data)
        if match:
            flags_value = match.group(1).strip()
            print(f"Flags value when item_type is 3: {flags_value}")
        else:
            print("No match found.")

def process_directory(directory_path):
    for filename in os.listdir(directory_path):
        if filename.endswith(".base"):
            file_path = os.path.join(directory_path, filename)
            flags = read_flags_from_base_file(file_path)
            if flags is not None:
                print(f"File: {filename}, Flags for item_type: 3: {flags}")

if __name__ == "__main__":
    directory_path = "C:\\Users\\doode\\Documents\\Euro Truck Simulator 2\\mod\\user_map\\map\\europka"  # Replace with the actual directory path
    process_directory(directory_path)
