# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary tools
RUN apt update && \
    apt install -y procps coreutils curl openssh-server && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Set root password for SSH
RUN echo 'root:rootpassword' | chpasswd

# Enable root login via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Ensure /run/sshd directory exists and has the correct permissions
RUN mkdir -p /run/sshd && chmod 0755 /run/sshd

# Copy the server-stats.sh script
COPY server-stats.sh /usr/local/bin/server-stats.sh

# Make the script executable
RUN chmod +x /usr/local/bin/server-stats.sh

# Ensure the script runs when the container starts
CMD /usr/local/bin/server-stats.sh && /usr/sbin/sshd -D
