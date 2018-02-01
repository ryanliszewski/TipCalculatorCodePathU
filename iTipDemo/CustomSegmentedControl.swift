//
//  CustomSegmentedControl.swift
//  iTipDemo
//
//  Created by Ryan Liszewski on 1/31/18.
//  Copyright © 2018 ImThere. All rights reserved.
//

import UIKit

@IBDesignable class SegmentedControl: UIControl {
	
	private var labels = [UILabel]()
	
	var items:[String] = ["Item1", "Item2", "Item3"] {
		didSet {
			setUpLabels()
		}
	}
	
	var selectedIndex: Int = 0
	
	func setUpLabels(){
		for label in labels {
			label.removeFromSuperview()
		}
	}
	
}
