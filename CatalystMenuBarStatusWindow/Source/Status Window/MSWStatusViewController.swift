//
//  MSWStatusViewController.swift
//  CatalystMenuBarStatusWindow
//
//  Created by Steven Troughton-Smith on 11/02/2022.
//

import UIKit
import SwiftUI

struct StatusContentView: View {
	var body: some View {
		VStack(spacing:8) {
			Image(systemName: "text.and.command.macwindow")
				.font(.largeTitle)
			Text("Hello World")
		}
	}
}

class MSWStatusViewController: UIHostingController<StatusContentView> {

	init() {
		super.init(rootView: StatusContentView())
		view.backgroundColor = .clear
	}
	
	@MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
