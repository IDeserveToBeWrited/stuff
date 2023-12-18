import os
import re

directory_path = r"C:\Users\doode\Documents\Euro Truck Simulator 2\mod\user_map\map\europka"
ile = 0
# Updated regex pattern with re.MULTILINE and lazy quantifiers
pattern = re.compile(
    r'u32\s+item_type:\s*3(?:\n.+?)+?u64\s+uid:\s+x([^\s]+)(?:\n.+?)+?u32\s+flags:\s*(\d+)\n',
    re.MULTILINE
)

def check_and_extract_values(file_path):
    results = []
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        data = file.read()
        matches = pattern.findall(data)
        for match in matches:
            uid_hex, flags = map(str.strip, match)

            # Convert hexadecimal uid to decimal
            uid_decimal = int(uid_hex, 16)
            global ile
            ile = ile + 1
            results.append(f"File: {file_path}, UID (decimal): {uid_decimal}, Flags: {flags}")

    return results

def process_directory(directory_path):
    for filename in os.listdir(directory_path):
        if filename.endswith(".base"):
            file_path = os.path.join(directory_path, filename)
            results = check_and_extract_values(file_path)
            for result in results:
                print(result)

# Process the directory
process_directory(directory_path)
print(ile)
