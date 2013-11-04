#!/bin/sh
cat /dev/null > all.md
section=''
cat 'Contents.md' | while read line
do
	#echo "Line: $line"
	if [[ "$line" = '## '* ]]
	then
		section=`echo $line | awk -F '## ' '{print $2}'`
		echo "# **${section^^}**" >> all.md
		#echo "% $section" >> all.md
		echo -e "\n\n\n\n" >> all.md
	elif [ "$line" = '' ]
	then
		section=''
	elif [[ "$line" = '-'* ]]
	then
		file=`echo $line | awk -F '- ' '{print $2}'`
		if [ "$section" != '' ] && [ "$section" != 'Appendix' ]
		then
			cat "$section"'/'"$file"'.md' >> all.md
			#echo 'cat' "$section'/'$file'.md'" '>> all.md'
		else
			cat "$file"'.md' >> all.md
			#echo 'cat' "$file'.md'" '>> all.md'
		fi
		echo -e "\n\n\n\n" >> all.md
	fi
done
topdf all.md
