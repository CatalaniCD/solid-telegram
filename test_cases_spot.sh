
source binance.sh

# test cases
rm $log_file
touch $log_file

# connection
logger "[Test Case] : Spot Connection"
spot_ping

#get ticker
logger "[Test Case] : Spot Get Ticker"
get_spot_ticker BTCUSDT

logger "[Test Case] : get_spot_exchange"
get_spot_exchange
select_symbol_spec BTCUSDT

echo "Specifications ~~~> $spec"

logger "[Test Case] : get_spot_spec"
get_spot_spec BTCUSDT

echo "Response ~~~> $resp"
# echo $price
