docker run -it \
        --name pyroms \
        --mount type=bind,source="${PWD}",target=/app bilgetutak/pyroms:1.2