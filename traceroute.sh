#!/bin/bash

count=1
ttl=56
LANG=C
while getopts a:t:c: OPT
do
	case $OPT in
		a)
			address=$OPTARG
			;;
		t)
			ttl=$OPTARG
			;;
		c)
			count=$OPTARG
			;;
		*)
			echo "plese specify a,t options"
			exit 1
			;;
	esac
done

if [ -z "$address" ]; then
	echo "plese specify address"
	exit 1
fi


for i in `seq 1 ${ttl}`
do
	status=$(ping -t ${i} -c ${count} ${address}|grep -E "(Time to live exceeded|bytes from)")
	step=$(echo "$status" | grep -oE "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")
	printf "%s " $i
	if [ "$step" = "$address" ];then
		echo $step
		break
	fi
	if [ -n "$step" ];then
		echo $step
	else
		printf "? "
	fi
done
