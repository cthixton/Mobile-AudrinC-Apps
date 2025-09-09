#! /bin/bash

#
# Sift through a few gig of Dropbox files to find any not tagged or checked into git, copy apk's to server - 4/7/25 tj
#
# Then find all Xcode projects and builds to produce a working spreadsheet to track with:
#	https://docs.google.com/spreadsheets/d/1AYnUEiHSNKH9FwxHrfE3zSzixrUTcaw1FZl7czlW-F0/edit?usp=sharing
#
#
# APP
#
# /Users/thomasthixton/Dropbox/Projects/Vendors/_Median.co/_Projects/_2025/AudrinC_Mobile_Apps/AudrinC_Mobile_App_Build.sh
#

export CC=$HOME/Dropbox/Projects/Customers;

cd /Users/thomasthixton/Projects

#
#		All projects from Que4 & AudrinC
#
	egrep 'com.audrinc|org.que4' /Users/thomasthixton/Projects/Customers/_?/_*/_Projects/_202?/*-iOS/*.xcodeproj/project.pbxproj | uniq > all.txt
	head all.txt
	echo waiting all... ; echo ' ' ; date ; cat

#
#		Project build IDs greater then 90 days old... 	
#
	find  /Users/thomasthixton/Library/Developer/Xcode/Archives/202[45]*/*.xcarchive -name Info.plist -depth 1 -ctime +90d -print0 | xargs -0 egrep 'com.audrinc\.|org.que4\.' | sed -e 's/<string>//g' -e 's/<\/string>//g' | awk -F: '{print $2}' | tr -d ' \011' | sort | uniq > 90-more.txt
	head 90-more.txt
	echo waiting 90-more... ; echo ' ' ; date ; cat

#
#		Project build IDs less then 90 days old... 	
#
	find  /Users/thomasthixton/Library/Developer/Xcode/Archives/202[45]*/*.xcarchive -name Info.plist -depth 1 -ctime -90d -print0 | xargs -0 egrep 'com.audrinc\.|org.que4\.' | sed -e 's/<string>//g' -e 's/<\/string>//g' | awk -F: '{print $2}' | tr -d ' \011' | sort | uniq > 90-less.txt
	head 90-less.txt
	echo waiting 90-less... ; echo ' ' ; date ; cat

#
#		Clean final 90+ projects list
#
	cat 90-less.txt 90-less.txt 90-more.txt | sort | uniq -u > a.txt ; mv a.txt 90-more.txt

#
#		Project builds directories more then 90 days old... 	
#
	for i in `sort 90-more.txt | head -200` ; do 
		fgrep $i all.txt | sed -e 's/xcodeproj.*/xcworkspace;/'
		done | sort > 90-more-projects.txt
	head 90-more-projects.txt
	echo waiting 90-more-projects... ; cat

	for i in ` sed -e 's/;//' < 90-more-projects.txt` ; do 
		echo $i; D=`dirname $i`; open -a Tower $D; open -a Xcode $i
		echo Do-a-D $i
		date
		cat
		done 



##
## Thomass-MBP-FRESH:Projects thomasthixton$ ( egrep 'com.audrinc|org.que4' /Users/thomasthixton/Projects/Customers/_?/_*/_Projects/_202?/*-iOS/*.xcodeproj/project.pbxproj | uniq > all.txt ) ; ( find  /Users/thomasthixton/Library/Developer/Xcode/Archives/202[45]*/*.xcarchive -name Info.plist -depth 1 -ctime +90d -print0 | xargs -0 egrep 'com.audrinc\.|org.que4\.' | sed -e 's/<string>//g' -e 's/<\/string>//g' | awk -F: '{print $2}' | tr -d ' \011' | sort | uniq > 90-more.txt ; find  /Users/thomasthixton/Library/Developer/Xcode/Archives/202[45]*/*.xcarchive -name Info.plist -depth 1 -ctime -90d -print0 | xargs -0 egrep 'com.audrinc\.|org.que4\.' | sed -e 's/<string>//g' -e 's/<\/string>//g' | awk -F: '{print $2}' | tr -d ' \011' | sort | uniq > 90-less.txt )  ; ( cd /Users/thomasthixton/Projects/ ; for i in `sort 90-more.txt | head -200` ; do fgrep $i all.txt | sed -e 's/xcodeproj.*/xcworkspace;/' ; done | sort  )  > 90-more-projects.txt ; for i in ` sed -e 's/;//' < 90-more-projects.txt` ; do echo $i; D=`dirname $i`; open -a Tower $D; open -a Xcode $i ; echo Do-a-D ; date ; cat ; done 
##








## open $HOME/Dropbox/Projects/Vendors/_Median.co/_Projects/_2025/aa.$$.txt 
## open /tmp/a.$$.txt /tmp/aaa.$$.txt
## open $HOME/Dropbox/Projects/Vendors/_Median.co/_Projects/_2025/.
## open https://docs.google.com/spreadsheets/d/1AYnUEiHSNKH9FwxHrfE3zSzixrUTcaw1FZl7czlW-F0/edit?gid=978948921#gid=978948921



exit 0 





