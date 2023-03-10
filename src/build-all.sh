#! /bin/sh


if [ $# -ne 1 ] || [ $1 -gt 3 ]
then
    echo "ERROR: "
    echo "  Please specify a building option as an argument."
    echo "      0 : For building and deploying the project";
    echo "      1 : For building the project only.";
    echo "      2 : For deploying the project only.";
    exit;
fi;



# Building the images
if [ $1 -le 1 ]
then
    # Building the backend
    echo "Building the api-service ...";
    cd api-service && npm install && npm run build && docker build . -t api-service:latest;
    if [ $? -ne 0 ]
    then 
        echo "Failed to build the image... Exitting with code $?";
        exit;
    fi;
    cd ..;

    echo "----------------------------------------------------------------------------------- ";

    # Building the frontend
    echo "Building the gui-service ...";
    cd gui-service && npm install && npm run build && docker build . -t gui-service:latest;
    if [ $? -ne 0 ]
    then 
        echo "Failed to build the image... Exitting with code $?";
        exit;
    fi;
    cd ..;

    echo "----------------------------------------------------------------------------------- ";

    # Final step to make your "docker images" command outputs pretty stuff. 
    echo "Deleting all <none> images in docker...";
    docker images | grep "<none>" | awk '{ print $3; }' | xargs docker rmi -f; # cleaning the docker junk docker images.

    echo "----------------------------------------------------------------------------------- ";


    echo "Removing Postgres Saved Data"
    rm -rf postgre-service/data
    
    echo "----------------------------------------------------------------------------------- ";
fi;


if [ $1 -ne 1 ]
then
    echo "Shutting down the old deployment...";
    docker-compose -f ../docker-compose-local.yml down --remove-orphans;
    echo "Deploying the project locally...";
    docker-compose -f ../docker-compose-local.yml up -d --force-recreate;
    echo "Project has been deployed by running the docker-compose on the docker-compose-local.yml file.";
fi;