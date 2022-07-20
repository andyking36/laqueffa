#!/usr/bin/expect
# SSH the other rpi
scp -r /home/pi/Desktop/external_pi pi@192.168.20.2:/home/pi
expect "(yes/no)? "
send "yes\r"
expect "password: "
echo raspberry
sudo ssh 192.168.20.2:
echo yes
echo raspberry



