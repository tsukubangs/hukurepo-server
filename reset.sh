sudo docker-compose down
sudo docker ps -aq | xargs docker rm
sudo docker images -aq | xargs docker rmi
sudo docker volume rm $(docker volume ls -qf dangling=true)

sudo rm -rf containers/db
sudo rm -rf containers/nginx/certs 
