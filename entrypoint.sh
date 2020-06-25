#!/bin/bash
/usr/sbin/sshd
mkdir -p /data2
mlflow server --host 0.0.0.0 --default-artifact-root file:///data1 --backend-store-uri mysql+pymysql://<username>:<password>@<host>:<port>/<database>
