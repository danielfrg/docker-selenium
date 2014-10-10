Xvfb :20 -screen 0 1366x768x16 -ac &
java -jar /opt/selenium/selenium-server-standalone.jar -Dwebdriver.chrome.driver=/opt/selenium/chromedriver
