docker build -t jeffligon/multi-client:latest -t jeffligon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeffligon/multi-server:latest -t jeffligon/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t jeffligon/multi-worker:latest -t jeffligon/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push jeffligon/multi-client:latest
docker push jeffligon/multi-client:$SHA
docker push jeffligon/multi-server:latest
docker push jeffligon/multi-server:$SHA
docker push jeffligon/multi-worker:latest
docker push jeffligon/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jeffligon/multi-server:$SHA
kubectl set image deployments/client-deployment client=jeffligon/multi-client:$SHA
kubectl set image deployments/worker-deployment server=jeffligon/multi-worker:$SHA
  