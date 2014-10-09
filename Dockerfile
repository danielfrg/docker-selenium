FROM ubuntu:14.04

ADD https://dl-ssl.google.com/linux/linux_signing_key.pub /tmp/google.pub
RUN cat /tmp/google.pub | apt-key add -; rm /tmp/google.pub
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list
RUN mkdir -p /usr/share/desktop-directories

RUN apt-get -y update && apt-get install -y \
    google-chrome-stable \
    openjdk-7-jre-headless \
    xvfb \
    unzip

RUN mkdir -p /opt/selenium
ADD http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar /opt/selenium/selenium-server-standalone.jar

ADD http://chromedriver.storage.googleapis.com/2.10/chromedriver_linux64.zip /opt/selenium/chromedriver_linux64.zip
RUN cd /opt/selenium; unzip /opt/selenium/chromedriver_linux64.zip; rm -rf chromedriver_linux64.zip;

ENV DISPLAY :20
COPY entrypoint.sh /opt/selenium/entrypoint.sh

EXPOSE 4444
CMD ["sh", "/opt/selenium/entrypoint.sh"]
