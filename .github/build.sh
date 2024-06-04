curl -Ls https://install.tuist.io | bash
tuist install 3.18
tuist fetch
tuist generate
xcodebuild clean -quiet
xcodebuild build-for-testing\
    -workspace 'MyApp.xcworkspace' \
    -scheme 'MyApp' \
    -destination 'platform=iOS Simulator,name=iPhone 14 Pro' 