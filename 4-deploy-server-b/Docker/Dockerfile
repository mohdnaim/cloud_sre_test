# Use this base image
FROM nginx:1.19.0

# Install curl for troubleshooting
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

# Copy our static files in html/ into the docker image
COPY html /usr/share/nginx/html
