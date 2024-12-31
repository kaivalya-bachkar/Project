# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables to ensure Python output is not buffered
ENV PYTHONUNBUFFERED 1

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies (update, upgrade is not required in docker)
RUN apt-get update && apt-get install -y \
    python3-venv \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python3 -m venv /app/venv

# Activate virtual environment and install dependencies
ENV VIRTUAL_ENV=/app/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install Flask, boto3, and gunicorn
RUN pip install Flask boto3 gunicorn

# Download the app script from GitHub (assuming it's public)
RUN wget https://raw.githubusercontent.com/kaivalya-bachkar/Project/refs/heads/main/App/app.py -O /app/app.py

# Expose the port where the Flask app will run
EXPOSE 5000

# Run the application using gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
