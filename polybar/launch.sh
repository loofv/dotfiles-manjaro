:!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar1 and bar2
#echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
echo "---" | tee -a /tmp/bar1.log
polybar bar1 2>&1 | tee -a /tmp/bar1.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bar1 &
  done
else
  polybar --reload bar1 &
fi

echo "Bars launched..."
