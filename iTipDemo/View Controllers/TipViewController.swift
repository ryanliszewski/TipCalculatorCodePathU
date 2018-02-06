//
//  TipViewController.swift
//  iTipDemo
//
//  Created by Ryan Liszewski on 12/7/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit


class TipViewController: UIViewController, UIToolbarDelegate {
	
	@IBOutlet weak var totalAmountTextField: UITextField!
	@IBOutlet weak var segmentedTipControl: CustomSegmentedControl!
	@IBOutlet weak var customTipLabel: UILabel!
	@IBOutlet weak var numberOfPeopleView: UIView!
	@IBOutlet weak var numberOfPeopleCollectionView: UICollectionView!
	@IBOutlet weak var tipAmountLabel: UILabel!
  @IBOutlet weak var totalAmountLabel: UILabel!
  var isViewAnimatedUp: Bool = false
  var totalAmountViewOriginY: CGFloat?
	var segmentedTipControlViewOriginY: CGFloat?
  var tipAmountViewOriginY: CGFloat?
	var keyboardHeight: CGFloat?
 
  @IBOutlet weak var totalAmountView: UIView!
  @IBOutlet weak var tipAmountView: UIView!
	
	var backButton = UIBarButtonItem()
  
  var tipAmounts = [0.15, 0.18, 0.20, 0.25]
  
  override func viewDidLoad() {
		super.viewDidLoad()
		
		
		let gradiantLayer = CAGradientLayer()
		gradiantLayer.frame = self.view.frame
		gradiantLayer.startPoint = CGPoint(x: 0, y: 0)
		gradiantLayer.endPoint = CGPoint(x: 1, y: 1)
		//gradiantLayer.colors =
		
		setUpTipAmountView()
		setUpTotalAmountView()
    addNextBackKeyboardToolBar()
		setUpNumberOfPeopleView()
		setUpSegmentedTipControl()
  }
	
  func calculateTip(stringAmount: String){
		
		if let amount = Double(stringAmount){
			let tipAmount = amount * tipAmounts[segmentedTipControl.selectedIndex]
			let totalAmount = amount + tipAmount
			
			let formatter = NumberFormatter()
			formatter.locale = Locale.current
			
			formatter.numberStyle = .currency
			
			if let formattedTipAmount = formatter.string(from: tipAmount as NSNumber) {
				tipAmountLabel.text = formattedTipAmount
			}
		
			if let formattedTotalAmount = formatter.string(from: totalAmount as NSNumber) {
				totalAmountLabel.text = formattedTotalAmount
			}
		}
  }
}

//MARK: - Subscriptions
extension TipViewController {
	func addSubscriptions(){
		
		segmentedTipControl.addTarget(self, action: #selector(self.onSegmentedControlIndexChanged(_:)), for: .valueChanged)
		
		NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillShow")), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
	}
}

//MARK: - UI
extension TipViewController {
	fileprivate func addNextBackKeyboardToolBar(){
		//FINISH
		let nextBackToolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44.0))
		
		let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		
		let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(self.onNextButtonTapped))
		nextButton.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
		backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(self.onBackButtonTapped))
		backButton.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
		
		let items = [backButton, flexSpace, nextButton]
		nextBackToolBar.items = items
		nextBackToolBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		nextBackToolBar.delegate = self
		totalAmountTextField.inputAccessoryView = nextBackToolBar
	}
	
	fileprivate func setUpTipAmountView(){
		tipAmountView.addDropShadow()
		tipAmountView.alpha = 0
		
		tipAmountViewOriginY = tipAmountView.frame.origin.y
	}
	
	fileprivate func setUpSegmentedTipControl(){
		segmentedTipControlViewOriginY = segmentedTipControl.frame.origin.y
		segmentedTipControl.alpha = 0;
	}
	
	fileprivate func setUpTotalAmountView(){
		totalAmountTextField.becomeFirstResponder()
		totalAmountTextField.textAlignment = .center
		let font = UIFont(name: "HelveticaNeue", size: 36)!
		let attributes = [NSAttributedStringKey.font : font]
		
		totalAmountTextField.attributedPlaceholder = NSAttributedString(string: "Enter the Total Bill",
																																		attributes:attributes)
		totalAmountViewOriginY = totalAmountView.frame.origin.y
		
		totalAmountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
	}
	
	fileprivate func setUpNumberOfPeopleView(){
		numberOfPeopleView.addDropShadow()
	}
}

//MARK: - UI Actions
extension TipViewController {
	@objc fileprivate func textFieldDidChange(_ textField: UITextField)
	{
		if(!(textField.text?.isEmpty)! && !isViewAnimatedUp){
			animateViewUp()
			isViewAnimatedUp = true
			calculateTip(stringAmount: textField.text!)
		} else if (textField.text?.isEmpty)! {
			animateViewDown()
			isViewAnimatedUp = false
		} else if !(textField.text?.isEmpty)! {
			calculateTip(stringAmount: textField.text!)
		}
	}
	
	@objc fileprivate func onNextButtonTapped(){
		backButton.title = "Bill"
	}
	
	@objc fileprivate func onBackButtonTapped(){
		print("Back button tapped")
	}
	
	@objc fileprivate func onSegmentedControlIndexChanged(_ sender: Any){
		calculateTip(stringAmount: totalAmountTextField.text!)
	}
	
	@objc fileprivate func keyboardWillShow(_ notification: NSNotification){
		if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			keyboardHeight = keyboardRectangle.height
		}
	}
}

//MARK: - Animations
extension TipViewController {
	func animateViewUp(){
		if (!(totalAmountTextField.text?.isEmpty)!){
			UIView.animate(withDuration: 0.3) {
				self.totalAmountView.frame.origin.y = self.totalAmountView.frame.origin.y -  self.totalAmountView.frame.size.height / 1.5 +  self.totalAmountTextField.frame.size.height
				
				self.tipAmountView.frame.origin.y = self.tipAmountView.frame.origin.y - self.tipAmountView.frame.height * 1.5
				
				self.segmentedTipControl.frame.origin.y = self.segmentedTipControl.frame.origin.y - self.tipAmountView.frame.height * 1.5
				
				//self.segmentedTipControl.alpha = 1
				self.tipAmountView.alpha = 1
			}
		}
	}
	
	func animateViewDown(){
		UIView.animate(withDuration: 0.3) {
			self.totalAmountView.frame.origin.y = self.totalAmountViewOriginY!
			self.segmentedTipControl.frame.origin.y = self.segmentedTipControlViewOriginY!
			self.tipAmountView.frame.origin.y = self.tipAmountViewOriginY!
			self.segmentedTipControl.alpha = 0
			self.tipAmountView.alpha = 0
		}
	}
}

//MARK - CollectionView
extension TipViewController {
	//FINISH
}


