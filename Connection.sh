#!/bin/bash

echo "Enter .pem file path: "
read  pemFilePath
echo "Enter Validator Key zip file path: "
read  zipFilePath
echo "Enter public IPv4 and external DNS hostname: "
read  instanceCredential

chmod 0400 "$pemFilePath"


scp -i "$pemFilePath" -r "$zipFilePath" $instanceCredential:/home

ssh -i "$pemFilePath" $instanceCredential