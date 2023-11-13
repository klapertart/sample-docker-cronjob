FROM ubuntu:20.04

# Install cron
RUN apt-get update && apt-get -y install cron

RUN apt-get -y install net-tools

RUN apt-get -y install iputils-ping

RUN apt-get -y install expect

RUN apt-get -y install openssh-server

# Copy bash file to working directory
COPY ssh-centos.sh /app/

# Change file mode to executable file
RUN chmod +x /app/ssh-centos.sh

# Copy the cron file to the container
COPY cronfile /etc/cron.d/cronfile

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cronfile

# Apply the cron job
RUN crontab /etc/cron.d/cronfile

# Start the cron daemon in the foreground
CMD ["cron", "-f"]
