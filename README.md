docker-selenium
===============

Docker image containing selenium (`2.48`) and the google chrome driver (`2.20`)

## Usage

One liner: `docker run -it -p 4444:4444 danielfrg/selenium`

Selenium UI is available at:
[http://DOCKERHOST:4444/wd/hub/static/resource/hub.html](http://DOCKERHOST:4444/wd/hub/static/resource/hub.html)

You should be able to click the "Create session" button and select "chrome"

## Example on python

Using the `selenium` python library you can do like this
[example](http://nbviewer.ipython.org/github/danielfrg/docker-selenium/blob/master/example/notebook.ipynb)
