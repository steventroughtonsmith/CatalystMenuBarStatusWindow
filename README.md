#  CatalystMenuBarStatusWindow

This sample code showcases a method of presenting UIKit (or Catalyst-specific SwiftUI) content from the status menu area on macOS. 

WARNING: In lieu of a public API to do this, we have to rely on swizzling. I've tried to make this as 'safe' as it can possibly be, but as with all swizzling and non-public API, please be careful of side-effects and potential breakage in future versions of the OS. This is to be considered an advanced topic for people who know what they're doing.

Realistically, all you're *really* doing is manually setting the size and position of an NSPopover when it's created, so the potential failure states should be fairly innocuous.

### Overview
- Uses an AppKit bridging bundle
- Adds a status menu item
- Clicking the status menu item fires a Notification
- In the UIKit side of the app, the Notification receiver presents a view controller (in this case, with a SwiftUI content view) as a popover with a nil source view
- Swizzles `showRelativeToRect:ofView:preferredEdge:` in AppKit to redirect the popover source view to the status menu item
- As the popover is now 'attached' to the status menu item, it will move with it when rearranged
- Process has been tested to work on both macOS 11 and macOS 12

### Screenshots

![https://hccdata.s3.amazonaws.com/gh_statusbar_uikit.jpg](https://hccdata.s3.amazonaws.com/gh_statusbar_uikit.jpg)
