import os
import itertools
import subprocess
import hashlib
import signal
import time

def run_smetana(command, timeout):
    try:
        start_time = time.time()
        process = subprocess.Popen(command, shell=True)
        while process.poll() is None:
            time.sleep(1)
            if time.time() - start_time > timeout:
                process.terminate()
                print("Process terminated due to timeout")
                return False
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e}")
        return False

def get_combination_name(files, excluded_file):
    remaining_files = [file for file in files if file != excluded_file]
    identifier = excluded_file.split('.')[0]
    return f"12mix-{identifier}_bigg"

def main():
    xml_files = [file for file in os.listdir() if file.endswith('.xml')]
    xml_combinations = list(itertools.combinations(xml_files, len(xml_files) - 1))

    # Task 1: Analyze all XML files together
    command_task1 = f"smetana {' '.join(xml_files)} -o 12mix_bigg --flavor bigg --solver cplex --molweight"
    run_smetana(command_task1, timeout=3600)  # 1 hour timeout for Task 1

    # Task 2: Analyze combinations of XML files
    for combination in xml_combinations:
        for excluded_file in xml_files:
            if excluded_file not in combination:
                output_name = get_combination_name(combination, excluded_file)
                command_task2 = f"smetana {' '.join(combination)} -o {output_name} --flavor bigg --solver cplex --molweight"
                if not run_smetana(command_task2, timeout=3600):  # 1 hour timeout for each combination
                    break

if __name__ == "__main__":
    main()
