import csv
import matplotlib.pyplot as plt


def readDataIntoDict(file):
    results_dict = {}
    with open(file, newline='') as f:
        headers = csv.reader(f).__next__()
        n_headers = len(headers)
        reader = csv.DictReader(f, fieldnames=headers[:n_headers - 1])

        n_threads = 1
        while n_threads < 24:
            test_tuples = []
            # Read as many tuples as there were threads involved
            for result_index in range(n_threads):
                test_tuples.append(reader.__next__())

            results_dict[n_threads] = test_tuples

            # Increment number of threads
            n_threads = n_threads + 1
            # Skip repeated header row
            reader.__next__()

    return results_dict


def get_axis_vals_for_all_columns(data):
    columns = list(data[1][0].keys())
    columns = columns[1:]
    # Remove threadid column
    return {column_name: get_axis_vals_for_column(data, column_name)
            for column_name in columns}


def get_axis_vals_for_column(data, column_name):
    xs = []
    ys = []
    for num_threads, data in data.items():
        xs.extend([num_threads] * len(data))
        ys.extend([entry[column_name] for entry in data])

    return xs, ys


# X Axis - nThreads
# Y Axis - Each column

lockfree_results_file = "results/lockfree.csv"
locking_results_file = "results/locking.csv"
locking_backoff_results_file = "results/locking_backoff.csv"

lockfree_data = readDataIntoDict(lockfree_results_file)
locking_data = readDataIntoDict(locking_results_file)
backoff_data = readDataIntoDict(locking_backoff_results_file)

lockfree_data = get_axis_vals_for_all_columns(lockfree_data)
locking_data = get_axis_vals_for_all_columns(locking_data)
backoff_data = get_axis_vals_for_all_columns(backoff_data)

for column, values in lockfree_data.items():
    scatter = plt.scatter(values[0], values[1])
    scatter.settitle(column)
    plt.show()
