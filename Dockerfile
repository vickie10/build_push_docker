# Use the latest Ubuntu LTS as the base image
FROM ubuntu:latest

# Update the package lists and install prerequisite packages
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay

# Copy the run.sh file into the container
COPY wisecow.sh /app/wisecow.sh

# Set the working directory
WORKDIR /app

# Make the run.sh script executable
RUN chmod +x /app/wisecow.sh

# Expose port 4499
EXPOSE 4499

# Start the run.sh script when the container starts
CMD ["/app/wisecow.sh"]
