import json
import glob
import csv
from tqdm import tqdm
from pathlib import Path
import random


class IDGenerator:
    def __init__(self):
        self.id_number = 0

    def get_next(self):
        next_id = self.id_number
        self.id_number = self.id_number + 1

        return next_id


class Writer:
    def __init__(self, name, schema):
        fieldnames = []

        if name == "event":
            fieldnames = [key for key, _ in schema.items()]
        elif name in schema:
            if isinstance(schema[name], dict):
                fieldnames = [key for key, _ in schema[name].items()]
                fieldnames.append("idx")
            else:
                fieldnames = [key for key, _ in schema.items()]
        else:
            fieldnames = [key for key, _ in schema.items()]
        self.csvfile = open("/home/drblah/sts-normalized/{}.csv".format(name), "w")
        self.dictwriter = csv.DictWriter(self.csvfile, fieldnames=fieldnames)

        self.dictwriter.writeheader()

    def add_row(self, row):
        try:
            for key, value in row.items():
                # Convert list objects to strings for better compatibility with Postgres
                if isinstance(value, list):
                    list_as_string = '{' + ",".join(item for item in value) + "}"
                    row[key] = list_as_string

            self.dictwriter.writerow(row)
        except UnicodeEncodeError as e:
            print("Error saving row: {}".format(e))
            print("Skipping...")
        except ValueError as e:
            print("Encountered {}".format(e))
            print(row)

    def add_rows(self, rows):
        self.dictwriter.writerows(rows)


def process_item(name, item, csv_writers, idx):

    sub_items = dict()
    item_values = dict()

    item["idx"] = idx

    # Split item into values and sub_items
    for field, value in item.items():
        if isinstance(value, list):
            sub_items[field] = value
        else:
            item_values[field] = value

    csv_writers[name].add_row(item_values)

    for field, value in sub_items.items():
        if field in csv_writers:
            for v in value:
                if isinstance(v, dict):
                    v["idx"] = idx
                    csv_writers[field].add_row(v)
                else:
                    csv_writers[field].add_row({field: v, "idx": idx})
        else:
            csv_writers[field] = Writer(field, {field: value, "idx": None})
            for v in value:
                csv_writers[field].add_row({field: v, "idx": idx})


def main():
    files = glob.glob("/media/extracted/*.json")
    #random.shuffle(files)
    #root_schema = json.load(open("root-schema.json", "r"))

    schemas = glob.glob("./*.json")

    csv_writers = dict()

    idgen = IDGenerator()

    for s in schemas:
        key = Path(s).name.split(".")[0]
        schema = json.load(open(s, "r"))
        schema["idx"] = None
        csv_writers[key] = Writer(key, schema)

    for file in tqdm(files):
        file_content = json.load(open(file, "r"))
        for event in file_content:
            process_item("event", event["event"], csv_writers, idgen.get_next())


if __name__ == '__main__':
    main()
