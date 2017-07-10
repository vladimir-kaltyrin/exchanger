xcodebuild clean
xcodebuild | xcpretty -r json-compilation-database -o compile_commands.json
oclint-json-compilation-database -- -report-type xcode
