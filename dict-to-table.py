import glob
from pathlib import Path
import json

json_sql_mappings = {
    "<class 'int'>": "numeric",
    "<class 'bool'>": "bool",
    "<class 'str'>": "text",
    "<class 'list'>": "<type>[]",
    "pk_bigint": "bigint primary key",
    "fk_bigint": "bigint references event(idx) ON DELETE CASCADE NOT NULL"
}


def json_to_sql(content, name):
    sql = "CREATE TABLE {}(\n".format(name)

    for key, value in content.items():
        sql = sql + "\t{} {},\n".format(key, json_sql_mappings[value])

    sql = sql + ");\n"

    return sql


def main():
    files = glob.glob("./*.json")

    with open("auto_schema.sql", "w") as output:

        for file in files:
            base_name = file.split("/")[-1].split(".")[0]
            content = json.load(open(file, "r"))

            # Add index column
            if base_name == 'event':
                content["idx"] = "pk_bigint"
            else:
                content["idx"] = "fk_bigint"
            sql = json_to_sql(content, base_name)

            output.write(sql + "\n\n")


if __name__ == '__main__':
    main()