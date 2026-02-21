git fetch --all
git merge --all
docker compose stop
docker compose up -d --pull always wh
docker compose start