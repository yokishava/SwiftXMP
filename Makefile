test:
	xcodebuild clean build \
		-sdk iphonesimulator \
		-configuration Debug \
		-target SwiftXMP \
		ONLY_ACTIVE_ARCH=NO 

	xcodebuild clean build \
		-project Demo/Demo.xcodeproj \
		-configuration Debug \
		-target Demo \
		-sdk iphonesimulator \
		ONLY_ACTIVE_ARCH=NO

	xcodebuild clean test \
		-scheme SwiftXMP \
		-sdk iphonesimulator \
		-destination 'platform=iOS Simulator,name=iPhone 8' \
		test

	xcodebuild clean test \
		-scheme SwiftXMP \
		-sdk iphonesimulator \
		-destination 'platform=iOS Simulator,name=iPhone X' \
		test
