FROM selenium/node-chrome
RUN sudo grep -v 5555 /opt/selenium/config.json > /tmp/config.json
RUN sudo mv /tmp/config.json /opt/selenium/config.json
