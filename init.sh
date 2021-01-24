  #! /bin/bash
  sudo apt-get update -y && apt-get upgrade -y
  sudo curl -fsSL https://get.docker.com/ | bash
  sudo apt-get update && apt-get install -y apt-transport-https git
  sudo curl -L "https://github.com/docker/compose/releases/download/1.28.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose