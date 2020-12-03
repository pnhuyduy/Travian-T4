#!/bin/bash
#This script run every 1 seconds
while (sleep 1 && php /home/mytravianx/public_html/tx500/GameEngine/Automation.php) &
do
  wait $!
done