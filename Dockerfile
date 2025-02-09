# Use the official Python 3.10 slim image
FROM python:3.10-slim

# Install system dependencies needed by MinerU
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1-mesa-glx \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory to /app
WORKDIR /app

# Copy our Flask app code into the container
COPY app.py .

# Upgrade pip and install required Python packages
RUN pip install --upgrade pip
# Install MinerU (with full extras) and Flask
RUN pip install "magic-pdf[full]" --extra-index-url https://wheels.myhloli.com
RUN pip install Flask

# Set the environment variable for Cloud Run to use port 8080
ENV PORT 8080
EXPOSE 8080

# Start the Flask application
CMD ["python", "app.py"]
