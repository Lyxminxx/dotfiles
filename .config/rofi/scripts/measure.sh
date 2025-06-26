#!/bin/bash

# Choose the conversion type
choice=$(printf "Meters to Feet\nFeet to Meters\nKilograms to Pounds\nPounds to Kilograms\nCelsius to Fahrenheit\nFahrenheit to Celsius\nLiters to Gallons\nGallons to Liters" | rofi -dmenu -p "Convert")

[[ -z "$choice" ]] && exit

# Get the value to convert
value=$(rofi -dmenu -p "Enter value")
[[ -z "$value" ]] && exit

# Make sure it's a number
if ! [[ "$value" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
  notify-send "Conversion Failed" "Invalid number input: '$value'"
  exit 1
fi

# Calculate the result
case "$choice" in
  "Meters to Feet")
    result=$(echo "$value * 3.28084" | bc -l)
    unit="ft"
    ;;
  "Feet to Meters")
    result=$(echo "$value / 3.28084" | bc -l)
    unit="m"
    ;;
  "Kilograms to Pounds")
    result=$(echo "$value * 2.20462" | bc -l)
    unit="lb"
    ;;
  "Pounds to Kilograms")
    result=$(echo "$value / 2.20462" | bc -l)
    unit="kg"
    ;;
  "Celsius to Fahrenheit")
    result=$(echo "($value * 9/5) + 32" | bc -l)
    unit="°F"
    ;;
  "Fahrenheit to Celsius")
    result=$(echo "($value - 32) * 5/9" | bc -l)
    unit="°C"
    ;;
  "Liters to Gallons")
    result=$(echo "$value * 0.264172" | bc -l)
    unit="gal"
    ;;
  "Gallons to Liters")
    result=$(echo "$value / 0.264172" | bc -l)
    unit="L"
    ;;
esac

# Format and show the result as a notification
formatted_result=$(printf "%.3f" "$result")
notify-send "Conversion Result" "$value → $formatted_result $unit"

