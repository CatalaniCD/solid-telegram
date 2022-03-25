
source binance.sh

# test cases
rm $log_file
touch $log_file

# connection
logger "[Test Case] : Spot Connection"
spot_ping

logger "[Test Case] : Futures Connection"
futures_ping

#get ticker
logger "[Test Case] : Spot Get Ticker"
get_spot_ticker BTCUSDT
