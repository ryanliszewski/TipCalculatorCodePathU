//
//  CustomSegmentedControl.swift
//  iTipDemo
//
//  Created by Ryan Liszewski on 1/31/18.
//  Copyright © 2018 ImThere. All rights reserved.
//

import UIKit

@IBDesignable class CustomSegmentedControl: UIControl {
	
	private var labels = [UILabel]()
	var thumbView = UIView()
	
	var items:[String] = ["15%", "20%", "25%"] {
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
			label.translatesAutoresizingMaskIntoConstraints = false
			self.addSubview(label)
			labels.append(label)
		}
	}
	
	func displayNewSelectedIndex(){
		for item in labels {
			item.textColor = unselectedLabelColor
		}
		
		var label = labels[selectedIndex]
		label.textColor = selectedLabelColor
		
		UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .allowAnimatedContent, animations: {
			self.thumbView.frame = label.frame
			self.thumbView.layer.shadowRadius = 100.0
			self.updateThumbViewShadow(index: self.selectedIndex)
			
			
		}) { (completion) in
			//TODO
		}
	}
	
	func updateThumbViewShadow(index: Int){
		switch index {
		case 0:
			thumbView.layer.shadowRadius = 5.0
			thumbView.layer.shadowOffset = CGSize(width: 5, height: 0)
			break
		case items.count - 1:
			thumbView.layer.shadowRadius = 5.0
			thumbView.layer.shadowOffset = CGSize(width: -5, height: 0)
			break
		default:
			thumbView.layer.shadowRadius = 10.0
			thumbView.layer.shadowOffset = CGSize(width: 0, height: 0)
		}
	}
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		var selectFrame = self.bounds
		let newWidth = selectFrame.width  / CGFloat(items.count)
		selectFrame.size.width = newWidth
		thumbView.frame = selectFrame
		thumbView.backgroundColor = thumbColor
		thumbView.layer.cornerRadius = thumbView.frame.height / 2
		thumbView.layer.shadowOpacity = 1.0
		thumbView.layer.shadowRadius = 5.0
		thumbView.layer.shadowColor = UIColor.gray.cgColor
		updateThumbViewShadow(index: selectedIndex)
		
		let labelHeight = self.frame.height
		let labelWidth = self.frame.width / CGFloat(labels.count)
		
		for index in 0...labels.count - 1 {
			var label = labels[index]
			
			let xPosition = CGFloat(index) * labelWidth
			label.frame = CGRect(x: xPosition, y: 0, width: labelWidth, height: labelHeight)
		}
	}
	
	
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		let location = touch.location(in: self)
		
		var calculatedIndex : Int?
		for (index, item) in labels.enumerated() {
			if item.frame.contains(location) {
				calculatedIndex = index
			}
		}
		
		
		if calculatedIndex != nil {
			selectedIndex = calculatedIndex!
			sendActions(for: .valueChanged)
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
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setUpView()
	}
	
	func setUpView(){		
		layer.cornerRadius = frame.height / 2
		layer.borderColor = UIColor(white: 1.0, alpha: 0.5).cgColor
		layer.borderWidth = 2
		
		backgroundColor = UIColor.clear
		layer.masksToBounds = true 
		setUpLabels()
		insertSubview(thumbView, at: 0)
	}
}
