# cachebench

Generate requests gets video ids from popular vimeo channels and downloads them according to the secified rate and popularity distribution with Zipf exponent alpha.

youtube-dl is required to download the videos. More information on https://rg3.github.io/youtube-dl/ .
Installation on debian / ubuntu:
```
sudo apt-get install youtube-dl
```

Ruby script must be executable:

```
chmod +x generate-requests.rb
./generate-requests
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

