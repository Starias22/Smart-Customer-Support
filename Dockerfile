# Use an official Apache Airflow runtime as a parent image
FROM apache/airflow:2.9.3-python3.12

# Install dependencies as root user
USER root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    xvfb \
    libxi6 \
    libgconf-2-4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxi6 \
    libxtst6 \
    libappindicator1 \
    libdbusmenu-glib4 \
    libdbusmenu-gtk4 \
    libxrandr2 \
    libasound2 \
    fonts-liberation \
    libxss1 \
    libxtst6 \
    xdg-utils

RUN apt-get update && apt-get install -y wget
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y google-chrome-stable 



RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         openjdk-17-jre-headless \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
USER airflow
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64


# Upgrade pip and install required Python packages
RUN pip install --upgrade pip && \
    pip install apache-airflow-providers-apache-spark  chromadb sentence-transformers

