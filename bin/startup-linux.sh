#!/bin/bash
OUTPUT="$(sudo sysctl -w vm.max_map_count=262144)"
OUTPUT2="$(sysctl vm.max_map_count)"
echo "New ${OUTPUT2}"

echo "Starting up using docker-compose"
docker-compose up -d