#!/bin/bash
set -e
echo "------ Installing sonar"
sudo wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
sudo yum install -y --quiet sonar
sudo chmod 755 /home/ec2-user/run-sonarqube.sh
echo "------ Finished!"
