# Titanic-Disaster

### Welcome!
Welcome to the Titanic Disaster survival predictor. This repo will take existing data on passengers and whether they survived the disaster and use it to train a model that will predict survival of potential passengers using Logistic Regression in both Python and R.
![Image of the Titanic](https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/RMS_Titanic_3.jpg/600px-RMS_Titanic_3.jpg)

### Data
This project is built off of data from the Kaggle website. To run it, you will need to download the train.csv and test.csv files from the link below:
[Data](https://www.kaggle.com/competitions/titanic/data)

You will have to create a data folder in the src folder in order for the file paths in the scripts to run properly. As an alternative, you can change the file path code to be able to access train.csv and test.csv without creating additional directories but this will have to be changed for both accessing the data and writing the CSVs. 

Make sure you change the writing CSV lines in the code to write the CSVs to your desired directory.

### CSV Output
The output of these scripts are CSV files that make predictions on whether a passenger will survive given data. The formatting follows Kaggle's submission standards, so the files can be submitted online to Kaggle's competition [here](https://www.kaggle.com/competitions/titanic/overview) by clicking the "Submit Prediction" button in the top right corner.

### Run this repo
This repo contains two Dockerfiles - one for the Python scripts and one for R. In order to run this, you will have to build two Docker containers. This means you will have to have Docker installed, which you can download [here](https://docs.docker.com/get-docker/). The application will also have to be open in order for Docker to be able to build the images and run the Dockerfiles.

The following commands should be run in the Terminal or command prompt to build the Docker images:
```bash
docker build -t titanic-python -f src/python/Dockerfile .
docker build -t titanic-r -f src/r/Dockerfile .
```
This allows you to run both the Python and R scripts using the following commands:
```bash
docker run --rm titanic-python
docker run --rm titanic-r
```
This code will remove the container after it is finished running using the --rm part of the command. If you wish to keep the container, simply delete the --rm or use the commands below:
```bash
docker run titanic-python
docker run titanic-r
```