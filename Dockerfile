# Arquivo de Configuração do DataNode no Cluster HDFS
# Data Science Academy

# O sistema operacional será o Ubuntu na versão mais atual
# https://hub.docker.com/_/ubuntu
FROM ubuntu:latest

# Updates e instalações
RUN \
  apt-get update && apt-get install -y \
  openssh-server \
  python3 \
  rsync \
  sudo \
  arp-scan \
  net-tools \
  iputils-ping \
  vim \
  && apt-get clean

# Cria usuário para a instalação do Hadoop
RUN useradd -m hduser && echo "hduser:supergroup" | chpasswd && adduser hduser sudo && echo "hduser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && cd /usr/bin/ && sudo ln -s python3 python

# Copia o arquivo de configuração do ssh
ADD ./config-files/ssh_config /etc/ssh/ssh_config

# Muda o usuário
USER hduser

# Pasta de trabalho
WORKDIR /home/hduser

# Usuário de trabalho
ENV HDFS_NAMENODE_USER=hduser
ENV HDFS_DATANODE_USER=hduser
ENV HDFS_SECONDARYNAMENODE_USER=hduser
ENV YARN_RESOURCEMANAGER_USER=hduser
ENV YARN_NODEMANAGER_USER=hduser

# Copia os binários do JDK
ADD ./binarios/jdk ./jdk

# Variáveis de ambiente JDK
ENV JAVA_HOME=/home/hduser/jdk
ENV PATH=$PATH:$JAVA_HOME:$JAVA_HOME/bin

# Copia os binários do Hadoop
ADD ./binarios/hadoop ./hadoop

# Variáveis de ambiente do Hadoop
ENV HADOOP_HOME=/home/hduser/hadoop
ENV PATH=$PATH:$HADOOP_HOME
ENV PATH=$PATH:$HADOOP_HOME/bin
ENV PATH=$PATH:$HADOOP_HOME/sbin

# Pastas para os arquivos do DataNode
RUN mkdir /home/hduser/hdfs
RUN mkdir /home/hduser/hdfs/datanode

# Copia os arquivos de configuração
ADD ./config-files/hadoop-env.sh $HADOOP_HOME/etc/hadoop/
ADD ./config-files/core-site.xml $HADOOP_HOME/etc/hadoop/
ADD ./config-files/hdfs-site.xml $HADOOP_HOME/etc/hadoop/
ADD ./config-files/workers $HADOOP_HOME/etc/hadoop/

# Portas que poderão ser usadas
EXPOSE 22


