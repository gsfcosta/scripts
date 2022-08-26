#!/bin/bash
clear
x=0
y=0
for ip in $(cat ips.txt); do #ARQUIVO COM IPS/DNS UM ABAIXO DO OUTRO
        nc -zvw 3 $ip 22 #TESTANDO PORTA 22 (SSH)
        if (( $? == 0 )); then
                echo "$ip" >> /tmp/result_success.txt
                echo "$ip > SUCCESS"
                let x=($x+1)
        else
                echo "$ip" >> /tmp/result_failed.txt
                echo "$ip > FAILED"
                let y=($y+1)
        fi
        echo -e "\n-------------------------------------------------\n"
done
echo -e "\nSucesso: $x\nFailed: $y"
