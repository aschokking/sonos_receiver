#!/bin/bash
LAST=0
while true
do
    echo "Testing for sonos playing"
    curl -s "http://localhost:5005/LivingRoom/state" | grep '"playbackState":"PLAYING"'
    OUT=$?
    
    if [ $OUT -eq 0 ]; then
	if [ $OUT -ne $LAST ]; then
	    echo "**** Sonos playing, switching to CD"
	    irsend SEND_ONCE Onkyo_RC-710M KEY_CD
	fi
    else
	if [ $OUT -ne $LAST ]; then
	    echo "######## Sonos not playing, switching to Game/TV ########"
	    #irsend SEND_ONCE Onkyo_RC-710M Game/TV
	    irsend SEND_ONCE Onkyo_RC-710M KEY_AUX
	else
	    echo "######## Sonos not playing, but value unchanged so leaving status quo ########"
	fi
    fi
    LAST=$OUT
    sleep 2
done
