# Use Python 3.10 slim base image
FROM python:3.10-slim

# Environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install required system packages
RUN apt-get update && apt-get install -y gcc && rm -rf /var/lib/apt/lists/*

# Copy only requirement files first to cache better
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy entire project
COPY . .

# Expose port
EXPOSE 8000

# Start app using Gunicorn
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8000"]
