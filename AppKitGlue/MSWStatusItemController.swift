//
//  MSWStatusItemController.swift
//  AppKitGlue
//
//  Created by Steven Troughton-Smith on 09/06/2021.
//  Copyright © 2021 Steven Troughton-Smith. All rights reserved.
//

import AppKit

var MSWStatusItem = NSStatusItem()

class MSWStatusItemController: NSObject {
	
	override init() {
		super.init()
		
		MSWStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
		
		let image = NSImage(systemSymbolName: "star.fill", accessibilityDescription: nil)
		image?.isTemplate = true
		MSWStatusItem.button?.image = image
		
		MSWStatusItem.button?.target = self
		MSWStatusItem.button?.action = #selector(menuWillOpen(_:))
	}
	
	@objc func menuWillOpen(_ sender:NSStatusBarButton) {
		NotificationCenter.default.post(name: .showStatusWindow, object: nil)
	}
}
