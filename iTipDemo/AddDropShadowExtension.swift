//
//  AddDropShadowExtension.swift
//  iTipDemo
//
//  Created by Ryan Liszewski on 1/30/18.
//  Copyright © 2018 ImThere. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	func addDropShadow(){
		self.layer.cornerRadius = 10.0
		self.layer.borderWidth = 5.0
		self.layer.borderColor = UIColor.clear.cgColor
		self.layer.shadowColor = UIColor.gray.cgColor
		self.layer.shadowOffset = CGSize(width: 5, height: 5)
		self.layer.shadowOpacity = 0.5
		self.layer.shadowRadius = 5.0
	}
}
