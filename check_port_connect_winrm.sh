#!/bin/bash
clear
x=0
y=0
for ip in $(cat ips.txt); do #ARQUIVO COM IPS/DNS UM ABAIXO DO OUTRO
        nc -zvw 3 $ip 5985 #TESTANDO PORTA 5985 (WINRM HTTP)
        if (( $? == 0 )); then
                echo "$ip = HTTP" >> /tmp/result_success.txt
                echo "$ip = HTTP > SUCCESS"
                let x=($x+1)
        else
			nc -zvw 3 $ip 5985 #TESTANDO PORTA 5986 (WINRM HTTPS)
        	if (( $? == 0 )); then
        	        echo "$ip = HTTPS" >> /tmp/result_success.txt
        	        echo "$ip = HTTPS > SUCCESS"
        	        let x=($x+1)
        	else
        	        echo "$ip" >> /tmp/result_failed.txt
        	        echo "$ip > FAILED"
        	        let y=($y+1)
        	fi
        fi
        echo -e "\n-------------------------------------------------\n"
done
echo -e "\nSucesso: $x\nFailed: $y"
