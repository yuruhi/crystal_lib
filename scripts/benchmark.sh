readme="./benchmarks/README.md"
echo -e "# benchmark results\n" > $readme

for file in `find ./benchmarks -name "*.cr"`; do
	echo $file
	url=https://github.com/yuruhi/crystal_lib/blob/master/${file#./}

	result=`crystal $file --release`
	cat - <<- EOS >> $readme
	## [${file#./benchmarks/}]($url)

	\`\`\`
	$result
	\`\`\`

	EOS
done
