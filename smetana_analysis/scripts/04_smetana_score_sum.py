import os

def calculate_smetana_sum(file_path):
    smetana_sum = 0
    with open(file_path, 'r') as file:
        # Skip header
        next(file)
        for line in file:
            values = line.strip().split('\t')
            smetana_value = float(values[-1])
            smetana_sum += smetana_value
    return smetana_sum

def main():
    output_file = 'smetana_sum.txt'
    with open(output_file, 'w') as f_out:
        f_out.write("File\tSmetana Sum\n")
        for filename in os.listdir():
            if filename.endswith("_detailed.tsv"):
                smetana_sum = calculate_smetana_sum(filename)
                f_out.write(f"{filename}\t{smetana_sum}\n")

if __name__ == "__main__":
    main()
