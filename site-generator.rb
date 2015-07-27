#!/usr/bin/ruby
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'ostruct'
require 'pp'
require 'open3'
	  

#options = Parser.parse %w[--help]
#pp options

vids = Array.new
titles = Array.new

doc = Nokogiri::HTML(open("https://vimeo.com/channels/sort:followers"))

links = doc.css('div.boxed a').map { |link| link['href'] }
links.each do |link|
#	print "https://vimeo.com/api/v2/#{link.sub(/\/channels/,"channel")}/videos.xml\n"
	chdoc = Nokogiri::XML(open("https://vimeo.com/api/v2/#{link.sub(/\/channels/,"channel")}/videos.xml"))
	vlinks = chdoc.css('video url')
	vlinks.each do |vlink|
#		print "#{vlink.content}\n"
		vids << vlink.content
	end
  vtitles = chdoc.css('video title')
	vtitles.each do |vtitle|
#		print "#{vlink.content}\n"
		titles << vtitle.content
	end
end

print "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n
<html xmlns=\"http://www.w3.org/1999/xhtml\" itemscope=\"\" itemtype=\"http://schema.org/WebPage\">\n
<head>\n
<meta name=\"title\" content=\"SmartenIT Vimeo Collection\" />\n
<style type=\"text/css\">\n
</style>\n
<title>SmartenIT Vimeo Collection</title>\n
</head>\n
<link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.gstatic.com/sites/p/e8d0d8/system/app/themes/iceberg/standard-css-iceberg-ltr-ltr.css\" />\n
<link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.smartenit.eu/_/rsrc/1434983344000/system/app/css/overlay.css?cb=iceberg1a150goog-ws-leftnone30themedefaultstandard\" />\n
<link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.smartenit.eu/_/rsrc/1434983344000/system/app/css/camelot/allthemes-view.css\" />\n"

#print "<body xmlns=\"http://www.google.com/ns/jotspot\" id=\"body\" class=\"en\">\n"
print "<body>\n"

print "<div id=\"sites-page-toolbar\" class=\"sites-header-divider\">
<div xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sites-status\" class=\"sites-status\" style=\"display:none;\"><div id=\"sites-notice\" class=\"sites-notice\" role=\"status\" aria-live=\"assertive\"> </div></div>
</div>
<div id=\"sites-chrome-everything-scrollbar\">
<div id=\"sites-chrome-everything\" class=\"\">
<div id=\"sites-chrome-page-wrapper\" style=\"direction: ltr\">
<div id=\"sites-chrome-page-wrapper-inside\">"

print "
<div xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sites-chrome-header-wrapper\" style=\"height:auto;\">
<table id=\"sites-chrome-header\" class=\"sites-layout-hbox\" style=\"height:auto;\" cellspacing=\"0\">\n
<tbody><tr class=\"sites-header-primary-row\" id=\"sites-chrome-userheader\">\n
<td id=\"sites-header-title\" class=\"\" role=\"banner\"><div class=\"sites-header-cell-buffer-wrapper\"><a href=\"http://www.smartenit.eu/\" id=\"sites-chrome-userheader-logo\"><img id=\"logo-img-id\" src=\"http://www.smartenit.eu/_/rsrc/1352298266299/config/customLogo.gif?revision=2\" alt=\"SmartenIT\" class=\"sites-logo  \"></a><h2></h2></div></td>
</tr>\n
</tbody>\n
</table>\n
</div>\n"

#print "<table style=\"height:auto;\" cellspacing=\"0\">\n
#<tbody><tr>\n
#<td role=\"banner\"><div><a href=\"http://www.smartenit.eu/\" src=\"http://www.smartenit.eu/_/rsrc/1352298266299/config/customLogo.gif?revision=2\" alt=\"SmartenIT\" \"></a><h2></h2></div></td>
#</tr>\n
#</tbody>\n
#</table>\n"

print "<div id=\"sites-chrome-main-wrapper\">"

print "<div id=\"sites-chrome-main\" class=\"sites-chrome-main\">"

vids.each_with_index do |link, i|
  print "<iframe src=\"https://player.vimeo.com/video/#{link.sub(/https:\/\/vimeo.com\//,"")}?color=CCCCCC&title=0&byline=0&portrait=0&badge=0\" width=\"500\" height=\"281\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href=\"#{link}\">#{titles[i]}</a> on <a href=\"https://vimeo.com\">Vimeo</a>.</p>\n"
end

print "</div>"

print "</div></div></div></div>"

print "</body>"
