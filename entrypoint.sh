#!/bin/bash
/usr/sbin/sshd
mkdir -p /data2
mlflow server --host 0.0.0.0 --default-artifact-root file:///data1 --backend-store-uri mysql+pymysql://root:kbsys1234@192.168.0.246:8083/yeom
