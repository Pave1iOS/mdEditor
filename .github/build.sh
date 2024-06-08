curl -Ls https://install.tuist.io | bash
tuist install 3.42.2
tuist fetch
tuist generate
xcodebuild clean -quiet
xcodebuild build-for-testing\
    -workspace 'mdEditor.xcworkspace' \
    -scheme 'mdEditor' \
    -destination 'platform=iOS Simulator,name=iPhone 14 Pro' 
