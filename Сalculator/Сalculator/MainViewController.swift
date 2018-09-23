//
//  ViewController.swift
//  Сalculator
//
//  Created by Дмитрий on 9/23/18.
//  Copyright © 2018 DmitryDevDes. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet weak var resultTextField: NSTextField!
    var newSymbol: String = "" {
        didSet {
           resultTextField.stringValue = resultTextField.stringValue + newSymbol
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func symbolClick(_ sender: NSButton) {
        let formulaStr = resultTextField.stringValue + sender.title
        if isValidFormula(formulaStr: formulaStr) {
            newSymbol = sender.title
        }
    }
    
    @IBAction func resetButton(_ sender: NSButton) {
        resultTextField.stringValue = ""
    }
    
    @IBAction func resultClick(_ sender: NSButton) {
        var formulaStr = resultTextField.stringValue.replacingOccurrences(of: "÷", with: "/")
        formulaStr = formulaStr.replacingOccurrences(of: "×", with: "*")
        formulaStr = formulaStr.replacingOccurrences(of: "%", with: "/100")
        let expression = NSExpression(format: formulaStr).toFloatingPoint()
        let result = expression.expressionValue(with: nil, context: nil) as! NSNumber
        resultTextField.stringValue = result.stringValue
    }
    
    private func isValidFormula(formulaStr: String) -> Bool {
        return true
    }
    
}

