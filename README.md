# selenium-hub
Combination of virtual machines, docker containers and local selenium-server to set up a selenium-hub with firefox, chrome, internet explorer and safari on a MAC.
# prerequisite
Docker-machine with these tcp ports forwarded to local machine 5555, 4444, 5553
```
./open-docker-port.sh tcp 4444
./open-docker-port.sh tcp 5555
./open-docker-port.sh tcp 5553
```
Safari installed with the Selenium driver located here:

http://selenium-release.storage.googleapis.com/2.48/SafariDriver.safariextz
# usage
This will start the selenium-hub and all the browsers.
```
./run.sh [<interface-of-public-ip>]
```
