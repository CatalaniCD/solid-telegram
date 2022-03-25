source binance.sh

ping

if [ $connected -eq 1 ]
then
  get_timestamp
	echo "$timestamp Connected"
else
	get_timestamp
	echo "$timestamp Not Connected"
fi
