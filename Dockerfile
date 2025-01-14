# Use the latest stable Python image
FROM python:3.11-slim

# Copy Datadog init from the official image (ensure using the latest version of the image)
COPY --from=datadog/serverless-init:latest /datadog-init /app/datadog-init

# Set Python to output logs unbuffered
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

# Ensure the Datadog init script is executable
RUN chmod +x /app/datadog-init

# Set the entrypoint and default command
ENTRYPOINT ["/app/datadog-init"]
CMD ["ddtrace-run", "python", "app.py"]
