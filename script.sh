#!/bin/bash

curl 169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI | jq 'to_entries | [ .[] | select(.key | (contains("Expiration") or contains("RoleArn"))  | not) ] |  map(if .key == "AccessKeyId" then . + {"key":"AWS_ACCESS_KEY_ID"} else . end) | map(if .key == "SecretAccessKey" then . + {"key":"AWS_SECRET_ACCESS_KEY"} else . end) | map(if .key == "Token" then . + {"key":"AWS_SESSION_TOKEN"} else . end) | map("export \(.key)=\(.value)") | .[]' -r > /tmp/aws_cred_export.txt
. /tmp/aws_cred_export.txt
terraform init
terraform plan
terraform apply
