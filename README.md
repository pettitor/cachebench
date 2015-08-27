# cachebench

Generate requests by getting video ids from popular vimeo channels and downloading them according to the specified rate and popularity distribution with Zipf exponent alpha.

youtube-dl is required to download the videos. More information on https://rg3.github.io/youtube-dl/ .
Installation on debian / ubuntu:
```
sudo apt-get install youtube-dl
```
Install ruby and libraries necessary, if not available on the system. In case of ubuntu you can try the following:

```
sudo apt-get install ruby1.9
sudo apt-get install libxslt-dev libxml2-dev zlib1g-dev
```

The following library is required by the Ruby script for XML parsing:
```
gem install nokogiri
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
    -r, --rate RATE                  Request rate per second
    -a, --alpha ALPHA                Zipf exponent alpha
    -h, --help                       Prints this help
```

