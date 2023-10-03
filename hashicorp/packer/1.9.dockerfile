FROM hashicorp/packer:1.9

# Update and install dependencies
RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk add --no-cache make && \
    # Add any specific packages you need to install here, e.g., apk add --no-cache git
    rm -rf /var/cache/apk/*

# Create a new user and set the working directory
RUN adduser -D -u 1000 appuser
WORKDIR /home/appuser

# Switch to the new user
USER appuser
