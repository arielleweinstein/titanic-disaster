# Titanic-Disaster

### Welcome!
Welcome to the Titanic Disaster survival predictor. This repo will take existing data on passengers and whether they survived the disaster and use it to train a model that will predict survival of potential passengers using Logistic Regression in both Python and R.

### Data
This project is built off of data from the Kaggle website. To run it, you will need to download the train.csv and test.csv files from the link below:
[Data](https://www.kaggle.com/competitions/titanic/data)

### Run this repo
This repo contains two Dockerfiles - one for the Python scripts and one for R. In order to run this, you will have to build two Docker containers. This means you will have to have Docker installed, which you can download [here](https://docs.docker.com/get-docker/). 

The following commands should be run in the Terminal or command prompt to build the Docker containers:
```bash
docker build -t titanic-python -f src/python/Dockerfile .
docker build -t titanic-r -f src/r/Dockerfile .
```
This allows you to run both the Python and R scripts using the following commands:
```bash
docker run --rm titanic-python
docker run --rm titanic-r
```