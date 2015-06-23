# cachebench

Generate requests by getting video ids from popular vimeo channels and downloading them according to the secified rate and popularity distribution with Zipf exponent alpha.

youtube-dl is required to download the videos. More information on https://rg3.github.io/youtube-dl/ .
Installation on debian / ubuntu:
```
sudo apt-get install youtube-dl
```

Ruby script must be executable:

```
chmod +x generate-requests.rb
```
The following command generates 5 requests with average rate 0.5/sec and with Zipf parameter alpha=0.8.
```
./generate-requests.rb -n 5 -r 0.5 -a 0.8
```

Usage:
```
./generate-requests.rb --help
Usage: ./request-generator.rb [options]
    -n, --number #REQUESTS           Number of requests
    -r, --rate RATE                  Request rate
    -a, --alpha ALPHA                Zipf exponent alpha
    -h, --help                       Prints this help
```

