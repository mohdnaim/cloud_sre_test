# base image
FROM nginx:1.19.0

# install curl for troubleshooting
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*
