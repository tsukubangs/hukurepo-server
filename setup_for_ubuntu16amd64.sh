./install-docker-for-ubuntu16amd64.sh
sudo docker-compose build
sudo docker-compose up -d
sudo docker-compose run --rm web ruby bin/confirm.rb
