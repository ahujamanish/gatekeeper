# Gatekeeper

Gatekeeper lets you add TouchId/FaceId authentication in your app with a single line of code. Once configured, your app will prompt the user to authenticate with TouchId/FaceId (if available and enabled on the device) before allowing the user to access the app. 

## Installation

### Cocoapods
To integrate GateKeeper into your Xcode project using CocoaPods, specify it in your Podfile:

#### Swift 4.0
```
  pod 'GateKeeper', :git => 'https://github.com/ahujamanish/GateKeeper.git'
```

## Example

Simply add the following line in your Application's AppDelegate
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
...    
		window?.makeKeyAndVisible()
		GateKeeper.shared.configure(enabled: true)
...
		return true
}
```

You can also enable/disable authentication at any point by:

```swift
...
		GateKeeper.shared.enabled = true
...
```

## Licence

GateKeeper is available under the MIT license. See the LICENSE file for more info.
