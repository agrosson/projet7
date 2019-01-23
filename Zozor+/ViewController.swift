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
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
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
        if let stringNumber = stringNumbers.last {
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
                addNewNumber(index)
            }
    }

    @IBAction func multiply(_ sender: UIButton) {
        if canAddOperator {
            operators.append("*")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    @IBAction func plus() {
        if canAddOperator {
        	operators.append("+")
        	stringNumbers.append("")
            updateDisplay()
        }
    }

    @IBAction func minus() {
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
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
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }

    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        var total = ""
        for (index, number) in stringNumbers.enumerated() {
            total += operators[index] + "\(number)"
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
        for (index, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += operators[index]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
}
