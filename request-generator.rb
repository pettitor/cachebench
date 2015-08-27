#!/usr/bin/ruby
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'ostruct'
require 'pp'
require 'open3'

require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class Parser
	def self.parse(args)
		options = OpenStruct.new
		options.n = 10
		options.r = 0.1
		options.a = 0.8
		
		opt_parser = OptionParser.new do |opts|
			opts.banner = "Usage: ./request-generator.rb [options]"

	    		opts.on('-n', '--number #REQUESTS', 'Number of requests') { |v| options.n = v}
	  		opts.on('-r', '--rate RATE', 'Request rate per second') { |v| options.r = v }
			opts.on('-a', '--alpha ALPHA', 'Zipf exponent alpha') { |v| options.a = v }
			opts.on("-h", "--help", "Prints this help") do
	  	              puts opts
			      exit
			end
          	end

	  	opt_parser.parse!(args)
	  	return options
	end
end
#options = Parser.parse %w[--help]
options = Parser.parse(ARGV)

#pp options

vids = Array.new

doc = Nokogiri::HTML(open("https://vimeo.com/channels/sort:followers"))

links = doc.css('div.boxed a').map { |link| link['href'] }
links.each do |link|
	print "https://vimeo.com/api/v2/#{link.sub(/\/channels/,"channel")}/videos.xml\n"
	chdoc = Nokogiri::XML(open("https://vimeo.com/api/v2/#{link.sub(/\/channels/,"channel")}/videos.xml"))
	vlinks = chdoc.css('video url')
	vlinks.each do |vlink|
#		print "#{vlink.content}\n"
		vids << vlink.content
	end
end
#vids.each { |a| print a, "\n" }

ps = (1..vids.length).to_a
ps.map!{|p| Math.exp(-options.a.to_f * Math.log(p)) }
sum = 0
ps.map!{|p| sum += p}
ps.map!{|p| p/ps.last}
#ps.each{|p| print "#{p} "}

for i in 1..options.n.to_i
	id = ps.index{|p| p > rand}
	puts "Downloading video #{vids[id]} ..."
	#puts "youtube-dl -o \"%(title)s-%(id)s-#{i}.%(ext)s\" #{vids[id]}"
	stdin, stdout, stderr = Open3.popen3("youtube-dl -o \"%(title)s-%(id)s-#{i}.%(ext)s\" #{vids[id]}")
	sleep(-Math.log(rand)/options.r.to_f)
	stderr.readlines
	stdout.readlines
end
