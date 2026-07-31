git fetch --all
git merge --all
@REM docker compose down
docker compose stop
docker compose up -d --pull always wh
docker compose start