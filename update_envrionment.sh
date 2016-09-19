#!/bin/bash
# script to update the hole environment
# !!! requires: running ssh-agent !!!

echo "--> add all modified files to git and commit"
git add --all
git commit  -m "add configration change automatically from $(date +%Y-%m-%d:%H:%M:%S)"

echo "--> pull all changes from repo and docker images"
git pull
docker-compose pull

echo "--> rebuild all containers"
docker-compose build && \
    echo "--> stop and remove all running containers" && \
    docker-compose scale jenkinsmaster=0 jenkinsslave=0 && \
    docker-compose down && \
    echo "--> start the new containers" && \
    docker-compose up -d && \
    docker-compose scale jenkinsslave=4

echo "--> push the changes to the git repo"
git push --all
