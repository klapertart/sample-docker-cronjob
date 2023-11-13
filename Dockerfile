FROM ubuntu:20.04

# Install cron
RUN apt-get update && apt-get -y install cron

RUN apt-get -y install net-tools iputils-ping expect openssh-server nano

# Set working directory
WORKDIR /app

# Copy bash file to working directory
COPY ssh-centos.sh /app
COPY ssh-ubuntu.sh /app

# Change file mode to executable file
RUN chmod +x /app/ssh-centos.sh
RUN chmod +x /app/ssh-ubuntu.sh

# Copy the cron file to the container
COPY cronfile /etc/cron.d/cronfile

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cronfile

# Apply the cron job
RUN crontab /etc/cron.d/cronfile

# Start the cron daemon in the foreground
CMD ["cron", "-f"]
