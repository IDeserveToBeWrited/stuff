import os
import re

directory_path = r"C:\Users\doode\Documents\Euro Truck Simulator 2\mod\user_map\map\europka"
output_file_path = "output_results.txt"

# Updated regex pattern with re.MULTILINE and lazy quantifiers
pattern = re.compile(
    r'u32\s+item_type:\s*3(?:\n.+?)+?u64\s+uid:\s+x([^\s]+)(?:\n.+?)+?u32\s+flags:\s*(\d+)\n',
    re.MULTILINE
)

def check_and_extract_values(file_path):
    results = []
    count = 0
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        data = file.read()
        matches = pattern.findall(data)
        for match in matches:
            uid_hex, flags = map(str.strip, match)

            # Convert hexadecimal uid to decimal
            uid_decimal = int(uid_hex, 16)

            # Check if the 16th bit is set in the binary representation of flags
            if (int(flags) >> 15) & 1:
                results.append(f"File: {file_path}, UID (decimal): {uid_decimal}, Flags: {flags}")
                count += 1

    return results, count

def write_uids_to_file(uids):
    with open(output_file_path, 'w') as output_file:
        for uid in uids:
            output_file.write(f"{uid}\n")

def process_directory(directory_path):
    uids = []
    total_count = 0
    for filename in os.listdir(directory_path):
        if filename.endswith(".base"):
            file_path = os.path.join(directory_path, filename)
            results, count = check_and_extract_values(file_path)
            total_count += count
            for result in results:
                print(result)
                uid_decimal = result.split(": ")[2].split(",")[0].strip()  # Extract UID and append to the list
                uids.append(uid_decimal)

    print(f"Total results: {total_count}")
    
    # Write UIDs to the file
    write_uids_to_file(uids)

# Process the directory
process_directory(directory_path)
