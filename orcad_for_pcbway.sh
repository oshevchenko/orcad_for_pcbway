#!/bin/bash
# Exit on error
set -e
tmp_dir="/tmp/rename_layers_tmp"
rm -rf ${tmp_dir}
mkdir ${tmp_dir}
input_file_basename=""

#check if command line parameter is provided
if [ $# -eq 1 ]; then
    input_file="$1"
    input_file_basename=$(basename "${input_file}")
    cp "$input_file" ${tmp_dir}/input.zip
else
    # Take the first .zip file in the script directory that does not end with '_pcbway.zip'
    echo "No input file provided, searching for .zip file in the current directory!"
    # script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    for file in ./*.zip; do
        # check if file ends with '_pcbway.zip'
        if [[ $(basename "${file}") == *_pcbway.zip ]]; then
            continue
        fi
        # Get the file name without extension
        input_file_basename=$(basename "${file}")
        cp "${file}" ${tmp_dir}/input.zip
        break
    done
fi

# check if input_file_basename is empty
if [ -z "$input_file_basename" ]; then
    echo "No input file found!"
    exit 1
fi
project_name="${input_file_basename%.*}"
echo "Project name: $project_name"
zip_file="${project_name}_pcbway.zip"

pushd ${tmp_dir} || exit 1
unzip input.zip
rm input.zip

mv ./TOP.art ${project_name}.GTL
mv ./BOTTOM.art ${project_name}.GBL
zip ${zip_file} ${project_name}.GTL ${project_name}.GBL

mv ./SMTP.art ${project_name}.GTS
mv ./SMBT.art ${project_name}.GBS
zip ${zip_file} ${project_name}.GTS ${project_name}.GBS

mv ./SSTP.art ${project_name}.GTO
mv ./SSBT.art ${project_name}.GBO
zip ${zip_file} ${project_name}.GTO ${project_name}.GBO

mv ./SPTP.art ${project_name}.GTP
mv ./SPBT.art  ${project_name}.GBP
zip ${zip_file} ${project_name}.GTP ${project_name}.GBP

mv ./OUTLINE.art ${project_name}.GKO
zip ${zip_file} ${project_name}.GKO

# Rename .drl files to .DRD and then rename them with project name prefix
for file in ./*.drl; do
    mv ${file} "${file%.drl}.DRD"
done

#create a list of extensions to rename
extensions=("art" "txt" "DRD")
# Rename the rest of files with the extensions in the list
for ext in "${extensions[@]}"; do
    for file in ./*.${ext}; do
        filename=$(basename "${file}")
        filename=${project_name}_${filename}
        mv ${file} ${filename}
        # add file ${filename} to zip
        zip ${zip_file} ${filename}
    done
done
popd || exit 1
mv ${tmp_dir}/${zip_file} ./${zip_file}
rm -rf ${tmp_dir}
echo "Created ${zip_file} successfully!"
exit 0
