FROM debian:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat && \
    rm -rf /var/lib/apt/lists/*

# Add the PATH environment variable
ENV PATH=$PATH:/usr/games/

# Copy over the shell script
COPY wisecow.sh app/wisecow.sh

# Set the working directory
WORKDIR /app

# Set the permission to execute the script
RUN chmod +x wisecow.sh

# Expose port 4499
EXPOSE 4499

# Run the shell script on container startup
CMD [ "bash", "/app/wisecow.sh" ]

