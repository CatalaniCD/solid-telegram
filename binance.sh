#!/bin/sh
get_timestamp(){
	timestamp=[$(date +%m-%d-%Y\ %T.%6N)]
}

request(){
	resp=$(curl -s $1)
	code=$?
}

ping(){
	get_timestamp
	echo "$timestamp : Perfoming a ping in the binance server" >> test.log
	request 'https://api.binance.com/api/v3/ping'
	if [ $code -eq 0 ]
	then
		connected=1
		get_timestamp
		echo "$timestamp : Request Failed with exit code" $code >> test.log
	else
		connected=0
		get_timestamp
		echo "$timestamp : Success Failed with exit code" $code >> test.log
	fi
}

get_ticker(){
	get_timestamp
	echo "$timestamp Requesting ticker price for symbol" $1
	request "https://api.binance.com/api/v3/ticker?symbol=$1"
	resp=$($resp | jq -r .price)
	get_timestamp
	echo "$timestamp : Exit Code" $code >> test.log
}
