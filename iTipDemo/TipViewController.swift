//
//  TipViewController.swift
//  iTipDemo
//
//  Created by Ryan Liszewski on 12/7/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
  
  enum tip {
    static let percentage15 = 0.15
    static let percentage18 = 0.18
    static let percentage20 = 0.20
    static let percentage25 = 0.25
  }
  
  @IBOutlet weak var tipAmountLabel: UILabel!
  @IBOutlet weak var totalAmountLabel: UILabel!
  
  var isViewAnimatedUp: Bool = false
  var totalAmountViewOriginY: CGFloat?
  var segmentedTipControlViewOriginY: CGFloat?
  var tipAmountViewOriginY: CGFloat?
 
  @IBOutlet weak var totalAmountView: UIView!
  @IBOutlet weak var totalAmountTextField: UITextField!
  @IBOutlet weak var segmentedTipControlView: UIView!
  @IBOutlet weak var segmentedTipControl: UISegmentedControl!
  
  @IBOutlet weak var tipAmountView: UIView!
  
  var tipAmounts = [0.15, 0.18, 0.20, 0.25]
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    segmentedTipControl.alpha = 0
    tipAmountView.alpha = 0
    
    totalAmountTextField.becomeFirstResponder()
    
    totalAmountViewOriginY = totalAmountView.frame.origin.y
    segmentedTipControlViewOriginY = segmentedTipControlView.frame.origin.y
    tipAmountViewOriginY = tipAmountView.frame.origin.y
    
    totalAmountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    
    addNextBackKeyboardToolBar()
  }
  
  fileprivate func addNextBackKeyboardToolBar(){
    //FINISH
    let nextBackToolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50.0))
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
  
    let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(self.onNextButtonTapped))
    nextButton.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(self.onBackButtonTapped))
    backButton.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
    let items = [backButton, flexSpace, nextButton]
    nextBackToolBar.items = items
    nextBackToolBar.sizeToFit()
    nextBackToolBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    totalAmountTextField.inputAccessoryView = nextBackToolBar
  }
  
  @objc fileprivate func onNextButtonTapped(){
    print("Next Button Tapped")
  }
  
  @objc fileprivate func onBackButtonTapped(){
    print("Back button tapped")
  }
  
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
  
  func calculateTip(stringAmount: String){
    
    let amount = Double(stringAmount)
    
    let tipAmount = amount! * tipAmounts[segmentedTipControl.selectedSegmentIndex]
    let totalAmount = amount! + tipAmount
    
    tipAmountLabel.text = String(format:"$%.2f", tipAmount)
    totalAmountLabel.text = String(format:"$%.2f", totalAmount)
  }
  
  
  @IBAction func segmentedControllerValuedDidChange(_ sender: Any) {
    
    calculateTip(stringAmount: totalAmountTextField.text!)
  }
  
  
  func animateViewUp(){
    if (!(totalAmountTextField.text?.isEmpty)!){
      UIView.animate(withDuration: 0.3) {
        self.totalAmountView.frame.origin.y = self.totalAmountView.frame.origin.y -  self.totalAmountView.frame.size.height / 2 +  self.totalAmountTextField.frame.size.height
        
        self.tipAmountView.frame.origin.y = self.tipAmountView.frame.origin.y - self.tipAmountView.frame.height
        
        self.segmentedTipControlView.frame.origin.y = self.segmentedTipControlView.frame.origin.y - self.tipAmountView.frame.height
        
        self.segmentedTipControl.alpha = 1
        self.tipAmountView.alpha = 1
      }
    }
  }
  
  func animateViewDown(){
    UIView.animate(withDuration: 0.3) {
      self.totalAmountView.frame.origin.y = self.totalAmountViewOriginY!
      self.segmentedTipControlView.frame.origin.y = self.segmentedTipControlViewOriginY!
      self.tipAmountView.frame.origin.y = self.tipAmountViewOriginY!
      self.segmentedTipControl.alpha = 0
      self.tipAmountView.alpha = 0
    }
  }
}

