import os
import re

def process_item_type(directory_path, item_type, output_file_path):
    pattern = re.compile(
        rf'u32\s+item_type:\s*({item_type})(?:\n.+?)+?u64\s+uid:\s+x([^\s]+)(?:\n.+?)+?u32\s+flags:\s*(\d+)\n',
        re.MULTILINE
    )

    results = []
    total_count = 0

    for filename in os.listdir(directory_path):
        if filename.endswith(".base"):
            file_path = os.path.join(directory_path, filename)
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
                data = file.read()
                matches = pattern.findall(data)
                for match in matches:
                    current_item_type, uid_hex, flags = map(str.strip, match)
                    uid_decimal = int(uid_hex, 16)

                    if current_item_type == item_type:
                        results.append(uid_decimal)
                        total_count += 1

    write_uids_to_file(results, output_file_path)
    print(f"Total results (Type {item_type}): {total_count}")

def write_uids_to_file(uids, output_file_path):
    with open(output_file_path, 'w') as output_file:
        for uid in uids:
            output_file.write(f"{uid}\n")

def combine_and_prefix_files(file_paths, combined_output_file_path):
    index = 0
    total_items = 0

    with open(combined_output_file_path, 'w') as combined_output_file:
        for file_path in file_paths:
            with open(file_path, 'r') as input_file:
                for line in input_file:
                    # Prefix each line with an index
                    combined_output_file.write(f"discovered_items[{index}]: {line}")
                    index += 1

    total_items = index

    with open(combined_output_file_path, 'r+') as combined_output_file:
        content = combined_output_file.read()
        combined_output_file.seek(0, 0)
        combined_output_file.write(f"discovered_items: {total_items}\n" + content)

def process_directory(directory_path):
    process_item_type(directory_path, '3', 'output_results_type_3.txt')
    process_item_type(directory_path, '4', 'output_results_type_4.txt')
    process_item_type(directory_path, '6', 'output_results_type_6.txt')
    process_item_type(directory_path, '7', 'output_results_type_7.txt')
    process_item_type(directory_path, '18', 'output_results_type_18.txt')
    process_item_type(directory_path, '42', 'output_results_type_42.txt')

    combine_and_prefix_files(['output_results_type_3.txt', 'output_results_type_4.txt', 'output_results_type_6.txt', 'output_results_type_7.txt', 'output_results_type_18.txt', 'output_results_type_42.txt'], 'combined_output_results.txt')

# Process the directory
process_directory(r"C:\Users\doode\Documents\Euro Truck Simulator 2\mod\user_map\map\primorsk")
