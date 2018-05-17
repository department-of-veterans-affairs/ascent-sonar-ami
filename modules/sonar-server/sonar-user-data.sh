#!/bin/bash

# The following variables are replaced with terraform interpolation
/home/ec2-user/run-sonarqube.sh ${db_username} \
                                ${db_password} \
                                ${jdbc_url} > /home/ec2-user/run-sonarqube.out 2>&1
