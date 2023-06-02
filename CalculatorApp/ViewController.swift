//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Anni on 18/05/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var workings: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }

    @IBAction func allClearTap(_ sender: Any) {
        clearAll()
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        if(!workings.isEmpty) {
            workings.removeLast()
            questionLabel.text = workings
        }
    }
    
    @IBAction func equalToTap(_ sender: Any) {
        if validInput() {
            let checkedWorkingForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedWorkingForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            answerLabel.text = resultString
        } else {
            let alert = UIAlertController(title: "Alert", message: "Invalid Input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func allButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            addToWorking(value: "0")
        case 1:
            addToWorking(value: "1")
        case 2:
            addToWorking(value: "2")
        case 3:
            addToWorking(value: "3")
        case 4:
            addToWorking(value: "4")
        case 5:
            addToWorking(value: "5")
        case 6:
            addToWorking(value: "6")
        case 7:
            addToWorking(value: "7")
        case 8:
            addToWorking(value: "8")
        case 9:
            addToWorking(value: "9")
        case 10:
            addToWorking(value: ".")
        case 11:
            addToWorking(value: "+")
        case 12:
            addToWorking(value: "-")
        case 13:
            addToWorking(value: "*")
        case 14:
            addToWorking(value: "/")
        case 15:
            addToWorking(value: "%")
        default:
            return
        }
    }
    
    private func clearAll() {
        workings = ""
        questionLabel.text = ""
        answerLabel.text = ""
    }
    
    private func addToWorking(value: String) {
        workings = workings + value
        questionLabel.text = workings
    }
    
    private func formatResult(result: Double)-> String {
        if(result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    private func validInput()-> Bool {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings {
            if specialCharacter(char: char) {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        for index in funcCharIndexes {
            if index == 0 {
                return false
            }
            if index == workings.count - 1 {
                return false
            }
            if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            previous = index
        }
        return true
    }
    
    private func specialCharacter(char: Character)-> Bool {
        if char == "*" {
            return true
        }
        if char == "+" {
            return true
        }
        if char == "-" {
            return true
        }
        if char == "/" {
            return true
        }
        return false
    }
    
}
