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
        if textView.text.contains(" = ") {
            brain.operators = ["+"]
            brain.stringNumbers = [brain.resultMemory]
            textView.text = brain.updateDisplay()
            return true
        }
        return true
    }
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    // MARK: - Action
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (index, numberButton) in numberButtons.enumerated() where sender == numberButton {
            if textView.text.contains("=") {
                brain.clear()
            }
            textView.text =  brain.addNewNumber(index)
            if !brain.isAnInt() {
                alertIncorrectInt()
            }
        }
    }
    @IBAction func multiply(_ sender: UIButton) {
        if canAddOperator {
            brain.operators.append("*")
            brain.stringNumbers.append("")
            textView.text = brain.updateDisplay()
        }
    }
    @IBAction func plus() {
        if canAddOperator {
            brain.operators.append("+")
            brain.stringNumbers.append("")
            textView.text =  brain.updateDisplay()
        }
    }
    @IBAction func minus() {
        if canAddOperator {
            brain.operators.append("-")
            brain.stringNumbers.append("")
            textView.text =  brain.updateDisplay()
        }
    }
    @IBAction func divide(_ sender: UIButton) {
        if canAddOperator {
            brain.operators.append("/")
            brain.stringNumbers.append("")
            textView.text = brain.updateDisplay()
        }
    }
    @IBAction func equal() {
        if !isExpressionCorrect {
            return
        }
        if textView.text.contains("/0") {
            alertDivideByZero()
            return
        }
        textView.text = brain.calculateTotal()
        if brain.fatalError == true {
            alertIncorrectResultInt()
        }
    }
    @IBAction func clearScreen(_ sender: UIButton) {
        brain.clear()
        brain.fatalError = false
        textView.text = "0"
    }
    // MARK: - Methods
    func alertDivideByZero() {
        let alertVC = UIAlertController(title: "Impossible de diviser par 0!",
                                        message: "Démarrez un nouveau calcul !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
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
    func alertIncorrectInt() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Ce chiffre n'est pas un Int !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    func alertIncorrectResultInt() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Ce résultat n'est pas un Int !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
