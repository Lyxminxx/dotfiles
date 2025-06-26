#!/usr/bin/env python3
import os
import json
from urllib import request, error
from dotenv import load_dotenv

def get_weather():
    load_dotenv()
    url = os.getenv("URL")
    user_agent = os.getenv("USER_AGENT")
    headers = {
        "User-Agent": user_agent
    }

    req = request.Request(url, headers=headers)
    
    try:
        with request.urlopen(req) as response:
            data = json.loads(response.read())
            timeseries = data['properties']['timeseries'][0]['data']
            details = timeseries['instant']['details']
            airtemp = details.get('air_temperature', None)
            symbol = data['properties']['timeseries'][0]['data']['next_1_hours']['summary']['symbol_code']
    except (error.HTTPError, error.URLError, KeyError, IndexError, json.JSONDecodeError):
        airtemp = None
        symbol = None

    return {"airtemp": airtemp, "symbol": symbol}

symbol_icons = {
    "clearsky_day": "",
    "clearsky_night": "",
    "cloudy": "",
    "fair_day": "",
    "fair_night": "",
    "fog": "",
    "heavyrain": "",
    "lightrain": "",
    "partlycloudy_day": "",
    "partlycloudy_night": "",
    "rain": "",
    "snow": "",
    "heavysnow": "",
    "lightsnow": "",
    "sleet": "",
    "rainshowers_day": "",
    "rainshowers_night": "",
}

weather = get_weather()

if weather["airtemp"] is not None:
    icon = symbol_icons.get(weather["symbol"], "")  # fallback icon
    print(f"{icon} {round(weather['airtemp'])}°C")
else:
    print("Weather N/A")
