//
//  NSPopover+UIKit.swift
//  AppKitGlue
//
//  Created by Steven Troughton-Smith on 11/02/2022.
//

import AppKit

extension NSPopover {
	
	@objc func MSW_setContentSize(_ size:CGSize) {
		/*
		 
		 In this case, we're manually enforcing the content size of the popover here
		 rather than from UIKit (which is using a dummy view). This is a necessary
		 element.
		 
		 */

		if let _ = value(forKeyPath: "positioningView") as? NSStatusBarButton {
			
			return MSW_setContentSize(CGSize(width:246, height:380))
		}
		
		return MSW_setContentSize(size)
	}
	
	@objc func MSW_showRelativeToRect(_ rect:CGRect, ofView:NSView?, preferredEdge:CGRectEdge) {
		
		/*
		 
		 When the source view for a UIKit popover is not a subview of a window,
		 by the time it gets to showRelativeToRect:ofView:preferredEdge: in
		 AppKit the ofView parameter is nil. By default, AppKit throws an exception
		 here which would crash the app.
		 
		 Instead, let's replace that behavior with our own, which redirects the
		 popover to our NSStatusItem as a source view.
		 
		 This behavior relies on swizzling, but in lieu of a public API seems like
		 the best way to present a UIKit-powered menu bar popover.
		 
		 */
		
		if rect.size.equalTo(CGSize(width: MSWMenuPopoverTriggerSize, height: MSWMenuPopoverTriggerSize)) {
			
			if let sender = MSWStatusItem.button {
				
				if let _ = sender.window?.convertToScreen(sender.frame) {
					
					behavior = .transient
					
					MSW_showRelativeToRect(sender.bounds, ofView: sender, preferredEdge: .maxYEdge)
					self.positioningRect = sender.bounds
					
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
						self.positioningRect = sender.bounds
					}
				}
			}
		}
		else {
			
			/*
			 
			 For every other kind of popover, fall back to the system behavior so
			 nothing weird happens.
			 
			 */
			
			MSW_showRelativeToRect(rect, ofView: ofView, preferredEdge: preferredEdge)
		}
	}
}
