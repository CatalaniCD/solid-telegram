#!/bin/sh
log_file="testing.log"

get_timestamp(){
	timestamp="[$(date +%m-%d-%Y\ %T.%6N)] :"
}

request(){
	resp=$(curl -s $1)
	code=$?
}

logger(){
	get_timestamp
	echo $timestamp $1 >> $log_file
}

ping(){
	logger " >>> Performing a ping in the binance server"
	request 'https://api.binance.com/api/v3/ping'
	if [ $code -eq 0 ]
	then
		connected=1
		logger "Request Failure with exit code $code"
	else
		connected=0
		logger "Request Success with exit code $code"
	fi
}

get_ticker(){
	logger " >>> Requesting ticker price for symbol $1"
	request "https://api.binance.com/api/v3/ticker?symbol=$1"
	resp=$($resp | jq -r .price)
	logger "Exit code $code"
}

get_partial_balance(){
	logger "getting partial balance"
}

get_spot_balance(){
	logger "getting spot balance"
}

place_market_order(){
	logger "placing market order with $1 USDT"
}

place_limit_order(){
	logger "placing limit order with $1 USDT"
}

place_stop_loss_order(){
	logger "placing stop loss order for $1 position"
}
