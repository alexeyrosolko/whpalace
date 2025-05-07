
# Create Directory Name YYYY_MM_DD_DOCKER_IMAGE_VERSION
export docker_image_version=`cat docker_image_version`
echo $docker_image_version
((docker_image_version+=1))
echo "image version: "$docker_image_version
echo $docker_image_version > docker_image_version
export container_postfix=`date +%m-%d`_$docker_image_version
echo "container_postfix:" $container_postfix

cd /Users/Aliaksei_Rasolka/wh/doc/2024/docker/build
# Create WorkDir
release_dir=`date +%Y-%m-%d`_$docker_image_version
work_dir=`pwd`/$release_dir
echo "release_dir:" $release_dir
echo "work_dir: "$work_dir
mkdir $work_dir

#Build UI
cd /Users/Aliaksei_Rasolka/wh/web/wh24ui
echo "<div>"`date` Docker image: $docker_image_version"</div>" >> src/app/components/system/about/about.component.html
/Users/Aliaksei_Rasolka/.nvm/versions/node/v22.7.0/bin/npm run build

#Copy UI to Back
rm -r /Users/Aliaksei_Rasolka/wh/wh/src/main/resources/static
cp -R /Users/Aliaksei_Rasolka/wh/web/wh24ui/dist/wh24ui/browser /Users/Aliaksei_Rasolka/wh/wh/src/main/resources/static

#Build Back
cd /Users/Aliaksei_Rasolka/wh/wh

./gradlew clean
./gradlew bootJar

# Copy Jar to Docker work_directory
echo "Copy Jar to Docker work_directory "$work_dir
cp /Users/Aliaksei_Rasolka/wh/wh/build/libs/wh-0.0.1-SNAPSHOT.jar $work_dir
echo "[+] Copy Jar to Docker work_directory "$work_dir

# Build Docker
cd $work_dir
cp /Users/Aliaksei_Rasolka/wh/doc/2024/docker/2025-05-06/Dockerfile $work_dir
cp /Users/Aliaksei_Rasolka/wh/doc/2024/docker/2025-05-06/compose.yaml $work_dir
podman build -t whc $work_dir
podman tag localhost/whc alexeyrosolko/whc:1.$docker_image_version

#Prepare start
mkdir /Users/Aliaksei_Rasolka/wh/whpalace/start
cd /Users/Aliaksei_Rasolka/wh/whpalace/start
cat /Users/Aliaksei_Rasolka/wh/whpalace/build/compose.yaml > /Users/Aliaksei_Rasolka/wh/whpalace/start/compose.yaml
echo "docker_image_version="$docker_image_version > /Users/Aliaksei_Rasolka/wh/whpalace/start/.env
echo "container_postfix="$container_postfix >> /Users/Aliaksei_Rasolka/wh/whpalace/start/.env

echo "podman push alexeyrosolko/whc:1."$docker_image_version
# Compose Up
#podman compose -f $work_dir/compose.yaml up
