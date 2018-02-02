//  UITextFieldExtension.swift
//  iTipDemo
//
//  An extension that changes the placeholder text's color of a UITextField and
// 	the font of the placeholder.
//
//  Created by Ryan Liszewski on 1/30/18.
//  Copyright © 2018 ImThere. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
	@IBInspectable var placeHolderColor: UIColor? {
		get {
			return self.placeHolderColor
		}
		set {
			self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
		}
	}
}

