//
//  AppKitController.swift
//  AppKitGlue
//
//  Created by Steven Troughton-Smith on 11/02/2022.
//

import Foundation

public class AppKitController: NSObject {
	let statusItemController = MSWStatusItemController()

	override init() {

		/*
		 
		 Commence swizzling!
		 
		 */
		
		do {
			let m1 = class_getInstanceMethod(NSClassFromString("NSPopover"), NSSelectorFromString("MSW_showRelativeToRect:ofView:preferredEdge:"))
			let m2 = class_getInstanceMethod(NSClassFromString("NSPopover"), NSSelectorFromString("showRelativeToRect:ofView:preferredEdge:"))
			
			if let m1 = m1, let m2 = m2 {
				method_exchangeImplementations(m1, m2)
			}
		}
		
		do {
			let m1 = class_getInstanceMethod(NSClassFromString("NSPopover"), NSSelectorFromString("MSW_setContentSize:"))
			let m2 = class_getInstanceMethod(NSClassFromString("NSPopover"), NSSelectorFromString("setContentSize:"))
			
			if let m1 = m1, let m2 = m2 {
				method_exchangeImplementations(m1, m2)
			}
		}
	}
}
