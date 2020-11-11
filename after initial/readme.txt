https://blog.konnor.site/rails/getting-started-with-rails-6/

- zameni bosco_gurin sa odgovarajućim imenom u svim fajlovima
- proveri verziju ruby u Dockerfile, Gemfile i .ruby-version

docker-compose run --rm --no-deps web rails new . --force --no-deps --database=mysql


docker-compose up --build
docker-compose run --rm web rails db:create
docker-compose run --rm web rails db:migrate

docker-compose down

kadgod se nešto doda u Gemfile:
docker-compose run web bundle install
docker-compose up --build

# Ako se izmeni docker-compose.yml ali ne i Gemfile:
docker-compose up --build

# Ako nema potrebe za buildovanjem:
docker-compose up

# Umesto:
-> rails [command]
# treba:
-> docker-compose run --rm web rails [command]


docker-compose exec is to be run if you have a container already running.
docker-compose run is to be run if you do not have a container running.
docker-compose run --rm will automatically remove the docker instance once the command finished


# Remove orphaned containers as well
docker-compose down --remove-orphans

docker volume ls # lists the volumes
docker volume rm <volume-name> # removes the volume
docker volume prune [--force] # remove all unused volumes

# run a bash instance inside of the docker-compose container
# now you can simply run commands like `rails db:migrate` without
# adding `docker-compose run web` before every command
docker-compose run --rm web /bin/bash

# Things are totally jacked up? Remove all images and containers.
# https://stackoverflow.com/a/52179797
docker rm $(docker ps -q -a) -f && docker rmi $(docker images -q) -f


docker build --tag solidus_test:0.2 . 
docker tag bulletinboard:1.0 <Your Docker ID>/bulletinboard:1.0
docker push <Your Docker ID>/bulletinboard:1.0


