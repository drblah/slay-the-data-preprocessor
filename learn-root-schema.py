import json
import glob
import pprint
import csv
from tqdm import tqdm
import deepdiff
import random
from multiprocessing import Pool, Queue


def split_list(list, list_size):
    return [list[i:i + list_size] for i in range(0, len(list), list_size)]


def contains_dict(item):
    if len(item) > 0:
        types = [type(value) for value in item]

        if dict in types:
            return True

    return False


def unroll_subschema(item):
    schema = dict()

    for sub_item in item:
        if sub_item is None:
            continue
        for field, value in sub_item.items():
            schema[field] = str(type(value))

    return schema


def process_files(files):
    top_schema = dict()
    sub_schema = dict()

    for idx, file in enumerate(files):
        file_content = json.load(open(file, "r"))
        for event in file_content:
            for field, value in event["event"].items():
                if isinstance(value, list):
                    if contains_dict(value):
                        sub_schema[field] = unroll_subschema(value)
                else:
                    top_schema[field] = str(type(value))

        if idx % 10 == 0:
            print("Processed {} files out of {}".format(idx, len(files)))

    return {"root": top_schema, "sub": sub_schema}


def main():
    files = glob.glob("/media/extracted/*.json")
    random.shuffle(files)
    pp = pprint.PrettyPrinter()

    split = split_list(files, int(round(len(files)/8)))

    with Pool(processes=8) as pool:
        root_results = pool.map(process_files, split)

        print(root_results)
        merged_root = dict()
        merged_subs = dict()

        for r in root_results:
            merged_root = {**merged_root, **r["root"]}

        json.dump(merged_root, open("merged.txt", "w"))

        for sub_result in root_results:
            for key, value in sub_result["sub"].items():
                if key in merged_subs:
                    merged_subs[key] = {**merged_subs[key], **value}
                else:
                    merged_subs[key] = value

        for key, value in merged_subs.items():
            json.dump(value, open("merged_{}.txt".format(key), "w"))


if __name__ == '__main__':
    main()
