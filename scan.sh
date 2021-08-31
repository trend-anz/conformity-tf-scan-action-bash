#!/bin/bash
export AWS_DEFAULT_REGION=us-east-1                                       #Needed if region not defined within terraform file
apikey="" #Conformity API Key
conformityregion="us-west-2"                                              #Conformity region

mkdir -p ./tf-scan-temp
terraform init >/dev/null
terraform plan -out ./tf-scan-temp/outfile >/dev/null
contents=$(terraform show -json ./tf-scan-temp/outfile | jq '.' -MRs)
payload="{\"data\":{\"attributes\":{\"type\":\"terraform-template\",\"contents\":${contents}}}}"

curl -s -X POST \
     -H "Authorization: ApiKey ${apikey}" \
     -H "Content-Type: application/vnd.api+json" \
     https://${conformityregion}-api.cloudconformity.com/v1/template-scanner/scan \
     --data-binary "${payload}" | jq -r '.data[] | select (.attributes.status == "FAILURE") | [.attributes.resource, .attributes."risk-level", .attributes.message] | @tsv' | sort -k1

rm -rf ./tf-scan-temp
