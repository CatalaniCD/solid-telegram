source binance.sh


# Balance request

echo -n "" | openssl dgst -sha256 -hmac "T0Er7UPAbhy4Pl7mPUeT4W3xsyGtDGcpHlGG3qDklO2uf5VaHJFWiXL7mYi0D7TO"

curl -H "X-MBX-APIKEY: p6RgZthI6O40YQdCtLB43qiUGKrLILObo83nLoLq0aYpTDlRaEGFOsCIadcZFCYc" "https://api.binance.com/sapi/v1/accountSnapshot"
