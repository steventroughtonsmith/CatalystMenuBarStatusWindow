//
//  MSWMainViewController.swift
//  CatalystMenuBarStatusWindow
//
//  Created by Steven Troughton-Smith on 11/02/2022.
//  
//

import UIKit

import SwiftUI

struct ContentView: View {
	var body: some View {
		HStack(spacing:2) {
			Text("Click on the ")
			Image(systemName: "star.fill")
			Text(" in your menu bar")
		}
	}
}

final class MSWMainViewController: UIHostingController<ContentView> {
	
	init() {
		super.init(rootView: ContentView())
		title = "CatalystMenuBarStatusWindow"
		
		NotificationCenter.default.addObserver(forName: .showStatusWindow, object: nil, queue: nil) { _ in
			DispatchQueue.main.async {
				self.showStatusWindow()
			}
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: -
	
	func showStatusWindow() {
		
		/*
		 
		 When the source view for a UIKit popover is not a subview of a window,
		 it triggers behavior we take advantage of in our NSPopover extension.
		 
		 */
		
		let vc = MSWStatusViewController()
		vc.modalPresentationStyle = .popover
		
		let dummyView = UIView()
		dummyView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		
		vc.popoverPresentationController?.sourceView = dummyView
		vc.popoverPresentationController?.sourceRect = dummyView.bounds
		vc.popoverPresentationController?.permittedArrowDirections = [.any]
		vc.popoverPresentationController?.canOverlapSourceViewRect = true
		
		present(vc, animated: true, completion: nil)
	}
}
