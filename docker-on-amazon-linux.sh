sudo yum update
sudo yum search docker
sudo yum info docker
sudo yum install docker

sudo usermod -a -G docker ec2-user
id ec2-user
newgrp docker


# For docker compose
sudo yum install python3-pip
sudo pip3 install docker-compose # with root access

# or

pip3 install --user docker-compose # without root access for security reasons

sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl status docker.service

echo "$PATH"
export PATH=$PATH:/usr/local/bin
sudo find / -name "docker-compose" -ls

docker version
docker-compose version


aws ecr describe-repositories --region us-east-2

nano Dockerfile

-----------------------
FROM public.ecr.aws/docker/library/ubuntu:18.04

# Install dependencies
RUN apt-get update && \
 apt-get -y install apache2

# Install apache and write hello world message
RUN echo 'Hello World!' > /var/www/html/index.html

# Configure apache
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \ 
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \ 
 chmod 755 /root/run_apache.sh

EXPOSE 80

CMD /root/run_apache.sh
---------------------------------


docker build -t agastyalocalrepo .


docker images --filter reference=agastyalocalrepo

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 171728121508.dkr.ecr.us-east-2.amazonaws.com

docker build -t agastya-ecr-repo .

docker tag agastya-ecr-repo:latest 171728121508.dkr.ecr.us-east-2.amazonaws.com/agastya-ecr-repo:latest

docker push 171728121508.dkr.ecr.us-east-2.amazonaws.com/agastya-ecr-repo:latest
