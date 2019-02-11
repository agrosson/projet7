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
    /// Variable that tests if expression typed is correct for computing
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
    /// Variable that tests if an operator can be added on screen
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
            textViewScrollToBottom()
            if !brain.isAnInt() {
                alertIncorrectInt()
            }
        }
    }
    @IBAction func multiply(_ sender: UIButton) {
        if canAddOperator {
            brain.operators.append("*")
            updateScreen()
        }
    }
    @IBAction func plus() {
        if canAddOperator {
            brain.operators.append("+")
            updateScreen()
        }
    }
    @IBAction func minus() {
        if canAddOperator {
            brain.operators.append("-")
            updateScreen()
        }
    }
    @IBAction func divide(_ sender: UIButton) {
        if canAddOperator {
            brain.operators.append("/")
            updateScreen()
        }
    }
    @IBAction func equal() {
        if !isExpressionCorrect {
            return
        }
        if textView.text.contains("/\n0") {
            alertDivideByZero()
            brain.clear()
            textView.text = "0"
            return
        }
        if textView.text.contains("/") {
            alertDivide()
        }
        textView.text = brain.calculateTotal()
        textViewScrollToBottom()
        if brain.fatalError == true {
            alertIncorrectResultInt()
            textView.text = "0"
            brain.clear()
            brain.fatalError = false
        }
    }
    @IBAction func clearScreen(_ sender: UIButton) {
        brain.clear()
        textView.text = "0"
    }
    // MARK: - Methods
    private func updateScreen() {
        brain.stringNumbers.append("")
        textView.text = brain.updateDisplay()
    }
    private func textViewScrollToBottom() {
        let bottom = NSRange(location: textView.text.count, length: 1)
        textView.scrollRangeToVisible(bottom)
    }
    private func alertDivideByZero() {
        let alertVC = UIAlertController(title: "Impossible de diviser par 0!",
                                        message: "Démarrez un nouveau calcul !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    private func alertNewCalculation() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Démarrez un nouveau calcul !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    private func alertEnterCorrectExpression() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Entrez une expression correcte !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    private func alertIncorrectExpresion() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Expression incorrecte !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    private func alertIncorrectInt() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Ce chiffre n'est pas un Int !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    private func alertIncorrectResultInt() {
        let alertVC = UIAlertController(title: "Zéro!",
                                        message: "Ce résultat n'est pas un Int !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    private func alertDivide() {
        let alertVC = UIAlertController(title: "Attention!",
                                        message: """
                                        Une division avec des INT ne tient pas compte des décimales!
                                        Il se peut que le résultat soit tronqué!
                                        """,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
