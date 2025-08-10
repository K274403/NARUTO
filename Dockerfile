# Use newer Debian version to avoid apt 404 errors
FROM python:3.10-slim-bullseye

# Avoid apt prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install git
RUN apt update && apt upgrade -y && \
    apt install git -y && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first for caching
COPY requirements.txt /requirements.txt

# Install Python dependencies
RUN pip3 install -U pip && pip3 install -U -r /requirements.txt

# Create app directory
RUN mkdir /Safari-Filter-Bot
WORKDIR /Safari-Filter-Bot

# Copy start script
COPY start.sh /start.sh

# Start the bot
CMD ["/bin/bash", "/start.sh"]
