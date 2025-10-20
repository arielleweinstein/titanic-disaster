# Use an official Python image as the base
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app/code_run

# Copy your code and requirements into the container
COPY src/code_run/ ./      
COPY requirements.txt ../

# Install dependencies
RUN pip install --no-cache-dir -r ../requirements.txt

# Run the app
CMD ["python", "app.py"]
