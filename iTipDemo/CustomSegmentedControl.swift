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
	
	var selectedIndex: Int = 0 {
		didSet {
			displayNewSelectedIndex()
		}
	}
	
	func setUpLabels(){
		for label in labels {
			label.removeFromSuperview()
		}
	}
	
	func displayNewSelectedIndex(){
		
	}
	
	@IBInspectable var selectedLabelColor: UIColor = UIColor.black {
		didSet {
			setSelectedColors()
		}
	}
	
	@IBInspectable var unselectedLabelColor: UIColor = UIColor.white {
		didSet {
			setSelectedColors()
		}
	}
	
	@IBInspectable var thumbColor: UIColor = UIColor.white {
		didSet {
			setSelectedColors()
		}
	}
	
	
	func setSelectedColors(){
	}
	
	func setFont(){
		
	}
	
	@IBInspectable var borderColor : UIColor = UIColor.white {
		didSet {
			layer.borderColor = borderColor.cgColor
		}
	}
	
	
	@IBInspectable var font: UIFont! = UIFont.systemFont(ofSize: 12){
		didSet {
			setFont()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpView()
	}
	
	required init?(coder: NSCoder){
		super.init(coder: coder)
		setUpView()
	}
	
	func setUpView(){
		
	}
	
	
}
