#!/bin/bash

while true; do
    IP=$(kubectl -n $APP_NS get svc frontend-lb -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    if [[ -z "$IP" ]]; then
        echo "External load balancer IP unavailable ..."
        sleep 1
        continue
    fi
    echo "External load balancer IP: $IP"
    socat TCP-LISTEN:3800,fork,reuseaddr TCP-CONNECT:$IP:80
done
