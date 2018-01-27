//
//  SettingsViewController.swift
//  iTipDemo
//
//  Created by Ryan Liszewski on 12/7/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var segmentedTipControl: UISegmentedControl!

  override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }
  
  @IBAction func onSegmentedTipValueChanged(_ sender: Any) {
    let defaults = UserDefaults.standard
    
  }
}
