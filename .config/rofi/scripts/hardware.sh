notify-send " System Stats" \
"CPU Temp: $(sensors | grep 'Tctl:' | awk '{print $2}')  
SSD Temp: $(sensors | grep 'Composite:' | awk '{print $2}')  
Fan Speed: $(sensors | grep -m1 'fan1:' | awk '{print $2, $3}')"

