#!/bin/bash

#moving files
cd /ApacheConfig && mv *.jeroenvd.nl /etc/apache2/sites-enabled

# Start apache
/usr/sbin/apache2 -D FOREGROUND
