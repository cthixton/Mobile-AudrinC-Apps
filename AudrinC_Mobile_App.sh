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
# /Users/thomasthixton/Dropbox/Projects/Vendors/_Median.co/_Projects/_2025/AudrinC_Mobile_Apps/AudrinC_Mobile_App.sh
#

export CC=$HOME/Dropbox/Projects/Customers;
	echo Purple
	tag -a Purple $CC/_?/_*/_Projects/_202?/*-iOS/*.xcworkspace/{..,../../*-android} ;
	echo Yellow
	tag -a Yellow $CC/_?/_*/_Projects/_202?/*.apk ;
	echo Red
	tag -a Red $CC/_?/_*/_Projects/_202?/*-iOS/*.xcworkspace ;
	echo More Red
	tag -a Red $CC/_?/_*/_Projects/_202?/*-iOS/*.xcworkspace/../../../../_Projects ;

	ls -ld $CC/_?/_*/_Projects/_202?/*.apk ;

	ls -ld $CC/_?/_*/_Projects/_202?/*-iOS/*.xcworkspace/{..,../../*-android} ;

	for i in $CC/_?/_*/_Projects/_202?/*-iOS/ ; do
 		echo "$i"/*.xcworkspace ;
 		cd "$i" ;
		test -d "$i"/screenshots || ( 	mkdir "$i"/screenshots ;
			cp $CC/____TEMPLATE/_Documentation/_Artwork/screenshots/*button* "$i"/screenshots/. ;
			open "$i"/screenshots ;
			test -d .git || ( git init && open -a Tower . && open *.xcworkspace && open . && open $HOME/Downloads/ && open https://github.com/cthixton/ && echo x && sleep 8 ) ;
			git config http.postBuffer 524288000 ;
			sleep 5 	) ;
		done ;
	for i in $CC/_?/_*/_Projects/_202?/*-iOS/*.xcworkspace/../../*-android $CC/_?/_*/_Projects/_202?/*-iOS/*.xcworkspace/../../*-iOS ; do
 		echo "$i" ;
 		cd "$i" ;
		test -d .git || ( git init && open -a -n Tower . && open . && open $HOME/Downloads/ && open https://github.com/cthixton/ && echo a && sleep 10 ) ;
		p=`pwd`
		b=`basename "$p"`
		q="`git remote -v`" ; test -z "$q" && echo -n NoRemote " " && basename "$p" && git remote add origin https://github.com/cthixton/"$b".git
		git config http.postBuffer 524288000 ;
	done ;
		export F=$CC/_?/_*/_Projects/_202?/*.apk ;
		echo NEEDTOFIX: dirname `ls $CC/_?/_*/_Projects/_2025/app-release*|tr ' ' '?'` > /tmp/d.$$
		echo Fix/rename these... apk...
		open `cat /tmp/d.$$`
		date
		echo '...ctl-D please....'
		cat
		rsync -aPz -e "ssh -oHostKeyAlgorithms=+ssh-dss" --min-size=1 $F 198.57.151.18:public_html/wpau/;

#
# Clean up find into file to manually copy into google spreadsheet. - tj
#

for i in $HOME/Dropbox/Projects/Customers/_?/_*/_Projects/_202*/*-iOS/.git 
do
	(
	cd $i/..
	X=`ls|fgrep .xcworkspace`
	Y=`ls|fgrep .xcodeproj` 
	A=`ls ../../_202?/. | egrep '.apk$'`
	pwd
	# echo zzz
	basename `pwd`
	# echo yyy
	echo $X
	# echo uuu
	echo `pwd`/$X
	# echo `pwd`/$X vvv
	# echo $X $A
	# ( test -z "$A" && echo "NO-APKS-YET" ) || echo $A
	( test -z "$A" && echo "NO-APKS-YET" ) || ( for i in $A ; do echo https://audrinc.com/$A ; done )
	# echo xxx
	( cd $i ; git remote -v | fgrep -v push ) 2>&1 || echo NO-GIT | awk '{print $1 $2}'

	fgrep PRODUCT_BUNDLE_IDENTIFIER $i/../$Y/project.pbxproj| fgrep -v PRODUCT_NAME | head -1 | awk '{print $3}' | tr -d ';'
	## echo '' 
	test -f LeanIOS/appConfig.json && fgrep initialUrl LeanIOS/appConfig.json | tr '"' '\012' | fgrep http 
	echo '' 
	)
done | \
	 tee /tmp/a.$$.txt | \
	sed -e 's/cthixton@git/git/' | \
	tr '\012' '|' | \
	 tee /tmp/aaa.$$.txt | \
	sed -e 's/||/%/g' | \
	tr '\174' '\011' | \
	tr '%' '\012' | \
	sort -fi +1 | \
	cat -n | \
	sed -e 's/[ ][ ]*/ /g' | \
	( echo -n `date` ; tr ' ' '\011' ) > $HOME/Dropbox/Projects/Vendors/_Median.co/_Projects/_2025/aa.$$.txt 
	### ( echo -n `date` ; tr ' ' '\011' ) > /tmp/aa.$$.txt 

open $HOME/Dropbox/Projects/Vendors/_Median.co/_Projects/_2025/aa.$$.txt 
## open /tmp/a.$$.txt /tmp/aaa.$$.txt
open $HOME/Dropbox/Projects/Vendors/_Median.co/_Projects/_2025/.
open https://docs.google.com/spreadsheets/d/1AYnUEiHSNKH9FwxHrfE3zSzixrUTcaw1FZl7czlW-F0/edit?gid=978948921#gid=978948921



exit 0 





