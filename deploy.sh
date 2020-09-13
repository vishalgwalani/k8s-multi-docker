docker build -t vishalgwalani/multi-client:latest -t vishalgwalani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vishalgwalani/multi-server:latest -t vishalgwalani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vishalgwalani/multi-worker:latest -t vishalgwalani/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vishalgwalani/multi-client:latest
docker push vishalgwalani/multi-server:latest
docker push vishalgwalani/multi-worker:latest
docker push vishalgwalani/multi-client:$SHA
docker push vishalgwalani/multi-server:$SHA
docker push vishalgwalani/multi-worker:$SHA
kuberctl apply -f k8s
kuberctl set image deployments/server-deployment server=vishalgwalani/multi-server:$SHA
kuberctl set image deployments/client-deployment client=vishalgwalani/multi-client:$SHA
kuberctl set image deployments/worker-deployment worker=vishalgwalani/multi-worker:$SHA