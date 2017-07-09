function cloc
	if [ (count $argv) = 0 ]
set argv .
end
command cloc --exclude-dir node_modules,dist --exclude-ext json $argv
end
