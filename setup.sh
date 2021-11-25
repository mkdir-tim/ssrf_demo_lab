#!/bin/bash

#docker-compose file content 
cnt="
web:
  image: 'gitlab/gitlab-ce:11.4.7-ce.0'
  restart: always
  hostname: 'gitlab.example.com'
  environment:
    GITLAB_OMNIBUS_CONFIG: |
      external_url 'http://gitlab.example.com'
      redis['bind']='127.0.0.1'
      redis['port']=6379
      gitlab_rails['initial_root_password']=File.read('/steg0_initial_root_password')
  ports:
    - '5080:80'
    - '50443:443'
    - '5022:22'
  volumes:
    - './srv/gitlab/config:/etc/gitlab'
    - './srv/gitlab/logs:/var/log/gitlab'
    - './srv/gitlab/data:/var/opt/gitlab'
    - './steg0_initial_root_password:/steg0_initial_root_password'
    - './flag:/flag:ro'
"

#creating and naviagte to demo folder
mkdir ssrf_lab
cd ssrf_lab/

#create docker-compose file
touch docker-compose.yml
echo "$cnt" > docker-compose.yml

#debug parameter
cat docker-compose.yml

#creating required files and folgers
mkdir -p ./srv/gitlab/config ./srv/gitlab/data ./srv/gitlab/logs
echo "my_sup3r_s3cr3t_p455w0rd_4ef5a2e1" > ./steg0_initial_root_password

#create flag file
flag="sSe_dEmo_fLag_sSrF" > ./flag

#update and upgrade advanced package tool
sudo apt update
sudo apt upgrade

#install and start  goolge-chrome-stable
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install gdebi-core
gdebi google-chrome-stable_current_amd64.deb

#sudo dpkg -I google-chrome-stable_current_amd63.deb
#google-chrome-stable --no-sandbox
#alternative: open firefox on localhost
#firefox --new-window http:127.0.0.1:5080 

#configure chrome browser to use our proxy
/usr/bin/google-chrome-stable --proxy-server="127.0.0.1:8080" --profile-directory=Proxy --proxy-bypass-list=""

#adding localhost entry for purbsuite in etc/hosts to intercept localhost requests
cnt1="

127.0.0.1	localhost
127.0.0.1	localhost.com
127.0.1.1	kali.domain.com kali

#the following lines are desirable for IPv6 capable
::1	localhost ip6-localhost ip6-loopback
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
"

echo "$cnt1" > ~/../../etc/hosts

#start docker container
apt install docker-compose
docker-compose up

#configure chrome browser to use our proxy
#/usr/bin/google-chrome-stable --proxy-server="127.0.0.1:8080" --profile-directory=Proxy --proxy-bypass-list=""

#docker-compose up &
#google-chrome-stable --no-sandbox
#wait

echo "run sucessfull"
