# GScent

# Build and Run
- Checkout the 'develop' branch to get the latest code. 
- Require iOS 13.0+ as the app uses CompositeLayout for CollectionView
- Used Cocoapods. Used Pods are,
	- Quick (UT)
	- Nimble (UT)
	- SwiftLint (Linting)

- Fastlane and SwiftLint is integrated.
- To run the UT,
	- Make sure Fastlane is installed. Please read the README.md file in the fastlane directory for more info.
	- In terminal, CD to the project directory and run, 'fastlane tests'
	
- Code coverage report will be generated with fastlane tests and will be available in slater_output directory

