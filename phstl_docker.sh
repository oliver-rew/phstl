#!/bin/bash

# run the scrip in docker with the provided args
docker run -it -v $(pwd):/workdir --workdir "/workdir" osgeo/gdal:latest python3 phstl.py $@
