#!/bin/sh
MEM=$(free -g | grep Mem | awk '{print $3}')
XMX=$(cat /tomcat/bin/catalina.sh | grep 'JAVA_OPTS=\"-server' | awk '{print $6}' | grep -o '[1-9]\+' )
#XMS=$XMX
SWAP_SUGGEST=11
PERCANTAGE_HIP_SUGGEST=71
SWAPPINESS=$(cat /proc/sys/vm/swappiness)
NORMAL_HIP_SIZE=$(echo "$PERCANTAGE_HIP_SUGGEST/101*$MEM" | bc -l | awk -F '.' '{print $1}' )
RAM_USAGE=$(expr 101 - $SWAPP_SUGGEST )

if [ "$SWAPPINESS" != "$SWAP_SUGGEST" ]; then
    SWAPP_SYS_CONF=$(grep "vm.swappiness" /etc/sysctl.conf | awk -F "_" '{print $3}')
        if [ -z "$SWAPP_SYS_CONF" ]; then
            echo 'vm.swappiness='$SWAP_SUGGEST >> /etc/sysctl.conf
            sysctl --system > /dev/null 2>&1
            echo The system use Swapp when Ram usage upper than $RAM_USAGE%
        else
            sed -i -e 's/vm.swappiness.*/vm.swappiness='"$SWAP_SUGGEST"'/g' /etc/sysctl.conf
            sysctl --system > /dev/null 2>&1
            echo The system use Swapp when Ram usage upper than $RAM_USAGE%
        fi
else
    echo "Your Swapp is OK" 
fi

if [ "$NORMAL_HIP_SIZE" -eq "$XMX" ]; then
    echo "the Hip size is Ok"
else
    sed -i -e '/^JAVA_OPTS/s/-Xmx[^ ]*/-Xmx'"$NORMAL_HIP_SIZE"'g/' /tomcat/bin/catalina.sh
    sed -i -e '/^JAVA_OPTS/s/-Xms[^ ]*/-Xms'"$NORMAL_HIP_SIZE"'g/' /tomcat/bin/catalina.sh
fi


#partow
