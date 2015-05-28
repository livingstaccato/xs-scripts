#!/bin/bash

centos_url=http://mirrors.kernel.org/centos/5.11/os/x86_64/CentOS/
epel_url=http://dl.fedoraproject.org/pub/epel/5/x86_64/

git_base_url=${epel_url}
git_rpm_list=$(cat<<EOF
git-1.8.2.1-1.el5.x86_64.rpm
perl-Git-1.8.2.1-1.el5.x86_64.rpm
perl-Error-0.17010-1.el5.noarch.rpm
perl-TermReadKey-2.30-4.el5.x86_64.rpm
EOF)

screen_base_url=${centos_url}
screen_rpm_list=screen-4.0.3-4.el5.x86_64.rpm

package=$1

base_url=${package}_url
rpm_list=${package}_rpm_list

echo ${!base_url}
echo ${!rpm_list}

exit
mkdir /tmp/rpm

wget \
  --continue \
  --base=${base_url} \
  --directory-prefix=/tmp/rpm/ \
  --input-file=- <<< "${rpm_list}"

rpm -Uvh $rpm_list
