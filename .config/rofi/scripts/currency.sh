#!/bin/bash

# Select the source currency
from=$(echo -e "USD\nEUR\nGBP\nNOK\nJPY\nCAD\nAUD\nSEK" | rofi -dmenu -p "From Currency")
[ -z "$from" ] && exit 1

# Select the target currency
to=$(echo -e "USD\nEUR\nGBP\nNOK\nJPY\nCAD\nAUD\nSEK" | rofi -dmenu -p "To Currency")
[ -z "$to" ] && exit 1

# Enter amount
amount=$(rofi -dmenu -p "Amount in $from")
if ! [[ $amount =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    notify-send "Invalid amount"
    exit 1
fi

# Fetch conversion using Frankfurter API
response=$(curl -s "https://api.frankfurter.app/latest?from=$from&to=$to&amount=$amount")

converted=$(echo "$response" | jq -r ".rates.$to")

if [ "$converted" == "null" ] || [ -z "$converted" ]; then
    notify-send "Failed to fetch conversion result"
    exit 1
fi

notify-send "Currency Converter" "$amount $from = $converted $to"

