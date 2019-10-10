docker build -t tomekde/multi-client:latest -t tomekde/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tomekde/multi-server:latest -t tomekde/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tomekde/multi-worker:latest -t tomekde/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tomekde/multi-client:latest
docker push tomekde/multi-server:latest
docker push tomekde/multi-worker:latest
docker push tomekde/multi-client:$SHA
docker push tomekde/multi-server:$SHA
docker push tomekde/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=tomekde/multi-client:$SHA
kubectl set image deployment/server-deployment server=tomekde/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=tomekde/multi-worker:$SHA