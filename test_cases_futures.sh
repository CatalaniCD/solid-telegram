
source binance.sh

# test cases
rm $log_file
touch $log_file

# connection
logger "[Test Case] : Futures Connection"
futures_ping

#get ticker
logger "[Test Case] : Futures Get Ticker"
get_futures_ticker BTCUSDT

# Case not working yet!
logger "[Test Case] : get_futures_exchange"
get_futures_exchange
select_symbol_spec BTCUSDT
echo "Specifications ~~~> $spec"

# Case not working yet!
logger "[Test Case] : get_futures_spec"
get_futures_spec BTCUSDT

echo "Specifications ~~~> $spec"
# echo $price
