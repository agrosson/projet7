//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    let brain = Brain()
    var isExpressionCorrect: Bool {
        if let stringNumber = brain.stringNumbers.last {
            if stringNumber.isEmpty {
                if brain.stringNumbers.count == 1 {
                    alertNewCalculation()
                } else {
                    alertEnterCorrectExpression()
                }
                return false
            }
        }
        return true
    }
    var canAddOperator: Bool {
        if let stringNumber = brain.stringNumbers.last {
            if stringNumber.isEmpty {
                alertIncorrectExpresion()
                return false
            }
        }
        return true
    }
    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (index, numberButton) in numberButtons.enumerated() where sender == numberButton {
                print(index)
                addNewNumber(index)
            }
    }

    @IBAction func multiply(_ sender: UIButton) {
        if canAddOperator {
            brain.operators.append("*")
            brain.stringNumbers.append("")
            updateDisplay()
        }
    }
    @IBAction func plus() {
        if canAddOperator {
        	brain.operators.append("+")
        	brain.stringNumbers.append("")
            updateDisplay()
        }
    }

    @IBAction func minus() {
        if canAddOperator {
            brain.operators.append("-")
            brain.stringNumbers.append("")
            updateDisplay()
        }
    }

    @IBAction func divide(_ sender: UIButton) {
        if canAddOperator {
            brain.operators.append("/")
            brain.stringNumbers.append("")
            updateDisplay()
        }
    }
    @IBAction func equal() {
        calculateTotal()
    }

    // MARK: - Methods

    func alertNewCalculation() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Démarrez un nouveau calcul !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    func alertEnterCorrectExpression() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Entrez une expression correcte !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    func alertIncorrectExpresion() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Expression incorrecte !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = brain.stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            brain.stringNumbers[brain.stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }

    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        var total = ""
        for (index, number) in brain.stringNumbers.enumerated() {
            total += brain.operators[index] + "\(number)"
        }
        print(total)
        if total.first == "+" {
            total = String(total.dropFirst())
        }
        let mathExpression = NSExpression(format: total)
        let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Int
        textView.text += "=\(mathValue!)"
        clear()
    }

    func updateDisplay() {
        var text = ""
        for (index, myNumber) in brain.stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += brain.operators[index]
            }
            // Add number
            text += myNumber
        }
        textView.text = text
    }

    func clear() {
        brain.stringNumbers = [String()]
        brain.operators = ["+"]
    }
}
