#!/bin/bash

# #####################################################################################
# Set variables and output for debugging
# #####################################################################################
SONAR_HOME=/opt/sonar
SONAR_CONFIG=$SONAR_HOME/conf/sonar.properties

DB_USERNAME=$1
DB_PASSWORD=$2
DATABASE_JDBC_URL=$3

echo "USERNAME=$USERNAME"
echo "PASSWORD=$PASSWORD"
echo "DATABASE_JDBC_URL=$DATABASE_JDBC_URL"


# #####################################################################################
# Setup the jdbc datbase info. The following is for a postgresql database
# -- See https://docs.sonarqube.org/display/SONAR/Installing+the+Server
# #####################################################################################
echo "sonar.jdbc.username=${USERNAME}" >> $SONAR_CONFIG
echo "sonar.jdbc.password=${PASSWORD}" >> $SONAR_CONFIG
echo "sonar.jdbc.url=${DATABASE_JDBC_URL}" >> $SONAR_CONFIG
echo "sonar.web.javaOpts=-server" >> $SONAR_CONFIG

# #####################################################################################
# Add sonar as a service
# -- https://docs.sonarqube.org/display/SONAR/Running+SonarQube+as+a+Service+on+Linux
# #####################################################################################
sudo mv /home/ec2-user/sonar-service /etc/init.d/sonar
sudo ln -s $SONAR_HOME/bin/linux-x86-64/sonar.sh /usr/bin/sonar
sudo chmod 755 /etc/init.d/sonar
sudo chkconfig --add sonar

sudo service sonar start
