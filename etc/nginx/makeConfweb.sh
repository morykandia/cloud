#!/bin/bash
sed -e "s/MONNOM/$1/" -e "s/NOMDOMAIN/$2/" /etc/nginx/templateSite > /etc/nginx/sites-enabled/$2
