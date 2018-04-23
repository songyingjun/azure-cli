#!/bin/bash
 usage()
 {
 echo "Usage: $0 Azure_PassWord"
 echo "example: $0 abcd1234"
 exit 1
 }
if [ $# -ne 1 ] ; then
    usage
else
    password=$1
fi

ROOT_UID=0

if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Need root privilege"
  exit 1
fi
azure_login()
{
azure login -u kpchina@handcloud.partner.onmschina.cn -e AzureChinaCloud -p ${Azure-Portal-Password} > /dev/null 2>&1
azure config mode asm
if [ $? == 0 ];then
	echo login success
	cat vm_list|while read line
	do
	azure vm start $line
	done 
else
	echo login failed
	exit 1
fi
}

rancher --env Staging start 1i1848224

activate_rancher_stack()
{
cat stacks_list|awk '{print $1}'|grep -v ID|while read line
do
	rancher --env Staging activate $line
done
}

activate_rancher_host()
{
cat hosts_list|awk '{print $1}'|grep -v ID|while read line
do
        rancher --env Staging activate $line
done
}

azure_login

sleep 100

activate_rancher_host


sleep 30

activate_rancher_stack

