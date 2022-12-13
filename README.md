# Preparação dos DataNodes

1- Baixe e descompacte o arquivo zip disponível ao final do capítulo.

2- Faça o download do Apache Hadoop e do JDK 8, coloque na pasta "binarios", descompacte os arquivos e renomeie as pastas. O procedimento é mostrado nas aulas e é o mesmo usado no capítulo anterior.

3- Abra o terminal ou prompt de comando, navegue até a pasta do DataNode e execute a instrução abaixo para criar a imagem:

docker build . -t datanode:dsa

# Documentação do docker build:
https://docs.docker.com/engine/reference/commandline/build/

3- Precisaremos de uma rede. Verifique se a rede dsa_dl_net criada no capítulo anterior está criada:

docker network ls

4- Crie e inicialize o container de cada datanode (criaremos 2) com cada instrução abaixo:

docker run -it -d --net dsa_dl_net --hostname datanode1 --name datanode1 datanode:dsa

docker run -it -d --net dsa_dl_net --hostname datanode2 --name datanode2 datanode:dsa

# Documentação do doccker run:
https://docs.docker.com/engine/reference/commandline/run/

5- Acesse CADA container usando a CLI no Docker Desktop e execute as instruções abaixo:

# Restart do serviço ssh
sudo service ssh restart

# Ajuste dos privilégios
sudo chown -R hduser:hduser /home/hduser/jdk
sudo chown -R hduser:hduser /home/hduser/hadoop

# Crie a pasta ~/.ssh
mkdir ~/.ssh

# Crie o arquivo ~/.ssh/authorized_keys
touch ~/.ssh/authorized_keys

# Ajuste o privilégio
chmod 600 ~/.ssh/authorized_keys

# Copie a chave que está em /home/hduser/.ssh/authorized_keys no NameNode para o mesmo arquivo em cada datanode.

# Start do serviço do DataNode
hdfs --daemon start datanode

# Se precisar parar o serviço:
hdfs --daemon stop datanode

# Acesse o painel de gestão pelo navegador como mostrado nas aulas.

Obs: Se não funcionar o endereço 0.0.0.0 use localhost
