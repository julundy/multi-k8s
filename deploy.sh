#!/bin/bash -e

$(aws ecr get-login --no-include-email --region us-west-2)

docker build -t julundy/multi-client:latest -t 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-client:latest -t 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t julundy/multi-server:latest -t 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-server:latest-t 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t julundy/multi-worker:latest -t 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-worker:latest-t 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-client:latest
docker push 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-server:latest
docker push 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-worker:latest

docker push 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-client:$SHA
docker push 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-server:$SHA
docker push 894511344406.dkr.ecr.us-west-2.amazonaws.com/julundy/multi-worker:$SHA

# kubectl apply -f k8s
# kubectl set image deployments/server-deployments server=julundy/multi-server:$SHA
# kubectl set image deployments/client-deployments client=julundy/multi-client:$SHA
# kubectl set image deployments/worker-deployments worker=julundy/multi-worker:$SHA