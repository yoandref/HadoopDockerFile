# Preparação do NameNode

1- Baixe e descompacte o arquivo zip disponível ao final do capítulo.

2- Faça o download do Apache Hadoop e do JDK 8, coloque na pasta "binarios", descompacte os arquivos e renomeie as pastas. O procedimento é mostrado nas aulas.

3- Abra o terminal ou prompt de comando, navegue até a pasta do NameNode e execute a instrução abaixo para criar a imagem:

docker build . -t namenode:dsa

# Documentação do docker build:
https://docs.docker.com/engine/reference/commandline/build/

3- Precisaremos de uma rede. Verifique as redes disponíveis e então crie uma com as instruções abaixo:

docker network ls
docker network create -d bridge dsa_dl_net

4- Crie e inicialize o container com a instrução abaixo:

docker run -it -d --net dsa_dl_net --hostname hdpmaster -p 9870:9870 -p 50030:50030 -p 8020:8020 --name namenode namenode:dsa 

# Documentação do doccker run:
https://docs.docker.com/engine/reference/commandline/run/

5- Acesse o container usando a CLI no Docker Desktop e execute as instruções abaixo:

# Restart do serviço ssh
sudo service ssh restart

# Ajuste dos privilégios
sudo chown -R hduser:hduser /home/hduser/jdk
sudo chown -R hduser:hduser /home/hduser/hadoop

# Formate o NameNode (somente na primeira execução)
hdfs namenode -format

# Start do serviço do NameNode
hdfs --daemon start namenode

# Se precisar parar o serviço:
hdfs --daemon stop namenode

# Acesse o painel de gestão pelo navegador como mostrado nas aulas.

Obs: Se não funcionar o endereço 0.0.0.0 use localhost

# Rodando a imagem já criada:

docker exec -it --privileged=true <NOME_IMAGEM | ID_IMAGEM> bash
