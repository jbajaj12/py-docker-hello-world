# Use the latest stable Python image
FROM python:3.11-slim

# Copy Datadog init from the official image (ensure using the latest version of the image)
COPY --from=datadog/serverless-init:latest /datadog-init /app/datadog-init

# Disable Python output buffering to ensure logs are written immediately to stdout/stderr
# This is useful for real-time logging in containerized environments like Docker.
ENV PYTHONUNBUFFERED=True 


# Set the working directory
WORKDIR /app

# Copy application files
COPY requirements.txt app.py /app/

# Upgrade pip and install dependencies from requirements.txt
RUN python -m pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Set Datadog environment variables
ENV DD_SERVICE=datadog-demo-run-python \
    DD_ENV=datadog-demo \
    DD_VERSION=1

# Grant execute permissions to the Datadog init script so it can run properly
RUN chmod +x /app/datadog-init

# Set the entrypoint and default command
ENTRYPOINT ["/app/datadog-init"]
CMD ["ddtrace-run", "python", "app.py"]
