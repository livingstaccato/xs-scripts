#!/bin/bash

epel_url=https://dl.fedoraproject.org/pub/epel/5/x86_64/

rpm_list=$(cat<<EOF
git-1.8.2.1-1.el5.x86_64.rpm
perl-Git-1.8.2.1-1.el5.x86_64.rpm
perl-Error-0.17010-1.el5.noarch.rpm
perl-TermReadKey-2.30-4.el5.x86_64.rpm
EOF)

mkdir /tmp/rpm

wget \
  --continue \
  --base=${epel_url} \
  --directory-prefix=/tmp/rpm/ \
  --input-file=- <<< "${rpm_list}"

rpm -Uvh $rpm_list
