//
//  NavigationBarExtension.swift
//
//	ViewController Extensions for editing the UI of the navigation bar.
//
//  Created by Ryan Liszewski on 2/21/18.
//  Copyright © 2018 ImThere. All rights reserved.
//

import UIKit

extension UIViewController {
	
	//Removes bottom border of navigation controller.
	func removeNavigationBarBottomBorder(){
		let navigationBar = navigationController?.navigationBar
		navigationBar?.isTranslucent = false
		navigationBar?.setBackgroundImage(UIImage(), for: .default)
		navigationBar?.shadowImage = UIImage()
	}
	
	//Set's the navigation bar back button tint to white.
	func setUpNaviationBarBackButton(){
		let navigationBar = navigationController?.navigationBar
		navigationBar?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		navigationItem.backBarButtonItem?.title = ""
	}
}
