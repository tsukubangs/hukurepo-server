docker-compose build & \
docker-compose run --rm web rails db:migrate & \
docker-compose run --rm web rails db:seed_fu & \
docker-compoe up -d
