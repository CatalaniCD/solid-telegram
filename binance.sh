#!/bin/sh
log_file="testing.log"

get_timestamp(){
	timestamp="[$(date +%m-%d-%Y\ %T.%6N)] - "
}

logger(){
	get_timestamp
	echo $timestamp $1 >> $log_file
}

test_resp(){
	if [ -z $resp ]
	then
		status="ERROR"
	else
		status="OK"
	fi
}

request(){
	resp=$(curl -s $1)
	code=$?
	test_resp
	logger "[url] : $url || [resp] : $status || [exit code] : $code "
}

test_connection(){
	if [ $1 -eq 0 ]
	then
		connected=1
		logger "[Connection Status] : $connected"
	else
		connected=0
		logger "[Connection Status] : $connected"
	fi
}

test_ticker(){
	if [ -z $resp ]
	then
		logger "[Ticker $1] : None"
	else
		resp=$($resp| jq -r .price)
		logger "[Ticker $1] : $resp"
	fi
}


spot_ping(){
	url='https://api.binance.com/api/v3/ping'
	request $url
	test_connection $code
}

futures_ping(){
	url='https://api.binance.com/fapi/v1/ping'
	request $url
	test_connection $code
}

get_spot_ticker(){
	url="https://api.binance.com/api/v3/ticker?symbol=$1"
	request $url
	test_ticker $1
}

get_futures_ticker(){
	# check url
	url="https://api.binance.com/api/v3/ticker?symbol=$1"
	request $url
	test_ticker $1
}

get_partial_balance(){
	#args symbol
	logger "getting partial balance for symbol"
}

get_spot_balance(){
	logger "getting spot balance"
}

place_market_order(){
	# args symbol, amount, side
	logger "placing market order : $1, $2 ,$3 USDT"
}

place_limit_order(){
	# args symbol, side, price, amount
	logger "placing limit order : $1, $2 ,$3, $4 USDT"
}

place_stop_loss_order(){
	logger "placing stop loss order for $1 position"
}
