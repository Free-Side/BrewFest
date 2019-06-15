## BrewOahu Homepage, Registration, & Results

This repository contains the docker infrastructure to serve the BrewOahu homepage, the current year's registration site, and past years' results.

### BrewOahu Homepage

The BrewOahu homepage is static html/javascript/css. It was initial built using DreamHost's Remixer, and then manually exported to raw html/javascript/css. It resides with the [/brewoahu](/brewoahu) folder.

### Registration & Results

The registration and results sites are run using the open source [Brew Competition Online Entry & Management](https://github.com/geoffhumphrey/brewcompetitiononlineentry) site. An instance of this site can only host a single competition, so multiple instance are run on different subdomains. Each instance has it's own database. These sites are all run within the same Apache instance within a docker container. This docker container is linked to a MySql docker container. See [docker-compose](docker-compose.yml) and [Dockerfile](/web/Dockerfile) for more details.