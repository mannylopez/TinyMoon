![Tiny Moon icon](images/TinyMoonIcon_256x256.png)
# Tiny Moon

A tiny Swift Package to calculate the moon phase for any given date

Compatible with iOS and MacOS

## Description

## Installation
1. Open your existing Xcode project or create a new one
2. Open the Swift Packages Manager
	- In the project navigator, select your project file to open the project settings.
	- Navigate to the the **Package Dependencies** tab
3. Add the Tiny Moon Package
	- Click the **+** button at the bottom of the tab
	- In the dialog box that appears, enter the URL for Tiny Moon: `https://github.com/mannylopez/TinyMoon.git`
4. Specify version rules
	- Xcode will prompt you to specify version rules for the package. "Up to Next Major Version" ensures compatibility with future updates that don't introduce breaking changes.
	- Click **Add Package**

![Xcode package dialog box](images/XcodePackageDialogBox.png)

## Usage
Now that Tiny Moon is added to your project, you can import it in your Swift files using the import statement.

To use Tiny Moon, simply pass in the the `Date` for which you'd like to know the Moon phase for, or if none is passed in, then your system's current `Date` will be used.

```swift
import SwiftUI
import TinyMoon

struct SimpleMoonView: View {
  private let moon = TinyMoon.calculateMoonPhase()
  var body: some View {
    Text(moon.emoji)
    Text(moon.name)
    Text("\(moon.illuminatedFraction)")
  }
}

#Preview {
  SimpleMoonView()
}
```

![Simple Moon View](images/SimpleMoon.png)

