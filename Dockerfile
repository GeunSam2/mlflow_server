FROM python:3.6-slim

RUN sed -i 's_deb.debian.org_mirror.kakao.com_g' /etc/apt/sources.list &&\
	apt-get update &&\
	apt-get install -y vim
RUN apt-get install -y libyaml-cpp-dev libyaml-dev
RUN pip install mlflow
RUN pip --no-cache-dir install --force-reinstall -I pyyaml
RUN pip install pysftp
RUN apt-get install -y openssh-server
COPY ./sshd_config /etc/ssh/sshd_config
COPY ./ssh-key /root/.ssh
RUN mkdir -p /run/sshd 
RUN /usr/sbin/sshd
RUN mkdir -p /data1

ENV GIT_PYTHON_REFRESH=quiet
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN chmod 700 ~/.ssh &&\
chmod 600 ~/.ssh/id_rsa &&\
chmod 644 ~/.ssh/id_rsa.pub &&\
chmod 644 ~/.ssh/authorized_keys

RUN /bin/bash -c 'echo -e "kbsys1234\nkbsys1234" | passwd root'
RUN pip install pymysql

ENTRYPOINT [ "/bin/bash", "-c", "/entrypoint.sh" ]
