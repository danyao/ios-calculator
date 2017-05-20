//
//  ViewController.swift
//  Calculator
//
//  Created by Danyao Wang on 5/20/17.
//  Copyright © 2017 Danyao Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var display: UILabel!
  
  private var brain: CalculatorBrain = CalculatorBrain()
  
  private var userIsTyping = false
  
  @IBAction func touchDigit(_ sender: UIButton) {
    let digit = sender.currentTitle!
    
    if userIsTyping {
      display.text = display.text! + digit
    } else {
      display.text = digit
      userIsTyping = true
    }
  }
  
  @IBAction func performOperation(_ sender: UIButton) {
    userIsTyping = false
    
    brain.setOperand(Double(display.text!)!)
    brain.performOperation(sender.currentTitle!)
    if let result = brain.result {
      display.text = String(result)
    }
  }
}

