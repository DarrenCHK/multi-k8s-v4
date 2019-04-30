docker build -t dcattera/multi-client:latest -t dcattera/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dcattera/multi-server:latest -t dcattera/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dcattera/multi-worker:latest -t dcattera/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dcattera/multi-client:latest
docker push dcattera/multi-server:latest
docker push dcattera/multi-worker:latest

docker push dcattera/multi-client:$SHA
docker push dcattera/multi-server:$SHA
docker push dcattera/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dcattera/multi-server:$SHA
kubectl set image deployments/client-deployment client=dcattera/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dcattera/multi-worker:$SHA
