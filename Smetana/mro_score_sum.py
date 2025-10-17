import os

def extract_mro_value(file_path):
    with open(file_path, 'r') as file:
        for line in file:
            pass  # Skip to the last line
        # Extract mro value from the last line
        mro_value = line.strip().split('\t')[-1]
    return mro_value

def main():
    output_file = 'mro_values.txt'
    with open(output_file, 'w') as f_out:
        f_out.write("File\tMRO Value\n")
        for filename in os.listdir():
            if filename.endswith("_global.tsv"):
                mro_value = extract_mro_value(filename)
                f_out.write(f"{filename}\t{mro_value}\n")

if __name__ == "__main__":
    main()
