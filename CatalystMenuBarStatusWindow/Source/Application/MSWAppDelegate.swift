//
//  MSWAppDelegate.swift
//  CatalystMenuBarStatusWindow
//
//  Created by Steven Troughton-Smith on 11/02/2022.
//  
//

import UIKit

@UIApplicationMain
class MSWAppDelegate: UIResponder, UIApplicationDelegate {
	
#if targetEnvironment(macCatalyst)
	
	static var appKitController:NSObject?
	
	class func loadAppKitGlueFramework() {
		
		if let frameworksPath = Bundle.main.privateFrameworksPath {
			let bundlePath = "\(frameworksPath)/AppKitGlue.framework"
			do {
				try Bundle(path: bundlePath)?.loadAndReturnError()
				
				let bundle = Bundle(path: bundlePath)!
				NSLog("[APPKIT BUNDLE] Loaded Successfully")
				
				if let appKitControllerClass = bundle.principalClass as? NSObject.Type {
					appKitController = appKitControllerClass.init()
				}
			}
			catch {
				NSLog("[APPKIT BUNDLE] Error loading: \(error)")
			}
		}
	}
#endif
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
#if targetEnvironment(macCatalyst)
		MSWAppDelegate.loadAppKitGlueFramework()
#endif
		
		return true
	}
}
