#!/bin/bash
sigmaTime(){
    hour="$1"
    minute="$2"
    hour=${hour#0}
    minute=${minute#0}
    if [ -z "$hour" ]; then 
        hour="0"
    fi
    if [ -z "$minute" ];then
        minute="0"
    fi
    echo $((hour * 60 + minute))
}
dateTime(){
    date_hour=$(date +%H:%M)
    date_hour=${date_hour/:/ }
    sigma_date=$(sigmaTime $date_hour)
}
startTime(){
    time="$1"
    time=${time/:/ }
    sigma_time=$(sigmaTime $time)
    dateTime
    while [ "$sigma_date" != "$sigma_time" ];do
        echo  (($sigma_date != $sigma_date)) "minutes until down servers"
        sleep 20
        dateTime
    done
}
downServer(){
    echo "$downServers"
}
endTime(){
    time="$1"
    time=${time/:/ }
    sigma_time=$(sigmaTime $time)
    dateTime
    while [ "$sigma_date" != "$sigma_time" ];do
    sleep 20
    dateTime
    done
}
upServer(){
    echo "$upServers"
}
Downtime_input="00:00"
Uptime_input="12:00"
downServers=$(service tomcat stop)
Upservers=$(service tomcat start)
startTime $Downtime_input
downServer &
endTime $Uptime_input
upServer