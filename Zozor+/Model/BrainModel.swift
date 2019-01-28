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
    var resultMemory = ""
    var fatalError = false
    init() {}
    func addNewNumber(_ newNumber: Int) -> String {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            if stringNumberMutable.first == "0" {
                stringNumberMutable = "\(newNumber)"
            } else {
                stringNumberMutable += "\(newNumber)"
            }
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        return updateDisplay()
    }
    func updateDisplay() -> String {
        var text = ""
        for (index, myNumber) in stringNumbers.enumerated() {
            // Add operator
            if index > 0 { // the first "+" is not displayed
                text += operators[index]
            }
            // Add number
            text += myNumber
        }
        return text
    }
    func calculateTotal() -> String {
        var myArrayOfNumber = [Int]()
        for number in stringNumbers {
            myArrayOfNumber.append(Int(number)!)
        }
        resultMemory = String(calculation(arrayOf: myArrayOfNumber, with: operators))
        let finalResultDisplay = updateDisplay() + " = " + resultMemory
        return finalResultDisplay
    }
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    func isAnInt() -> Bool {
        for number in stringNumbers {
            if Int(number) == nil {
                return false
            }
        }
        return true
    }
    func calculation(arrayOf numbers: [Int], with operators: [String]) -> Int {
        // Case1
        if numbers.count == 0 {
            print("la table est vide")
            return 0
        }
        // Cas 2
        if numbers.count == 1 {
            return numbers[0]
        }
        // cas 3
        if numbers.count == 2 {
            let resultNum =  calcul2(arrayOf: numbers, with: operators)
            return resultNum
        }
        // cas 4
        if numbers.count >= 3 {
            if operators[2] == "+" || operators[2] == "-" {
                let firstTable = [numbers[0], numbers[1]]
                let firstOperator = ["+", operators[1]]
                var newTable = Array(numbers.dropFirst().dropFirst())
                var newOperators = Array(operators.dropFirst().dropFirst())
                newTable.insert(calculation(arrayOf: firstTable, with: firstOperator), at: 0)
                newOperators.insert("+", at: 0)
                return calculation(arrayOf: newTable, with: newOperators)
            } else if operators[2] == "*" || operators[2] == "/" {
                let firstTable = [numbers[1], numbers[2]]
                let firstOperator = [operators[1], operators[2]]
                var newTable = numbers
                newTable.remove(at: 1)
                newTable.remove(at: 1)
                newTable.insert(calculation(arrayOf: firstTable, with: firstOperator), at: 1)
                var newOperators = operators
                newOperators.remove(at: 2)
                return calculation(arrayOf: newTable, with: newOperators)
            } else {
                return 0
            }
        }
        return 0
    }
     private func calcul2(arrayOf numbers: [Int], with operators: [String]) -> Int {
        var result: Double = 0
        let num1 = Double(numbers[0])
        let num2 = Double(numbers[1])
        if operators[1] == "+" {
            result = num1 + num2
            return checkIfNil(num: result)
        }
        if operators[1] == "-" {
            result = num1 - num2
            return checkIfNil(num: result)
        }
        if operators[1] == "*" {
           result = num1 * num2
             return checkIfNil(num: result)
        }
        if operators[1] == "/" {
           result = num1 / num2
             return checkIfNil(num: result)
        }
        return Int(result)
    }
    private func checkIfNil(num: Double) -> Int {
        if num >  Double(Int.max) {
            print("error")
            self.fatalError = true
            return 0
        } else {
            return Int(num)
        }
    }
}
