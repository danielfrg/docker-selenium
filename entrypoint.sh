Xvfb :20 -shmem -screen 0 1366x768x16 &
google-chrome --no-sandbox --remote-debugging-port=9222 &
java -jar /opt/selenium/selenium-server-standalone.jar -Dwebdriver.chrome.driver=/opt/selenium/chromedriver
