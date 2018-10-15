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
    let symbolsArray = ["%", "÷", "×", "+", "-"]
    
    var newSymbol: String = "" {
        didSet {
            if isValidNewSymbol(newSymbol: newSymbol) {
                resultTextField.stringValue = resultTextField.stringValue + newSymbol
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func symbolClick(_ sender: NSButton) {
        newSymbol = sender.title
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
    
    private func isValidNewSymbol(newSymbol: String) -> Bool {

        if newSymbol.isNumber {
            if let lastSymbol = resultTextField.stringValue.last {
                if  lastSymbol == ")" {
                    return false
                }
            }
        }
        if symbolsArray.contains(newSymbol) {
            guard let lastSymbol = resultTextField.stringValue.last else { return false }

            if  lastSymbol != ")",
                String(lastSymbol).isNumber == false {
                return false
            }
        }
        if newSymbol == "." {
            guard let lastSymbol = resultTextField.stringValue.last else { return false }
            if String(lastSymbol).isNumber == false {
                return false
            }
        }
        if newSymbol == "(" {
            if let lastSymbol = resultTextField.stringValue.last {
                if !symbolsArray.contains(String(lastSymbol)),
                    lastSymbol != "(" {
                    return false
                }
            }
        }
        if newSymbol == ")" {
            guard let lastSymbol = resultTextField.stringValue.last else { return false }
            let openSymbolCount = resultTextField.stringValue.countInstances(of: "(")
            let closeSymbolCount = resultTextField.stringValue.countInstances(of: ")")
            if openSymbolCount - closeSymbolCount <= 0 ||
                String(lastSymbol).isNumber == false {
                return false
            }
        }
        
        return true
    }
}

