all:
	jekyll --pygments

httpd:
	( cd _site && python -m SimpleHTTPServer 8083 )

