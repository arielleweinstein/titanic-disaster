FROM rocker/r-base:4.3.1

# set the working directory
WORKDIR /app

#Copy everything into the container
COPY src/ /app/src/
COPY install_packages.R /app/

#Install packages
RUN Rscript install_packages.R

# Run the app
CMD ["Rscript", "analysis.R"]