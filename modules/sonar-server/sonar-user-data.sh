#!/bin/bash

# The following variables are replaced with terraform interpolation
/home/ec2-user/run-sonarqube.sh ${sonar_db_username} \
                                ${sonar_db_password} \
                                ${jdbc_url} \
                                ${sonar_port} > /home/ec2-user/run-sonarqube.out 2>&1
