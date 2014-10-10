FROM ubuntu:14.04
MAINTAINER Daniel Rodriguez

ADD https://dl-ssl.google.com/linux/linux_signing_key.pub /tmp/google.pub
RUN cat /tmp/google.pub | apt-key add -; rm /tmp/google.pub
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list
RUN mkdir -p /usr/share/desktop-directories

RUN apt-get -y update && apt-get install -y \
    unzip \
    google-chrome-stable \
    openjdk-7-jre-headless \
    xvfb \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-scalable \
    xfonts-cyrillic

# Disable the SUID sandbox so that chrome can launch without being in a privileged container
RUN dpkg-divert --add --rename --divert /opt/google/chrome/google-chrome.real /opt/google/chrome/google-chrome
RUN echo "#!/bin/bash\nexec /opt/google/chrome/google-chrome.real --disable-setuid-sandbox \"\$@\"" > /opt/google/chrome/google-chrome
RUN chmod 755 /opt/google/chrome/google-chrome

RUN mkdir -p /opt/selenium
ADD http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar /opt/selenium/selenium-server-standalone.jar

ADD http://chromedriver.storage.googleapis.com/2.10/chromedriver_linux64.zip /opt/selenium/chromedriver_linux64.zip
RUN cd /opt/selenium; unzip /opt/selenium/chromedriver_linux64.zip; rm -rf chromedriver_linux64.zip;

ENV DISPLAY :20
COPY entrypoint.sh /opt/selenium/entrypoint.sh

EXPOSE 4444
CMD ["sh", "/opt/selenium/entrypoint.sh"]
