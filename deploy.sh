IMAGE_TAG=swr.cn-north-4.myhuaweicloud.com/registry-huawei/effyic/chat-clip:latest
docker build . --platform linux/amd64 -t $IMAGE_TAG
docker push $IMAGE_TAG