#!/bin/bash

echo "Enter absolute .pem file path: "
read  pemFilePath
echo "Enter absolute Validator Key zip file path: "
read  zipFilePath
echo "echo username associated with key[eg:ubuntu OR root OR any other custom name] "
read  username
echo "Enter public IPv4 and external DNS hostname: "
read  endpoint

chmod 0400 "$pemFilePath"


scp -i "$pemFilePath" -r "$zipFilePath" "$username"@"$endpoint":/home/"$username/validator_keys.zip"

ssh -i "$pemFilePath" "$username"@"$endpoint"