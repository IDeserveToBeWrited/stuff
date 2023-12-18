import os
import re

# Define the directory path where the .base files are located
directory_path = r"C:\Users\doode\Documents\Euro Truck Simulator 2\mod\user_map\map\europka"

# Define output file paths for different item types
output_file_path_type_3 = "output_results_type_3.txt"
output_file_path_type_4 = "output_results_type_4.txt"
output_file_path_type_6 = "output_results_type_6.txt"
output_file_path_type_7 = "output_results_type_7.txt"

# Define combined output file path
combined_output_file_path = "combined_output_results.txt"

# Define the regex pattern for extracting information from the .base files
pattern = re.compile(
    r'u32\s+item_type:\s*([3467])(?:\n.+?)+?u64\s+uid:\s+x([^\s]+)(?:\n.+?)+?u32\s+flags:\s*(\d+)\n',
    re.MULTILINE
)

def check_and_extract_type(file_path, item_type):
    """
    Check and extract information from a .base file for a specific item type.

    Args:
        file_path (str): The path to the .base file.
        item_type (str): The item type to check for.

    Returns:
        tuple: A tuple containing a list of results and the count of occurrences.
    """
    results = []
    count = 0
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        data = file.read()
        matches = pattern.findall(data)
        for match in matches:
            current_item_type, uid_hex, flags = map(str.strip, match)

            # Convert hexadecimal uid to decimal
            uid_decimal = int(uid_hex, 16)

            # Check conditions for the specified item type
            if current_item_type == item_type:
                results.append(f"File: {file_path}, UID (decimal): {uid_decimal}, Flags: {flags}")
                count += 1

    return results, count

def write_uids_to_file(uids, output_file_path):
    """
    Write a list of UIDs to a file.

    Args:
        uids (list): List of UIDs to write.
        output_file_path (str): The path to the output file.
    """
    with open(output_file_path, 'w') as output_file:
        for uid in uids:
            output_file.write(f"{uid}\n")

def combine_and_prefix_files(file_paths, combined_output_file_path):
    """
    Combine multiple files, prefix each line with an index, and add a line at the top with the total number of items.

    Args:
        file_paths (list): List of file paths to combine.
        combined_output_file_path (str): The path to the combined output file.
    """
    index = 0
    total_items = 0

    # Truncate the file to make sure it's empty
    with open(combined_output_file_path, 'w'):
        pass

    with open(combined_output_file_path, 'a') as combined_output_file:
        for file_path in file_paths:
            with open(file_path, 'r') as input_file:
                for line in input_file:
                    # Prefix each line with an index
                    combined_output_file.write(f"discovered_items[{index}]: {line}")
                    index += 1

    # Calculate the total number of items
    total_items = index

    # Insert a line at the top with the total number of items
    with open(combined_output_file_path, 'r+') as combined_output_file:
        content = combined_output_file.read()
        combined_output_file.seek(0, 0)
        combined_output_file.write(f"discovered_items: {total_items}\n" + content)


def process_directory(directory_path):
    """
    Process all .base files in a directory.

    Args:
        directory_path (str): The path to the directory.
    """
    uids_type_3 = []
    uids_type_4 = []
    uids_type_6 = []
    uids_type_7 = []
    total_count_type_3 = 0
    total_count_type_4 = 0
    total_count_type_6 = 0
    total_count_type_7 = 0

    for filename in os.listdir(directory_path):
        if filename.endswith(".base"):
            file_path = os.path.join(directory_path, filename)

            # Check and extract for type 3
            results_type_3, count_type_3 = check_and_extract_type(file_path, '3')
            total_count_type_3 += count_type_3
            for result in results_type_3:
                print(result)
                uid_decimal = result.split(": ")[2].split(",")[0].strip()  # Extract UID and append to the list
                uids_type_3.append(uid_decimal)

            # Check and extract for type 4
            results_type_4, count_type_4 = check_and_extract_type(file_path, '4')
            total_count_type_4 += count_type_4
            for result in results_type_4:
                print(result)
                uid_decimal = result.split(": ")[2].split(",")[0].strip()  # Extract UID and append to the list
                uids_type_4.append(uid_decimal)

            # Check and extract for type 6
            results_type_6, count_type_6 = check_and_extract_type(file_path, '6')
            total_count_type_6 += count_type_6
            for result in results_type_6:
                print(result)
                uid_decimal = result.split(": ")[2].split(",")[0].strip()  # Extract UID and append to the list
                uids_type_6.append(uid_decimal)

            # Check and extract for type 7
            results_type_7, count_type_7 = check_and_extract_type(file_path, '7')
            total_count_type_7 += count_type_7
            for result in results_type_7:
                print(result)
                uid_decimal = result.split(": ")[2].split(",")[0].strip()  # Extract UID and append to the list
                uids_type_7.append(uid_decimal)

    print(f"Total results (Type 3): {total_count_type_3}")
    print(f"Total results (Type 4): {total_count_type_4}")
    print(f"Total results (Type 6): {total_count_type_6}")
    print(f"Total results (Type 7): {total_count_type_7}")

    # Write UIDs to the respective files
    write_uids_to_file(uids_type_3, output_file_path_type_3)
    write_uids_to_file(uids_type_4, output_file_path_type_4)
    write_uids_to_file(uids_type_6, output_file_path_type_6)
    write_uids_to_file(uids_type_7, output_file_path_type_7)

    # Combine and prefix files
    combine_and_prefix_files([output_file_path_type_3, output_file_path_type_4, output_file_path_type_6, output_file_path_type_7], combined_output_file_path)

# Process the directory
process_directory(directory_path)
