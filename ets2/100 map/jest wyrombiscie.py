import os
import re

directory_path = r"C:\Users\doode\Documents\Euro Truck Simulator 2\mod\user_map\map\europka"
output_file_path_type_3 = "output_results_type_3.txt"
output_file_path_type_4_bit_5_set = "output_results_type_4_bit_5_set.txt"

# Updated regex pattern with re.MULTILINE and lazy quantifiers
pattern = re.compile(
    r'u32\s+item_type:\s*([34])(?:\n.+?)+?u64\s+uid:\s+x([^\s]+)(?:\n.+?)+?u32\s+flags:\s*(\d+)\n',
    re.MULTILINE
)

def check_and_extract_type_3(file_path):
    results = []
    count = 0
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        data = file.read()
        matches = pattern.findall(data)
        for match in matches:
            item_type, uid_hex, flags = map(str.strip, match)

            # Convert hexadecimal uid to decimal
            uid_decimal = int(uid_hex, 16)

            # Check conditions for type 3
            if item_type == '3' and (int(flags) >> 15) & 1:
                results.append(f"File: {file_path}, UID (decimal): {uid_decimal}, Flags: {flags}")
                count += 1

    return results, count

def check_and_extract_type_4_bit_5_set(file_path):
    results = []
    count = 0
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        data = file.read()
        matches = pattern.findall(data)
        for match in matches:
            item_type, uid_hex, flags = map(str.strip, match)

            # Convert hexadecimal uid to decimal
            uid_decimal = int(uid_hex, 16)

            # Check conditions for type 4 and 5th bit set
            if item_type == '4' and (int(flags) >> 4) & 1:
                results.append(f"File: {file_path}, UID (decimal): {uid_decimal}, Flags: {flags}")
                count += 1

    return results, count

def write_uids_to_file(uids, output_file_path):
    with open(output_file_path, 'w') as output_file:
        for uid in uids:
            output_file.write(f"{uid}\n")

def process_directory(directory_path):
    uids_type_3 = []
    uids_type_4_bit_5_set = []
    total_count_type_3 = 0
    total_count_type_4_bit_5_set = 0

    for filename in os.listdir(directory_path):
        if filename.endswith(".base"):
            file_path = os.path.join(directory_path, filename)

            # Check and extract for type 3
            results_type_3, count_type_3 = check_and_extract_type_3(file_path)
            total_count_type_3 += count_type_3
            for result in results_type_3:
                print(result)
                uid_decimal = result.split(": ")[2].split(",")[0].strip()  # Extract UID and append to the list
                uids_type_3.append(uid_decimal)

            # Check and extract for type 4 and 5th bit set
            results_type_4_bit_5_set, count_type_4_bit_5_set = check_and_extract_type_4_bit_5_set(file_path)
            total_count_type_4_bit_5_set += count_type_4_bit_5_set
            for result in results_type_4_bit_5_set:
                print(result)
                uid_decimal = result.split(": ")[2].split(",")[0].strip()  # Extract UID and append to the list
                uids_type_4_bit_5_set.append(uid_decimal)

    print(f"Total results (Type 3): {total_count_type_3}")
    print(f"Total results (Type 4, 5th bit set): {total_count_type_4_bit_5_set}")

    # Write UIDs to the respective files
    write_uids_to_file(uids_type_3, output_file_path_type_3)
    write_uids_to_file(uids_type_4_bit_5_set, output_file_path_type_4_bit_5_set)

# Process the directory
process_directory(directory_path)
