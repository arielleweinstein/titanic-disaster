# Use an official Python image as the base
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy local files into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run the app
CMD ["python", "app.py"]
