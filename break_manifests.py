#!/bin/python3
import sys
import yaml
import re
import os.path as path

def to_snake_case(name):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()

def write_file(manifest,chart_path):
    resource = yaml.safe_load(manifest)
    resource_name = resource["metadata"]["name"]
    resource_kind = to_snake_case(resource["kind"])
    if resource_kind == "custom_resource_definition":
        with open(path.join(chart_path,"crds",f"{resource_name}.yaml"), "w") as crd:
            crd.write(manifest)
    else:
        filename = "{}-{}".format(resource_name,resource_kind)
        with open(path.join(chart_path,"templates",f"{filename}.yaml") ,"w") as template:
            template.write(manifest)

def break_manifest(uber_manifest_path, chart_path):
    with open(uber_manifest_path,"r") as uber_manifest_file:
        all_manifests = uber_manifest_file.read().split("---\n")
    for m in all_manifests:
        if (len(m.strip())>0):
            write_file(m,chart_path)

def main():
    break_manifest(uber_manifest_path=sys.argv[1],chart_path=sys.argv[2])

if __name__ == "__main__":
   main()