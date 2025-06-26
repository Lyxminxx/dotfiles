#!/bin/bash

LAT="59.28245"
LON="9.26547"
URL="https://www.yr.no/en/forecast/daily-table/${LAT},${LON}"

xdg-open "$URL"
