#!/bin/bash
set -x
/usr/bin/curl -i 'https://api-stage.amee.com/3.6/categories/DEFRA_transport_fuel_methodology/items;values?fuel=petrol' \
  -H 'Accept: application/json' \
  -u greendreams1:ynzpd69c \
  -s \
  -H 'Origin: http://example.com'
