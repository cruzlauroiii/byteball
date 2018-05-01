VERSION=`cut -d '"' -f2 $BUILDDIR/../version.js`

scratch:
	git clean -dfx
	rm -rf ~/Library/Application\ Support/byteball
	export npm_config_target=0.24.4
	export npm_config_arch=x64
	export npm_config_target_arch=x64
	export npm_config_runtime=node-webkit
	export npm_config_build_from_source=true
	export npm_config_node_gyp=$(which nw-gyp)
	npm install -g bower
	npm install -g grunt-cli
	npm install -g nw-gyp
	npm install -g node-pre-gyp
	bower install
	npm install
	grunt
	~/Downloads/nwjs-v0.24.4-osx-x64/nwjs.app/Contents/MacOS/nwjs .

cordova-base:
	grunt dist-mobile

# ios:  cordova-base
# 	make -C cordova ios
# 	open cordova/project/platforms/ios/Copay
#
# android: cordova-base
# 	make -C cordova run-android
#
# release-android: cordova-base
# 	make -C cordova release-android
#
wp8-prod:
	cordova/build.sh WP8 --clear
	cordova/wp/fix-svg.sh
	echo -e "\a"

wp8-debug:
	cordova/build.sh WP8 --dbgjs
	cordova/wp/fix-svg.sh
	echo -e "\a"

ios-prod:
	cordova/build.sh IOS --clear
	cd ../byteballbuilds/project-IOS && cordova build ios
#	open ../byteballbuilds/project-IOS/platforms/ios/Byteball.xcodeproj

ios-debug:
	cordova/build.sh IOS --dbgjs
	cd ../byteballbuilds/project-IOS && cordova build ios
	open ../byteballbuilds/project-IOS/platforms/ios/Byteball.xcodeproj

android-prod:
	npm -g i apache/cordova-cli
	cordova/build.sh ANDROID --clear
#	cp ./etc/beep.ogg ./cordova/project/plugins/phonegap-plugin-barcodescanner/src/android/LibraryProject/res/raw/beep.ogg
	cd ../byteballbuilds/project-ANDROID && cordova build android --release
	
android-prod-fast:
	cordova/build.sh ANDROID
	cd ../byteballbuilds/project-ANDROID && cordova run android --device

android-debug:
	cordova/build.sh ANDROID --dbgjs --clear
#	cp ./etc/beep.ogg ./cordova/project/plugins/phonegap-plugin-barcodescanner/src/android/LibraryProject/res/raw/beep.ogg
	cd ../byteballbuilds/project-ANDROID && cordova build android

android-debug-fast:
	cordova/build.sh ANDROID --dbgjs
#	cp ./etc/beep.ogg ./cordova/project/plugins/phonegap-plugin-barcodescanner/src/android/LibraryProject/res/raw/beep.ogg
	cd ../byteballbuilds/project-ANDROID && cordova run android --device
#	cd ../byteballbuilds/project-ANDROID && cordova build android