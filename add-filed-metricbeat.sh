sourcexml=$(ls /appsajjad/tomcat/conf/Catalina/localhost/*.xml | tr '\n' ' ')
sed -i '/project_name/s/"[^"]*"/"'"$sourcexml"'"/g' /etc/metricbeat/metricbeat.yml
if [ "$?" == "0" ]; then
    systemctl stop metricbeat.service
    sleep 1
    systemctl start metricbeat.service
    echo "the project_name are added"
fi