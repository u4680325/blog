# git checkout develop

CONCURRENCY=40
ENV_NAME="production"
CPU=1
RAM="1G"
MAX_INSTANCES=20
MIN_INSTANCES=0
INSTANCE_CONNECTION_NAME="wis-samui:asia-southeast1:production-databases"
PROJECT="wis-samui"
CLOUD_RUN_NAME="prod-school-blog-backend"
IMAGE="asia-southeast1-docker.pkg.dev/$PROJECT/asia/$CLOUD_RUN_NAME"

docker buildx build --platform linux/amd64 -t $IMAGE:latest -f Dockerfile --load .

gcloud config set project wis-samui
gcloud auth configure-docker asia-southeast1-docker.pkg.dev --quiet

docker push $IMAGE:latest

sleep 2

gcloud beta run deploy $CLOUD_RUN_NAME --use-http2 --cpu-boost --cpu $CPU --memory $RAM --allow-unauthenticated --region asia-southeast1 --project "$PROJECT" --image $IMAGE --platform managed --max-instances $MAX_INSTANCES --min-instances $MIN_INSTANCES --concurrency $CONCURRENCY --add-cloudsql-instances $INSTANCE_CONNECTION_NAME --update-env-vars RAILS_MAX_THREADS="$CONCURRENCY",RAILS_ENV="$ENV_NAME",INSTANCE_CONNECTION_NAME="$INSTANCE_CONNECTION_NAME",RAILS_MASTER_KEY="$(cat ./config/credentials/$ENV_NAME.key)",WEB_CONCURRENCY="$CPU"

##############################################
#                   README                   #
##############################################
# file ที่จำเป็นต้อง copy สำหรับ deploy           #
##############################################
# ไม่ต้องแก้ข้างใน                               #
##############################################
# ./Dockerfile (ยกเว้น ruby version)          #
# ./delete_non_latest.sh                     #
# ./entrypoint.sh                            #
# ./falcon.rb                                #
# ./falcon_preload.rb                        #
##############################################
# ต้องแก้ข้างใน                                 #
##############################################
# ./$ENV_NAME-cloud-build.yml                #
# ./release_$ENV_NAME.sh                     #
# ./config/database.cloudrun.yml             #
##############################################

./delete_non_latest.sh asia-southeast1-docker.pkg.dev/$PROJECT/asia $CLOUD_RUN_NAME $PROJECT