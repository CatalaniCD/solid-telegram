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
	if [ $code -ne 0 ]
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
	is_json=$(echo $reps | jq empty; echo $?)
	if [ $is_json -eq 0 ] && [ $code -eq 0 ]
	then
		price=$(echo $resp | jq -r '.price')
		logger "[Ticker $1] : $price"
	else
		logger "[Ticker $1] : None"
	fi
}

test_symbol_spec(){
	code=$(echo $spec | jq empty; echo $?)
	if [ $code -eq 0 ]
	then
		logger "[Spec] : OK"
	else
		logger "[Spec] : ERROR"
	fi
}


spot_ping(){
	url='https://api.binance.com/api/v3/ping'
	request $url
	test_connection $code
}

futures_ping(){
	url='https://fapi.binance.com/fapi/v1/ping'
	request $url
	test_connection $code
}

get_spot_ticker(){
	url="https://api.binance.com/api/v3/ticker/price?symbol=$1"
	request $url
	test_ticker $1
}

get_futures_ticker(){
	# check url
	# 'Detected Error to get the symbol'
	url="https://fapi.binance.com/fapi/v1/ticker/price?symbol=$1"
	request $url
	echo $code $resp
	test_ticker $1
}

select_symbol_spec(){
	spec=$(echo $resp | jq ".symbols[] | select(.symbol==\"$1\")")
	test_symbol_spec
}

get_spot_exchange(){
	url="https://api.binance.com/api/v3/exchangeInfo"
	request $url
}

get_futures_exchange(){
	url="https://fapi.binance.com/fapi/v1/exchangeInfo"
	request $url
}

get_spot_spec(){
	url="https://api.binance.com/api/v3/exchangeInfo?symbol=$1"
	request $url
}

get_futures_spec(){
	url="https://fapi.binance.com/fapi/v1/exchangeInfo?symbol=$1"
	request $url
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
