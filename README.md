# conformity-tf-scan-action-bash

A sample bash file to scan terraform templates with the Trend Micro Cloud One Conformity Terraform template scanner.

## Pre-reqs:

This solution requires jq for parsing the results returned from the conformity API, see https://stedolan.github.io/jq/download/ for installation steps for your platform.

## Install:

- Clone this repo: https://github.com/TomRyan-321/conformity-tf-scan-action-bash
- Open the scan.sh with your favourite editor and modify the first 3 variables as required: `apikey`, `conformityregion` and `AWS_DEFAULT_REGION` (latter only required when terraform templates do not specify target region for a resource). Save the file.
- Make the file executable: `chmod +x scan.sh`
- Create an alias to the scan file eg: `alias tfscan=/path/to/scan.sh`
- Navigate to a folder containing terraform files and call your alias eg `tfscan` you will get results returned in a table format highlighting all the failure checks for this terraform project. 
- Consider creating a permanent alias by adding to your bashrc file eg. `echo "alias tfscan='/path/to/scan.sh'" >> ~/.bashrc`