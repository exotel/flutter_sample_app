SDK_VERSION:=

android-deps:
	make deps -C flutter_app/android

generate-sdk:android-deps
	mkdir SDK/flutter-sdk
	cp -r flutter_app/android ./SDK/flutter-sdk
	cp -r flutter_app/ios ./SDK/flutter-sdk
	mkdir SDK/flutter-sdk/lib
	cp -r flutter_app/lib/Service ./SDK/flutter-sdk/lib/
	cp -r flutter_app/lib/ExotelSDKClient.dart ./SDK/flutter-sdk/lib/
	tar -czvf flutter-sdk.tar.gz ./SDK/flutter-sdk
	rm -rf SDK/flutter-sdk
