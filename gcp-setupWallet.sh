function validate_password() {
    
    while true; do
        
        echo "Set the password for Wallet: "
        read -s walletpassword
        echo "echo username through which you are running this command or have done SSH"
        read  username
        if [[ ${#walletpassword} -ge 8 && "$walletpassword" == *[A-Z]* && "$walletpassword" == *[a-z]* && "$walletpassword" == *[0-9]* ]]; then
        
            if [[ $walletpassword =~ ['!@#$%^&*()_+'] ]]; then
                
                sudo apt install nano -y
                sudo apt install unzip -y
                unzip -o validator_keys.zip

                sudo mkdir /home/"$username"/password

                cd password

                echo $walletpassword > pass.txt

                cd /home/"$username"
                
                sudo docker rm AccountImport
                
                sudo docker run -it -v /home/"$username"/Eth2Validators/prysm-wallet-v2:/wallet -v /home/"$username"/password:/password --network="host" gcr.io/prysmaticlabs/prysm/validator:v5.0.3 wallet create --wallet-dir=/wallet --accept-terms-of-use --wallet-password-file=/password/pass.txt
                
		        sudo docker run -it -v /home/"$username"/validator_keys:/keys -v /home/"$username"/Eth2Validators/prysm-wallet-v2:/wallet -v /home/"$username"/Eth2:/validatorDB -v /home/"$username"/password:/password --name AccountImport gcr.io/prysmaticlabs/prysm/validator:v5.0.3 --beacon-rpc-provider=34.123.232.83:4000 --attest-timely --enable-builder --datadir=/validatorDB accounts import --keys-dir=/keys --wallet-dir=/wallet --accept-terms-of-use --wallet-password-file=/password/pass.txt
                sudo chown -R "$username":"$username" /home/"$username"/Eth2 /home/"$username"/Eth2Validators
                sudo chmod 700 /home/"$username"/Eth2 /home/"$username"/Eth2Validators

                ################# New Docker pull command ###########################################
                #sudo docker pull us-central1-docker.pkg.dev/launchnodesltd-public/validator-metering/latest:latest
                
                return
            else
                
                echo "[The Password must have at least 8 characters, at least 1 alphabetical character, 1 unicode symbol, and 1 number. Eg: Paas@12345]" >&2
            fi
                        
            
            
        else
            echo "[The Password must have at least 8 characters, at least 1 alphabetical character, 1 unicode symbol, and 1 number. Eg: Paas@12345]" >&2
        fi
    done
}


validate_password

echo -e "\n\n\nHappy Staking, from Launchnodes..."
