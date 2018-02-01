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
	var thumbview = UIView()
	
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
		
		labels.removeAll(keepingCapacity: true)
		
		for index in 1...items.count {
			
			let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
			label.text = items[index - 1]
			label.backgroundColor = UIColor.clear
			label.textAlignment = .center
			label.font = UIFont(name: "HelveticaNeue", size: 15)
			label.textColor = index == 1 ? selectedLabelColor : unselectedLabelColor
			self.addSubview(label)
			labels.append(label)
		}
	}
	
	func displayNewSelectedIndex(){
		for (index, item) in EnumeratedSequence(labels) {
			item.textColor = unselectedLabelColor
		}
		
		var label = labels[selectedIndex]
		label.textColor = selectedLabelColor
		
		UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
			
			self.thumbView.frame = label.frame
			
		}, completion: nil)
	}
	
	
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		let location = touch.location(in: self)
		
		var calculatedIndex : Int?
		for (index, item) in EnumeratedSequence(labels) {
			if item.frame.contains(location) {
				calculatedIndex = index
			}
		}
		
		
		if calculatedIndex != nil {
			selectedIndex = calculatedIndex!
			sendActionsForControlEvents(.ValueChanged)
		}
		
		return false
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
		for item in labels {
			item.textColor = unselectedLabelColor
		}
		
		if labels.count > 0 {
			labels[0].textColor = selectedLabelColor
		}
		
		thumbView.backgroundColor = thumbColor
	}
	
	func setFont(){
		for item in labels {
			item.font = font
		}
		
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
		layer.cornerRadius = frame.height / 2
		layer.borderColor = UIColor(white: 1.0, alpha: 0.5).CGColor
		layer.borderWidth = 2
		
		backgroundColor = UIColor.clear
		setUpLabels()
	}
	
	
}
