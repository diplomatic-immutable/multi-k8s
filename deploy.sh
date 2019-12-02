docker build -t diplomaticimmutable/multi-client:latest -t diplomaticimmutable/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t diplomaticimmutable/multi-server:latest -t diplomaticimmutable/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t diplomaticimmutable/multi-worker:latest -t diplomaticimmutable/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push diplomaticimmutable/multi-client:latest
docker push diplomaticimmutable/multi-server:latest
docker push diplomaticimmutable/multi-worker:latest

docker push diplomaticimmutable/multi-client:$SHA
docker push diplomaticimmutable/multi-server:$SHA
docker push diplomaticimmutable/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=diplomaticimmutable/multi-server:$SHA
kubectl set image deployments/client-deployment client=diplomaticimmutable/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=diplomaticimmutable/multi-worker:$SHA