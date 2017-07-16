function gcl
	if string match -r '^[\w\d_-]+/[\w\d_-]+$' $argv[1] > /dev/null
g clone "https://github.com/$argv[1]"
else
g clone $argv
end
end
