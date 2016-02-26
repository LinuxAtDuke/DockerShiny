docker-shiny
============

R, Shiny and Shiny-Server in a Docker container.

Usage
-----

Build the image:

    docker build --pull -t shiny-server .  # <-- don't forget this period on the end

Run:

Option 1)

This assumes you have a shiny-server app on your computer, and you'll be mounting it into the running container.

    docker run -p 3838:3838 --v /path/to/your/shiny-app:/srv/shiny-server/shiny-app -d shiny-server


Option 2)

This second option adds your shiny-server app into the image for the container directly before running it.

Place your shiny server app in a directory alongside the Dockerfile contained in this repo, and then open the Dockerfile and edit uncomment the line here:

    ##### UNCOMMENT HERE TO ADD YOUR SHINY APP #####
    # ADD your_shiny_app_dir /srv/shiny-server/your_shiny_app_dir

Make sure to replace the "your_shiny_app_dir" with the actual name of your app dir \(it occurs twice above\).
 
The build the image as above, and run without the volume mapping:

    docker build --pull -t shiny-server .  # <-- don't forget this period on the end
    docker run -p 3838:3838 -d shiny-server


When your shiny server container is running, you can navigate to http://your_hostname:3838 to view your shiny apps.


Issues
------

Tracked Here: https://gitlab.oit.duke.edu/clc0317/docker-shiny/issues

