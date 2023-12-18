import os
import re

directory_path = r"C:\Users\doode\Documents\Euro Truck Simulator 2\mod\user_map\map\europka"

# Equivalent regex in Python
pattern = re.compile(
    r'(?s)struct\s+road_item\s*\{(?:(?!struct\s+road_item\s*\{|\}\s*\}).)+?u32\s+item_type:\s*3(?:(?!struct\s+road_item\s*\{|\}\s*\}).)+?u32\s+flags:\s*(.+?)\n'
)

def extract_flags_from_file(file_path):
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        data = file.read()
        match = pattern.search(data)
        if match:
            flags_value = match.group(1).strip()
            print(f"File: {file_path}, Flags value when item_type is 3: {flags_value}")
        else:
            print(f"File: {file_path}, No match found.")

def process_directory(directory_path):
    for filename in os.listdir(directory_path):
        if filename.endswith(".base"):
            file_path = os.path.join(directory_path, filename)
            extract_flags_from_file(file_path)

# Process the directory
process_directory(directory_path)
