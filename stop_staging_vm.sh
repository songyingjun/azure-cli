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
azure login -u kpchina@handcloud.partner.onmschina.cn -e AzureChinaCloud -p ${azure config mode asm} > /dev/null 2>&1
azure config mode asm
if [ $? == 0 ];then
	echo login success
	cat vm_list|while read line
	do
	azure vm shutdown $line
	done 
else
	echo login failed
	exit 1
fi
}

rancher --env Staging stop 1i1848224

deactivate_rancher_stack()
{
rancher --env Staging stacks|awk '{print $1}'|grep -v ID|while read line
do
	rancher --env Staging deactivate $line
#	rahcher --env Staging stacks|awk '{print $1}'|grep -v ID > stacks_list
done
}

deactivate_rancher_host()
{
rancher --env Staging hosts|awk '{print $1}'|grep -v ID|while read line
do
#	rahcher --env Staging hosts|awk '{print $1}'|grep -v ID > hosts_list
        rancher --env Staging deactivate $line
done
}

deactivate_rancher_stack

sleep 120

deactivate_rancher_host

sleep 30

azure_login


