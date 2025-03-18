"""
Perform dataset manipulations
"""

import json

from datasets import load_dataset
from tqdm import tqdm


def split_dataset_to_tasks(do_stream=False):
    t0_submixture = load_dataset(
        "DataProvenanceInitiative/t0_submix_original", streaming=do_stream
    )

    def task_split_for(split_name="train"):
        t0_split = t0_submixture[split_name]

        data = {}

        def process_example(example):
            s_input = example["inputs"]
            target = example["targets"]
            task_name = example["task_name"]
            if task_name not in data:
                data[task_name] = []

            data[task_name].append({"inputs": s_input, "targets": target})

        print("Task-wise splitting started")
        if do_stream:
            for example in t0_split:
                process_example(example)
        else:
            for i in tqdm(range(len(t0_split))):
                process_example(t0_split[i])

        for task in data.keys():
            with open(f"data/t0/t0-task-{task}.json", "w") as jobj:
                json.dump(data[task], jobj)

    task_split_for("train")


split_dataset_to_tasks()
