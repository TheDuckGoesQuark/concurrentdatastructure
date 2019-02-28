import csv
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm


def refactor_row(headers, row):
    for header in headers:
        if "Wait Time" in header:
            row[header] = row[header] * (10 ** 6)

    return row


def refactor_column_name(column_name):
    return column_name.replace("(s)", "(μs)")


def readDataIntoDict(file):
    results_dict = {}
    with open(file, newline='') as f:
        headers = csv.reader(f).__next__()
        n_headers = len(headers)
        reader = csv.DictReader(f, fieldnames=headers[:n_headers - 1], quoting=csv.QUOTE_NONNUMERIC)

        n_threads = 1
        while n_threads < 24:
            test_tuples = []
            # Read as many tuples as there were threads involved
            for result_index in range(n_threads):
                test_tuples.append(refactor_row(headers, reader.__next__()))

            results_dict[n_threads] = test_tuples

            # Increment number of threads
            n_threads = n_threads + 1
            # Skip repeated header row
            try:
                reader.__next__()
            except ValueError:
                # Occurs when parsing header fields
                pass

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


def plot_and_save_columns(data, lockname):
    for column, values in data.items():
        column = refactor_column_name(column)
        plt.figure()
        plt.scatter(values[0], values[1])
        plt.title("{} against increasing number of threads".format(column))
        plt.xlabel("Number of Threads")
        plt.ylabel(column)
        plt.savefig("graphs/{}/{}.png".format(lockname, column.replace(" ", "_")))
        plt.show()


def plot_and_save_comparisons_of_methods(method_datas, method_names):
    columns = method_datas[0].keys()
    for column in columns:
        plt.figure()
        colours = cm.rainbow(np.linspace(0, 1, len(method_names)))
        for data, colour, method_name in zip(method_datas, colours, method_names):
            axis = data[column]
            plt.scatter(axis[0], axis[1], color=colour, label=method_name, alpha=0.4)
            plt.legend()

        column = refactor_column_name(column)
        plt.title("{} against increasing number of threads".format(column))
        plt.xlabel("Number of Threads")
        plt.ylabel(column)
        plt.savefig("graphs/merged/{}.png".format(column.replace(" ", "_")))
        plt.show()


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

# plot_and_save_columns(lockfree_data, "lockfree")
# plot_and_save_columns(locking_data, "locking")
# plot_and_save_columns(backoff_data, "backoff")

plot_and_save_comparisons_of_methods([lockfree_data, locking_data, backoff_data], ["lockfree", "locking", "backoff"])
