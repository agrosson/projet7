//
//  BrainModel.swift
//  CountOnMe
//
//  Created by ALEXANDRE GROSSON on 23/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Brain {
    var stringNumbers = [String()]
    var operators = ["+"]
    init() {}
    func addNewNumber(_ newNumber: Int) -> String {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        return updateDisplay()
    }
    func updateDisplay() -> String {
        var text = ""
        for (index, myNumber) in stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += operators[index]
            }
            // Add number
            text += myNumber
        }
        return text
    }
    func calculateTotal() -> String {
        var total = ""
        for (index, number) in stringNumbers.enumerated() {
            total += operators[index] + "\(number)"
        }
        if total.first == "+" {
            total = String(total.dropFirst())
        }
        let mathExpression = NSExpression(format: total)
        let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Int
        let finalResultDisplay = updateDisplay() + "= " + String(mathValue!)
        return finalResultDisplay
    }
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
}
