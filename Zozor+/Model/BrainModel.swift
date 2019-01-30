//
//  BrainModel.swift
//  CountOnMe
//
//  Created by ALEXANDRE GROSSON on 23/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

/**
 Class that defines all the features of the calculator and functions to process calculations
 
 4 variables with initial values:
    1. stringNumbers
    2. operators
    3. var resultMemory
    4. var fatalError
 
 19 Functions
 - init()
 - gameStart()
 
 */
class Brain {
    // MARK: Properties
    /// Array that records the components of the computation
    var stringNumbers = [String()]
    /// Array that records the operators of the computation
    var operators = ["+"]
    /// Variable that stores the result of the computation
    var resultMemory = ""
    /// Boolean that tracks if the result of the computation is not an Int
    var fatalError = false
    // MARK: Methods
    /// Init ficntion
    init() {}
    /**
     Function that adds a digit when user types a number for the calculation
     - Parameter newNumber: The digit chosen by user on screen
     - Returns: The string to be displayed on screen
     
     # Important Notes #
     0 as first character of the number is not displayed on screen
     */
    func addNewNumber(_ newNumber: Int) -> String {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            // Ignore "0" at the begining for a number
            if stringNumberMutable.first == "0" {
                stringNumberMutable = "\(newNumber)"
            } else {
                stringNumberMutable += "\(newNumber)"
            }
            // replace former string with newly created stringnumber with Int just added
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        return updateDisplay()
    }
    /**
     Function that creates a String to be displayed on screen
     - Returns: The string to be displayed on screen
     # Important Notes #
     - The string is computed from 2 arrays : stringNumbers and operators
     */
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
    /**
     Function that computes the result and returns an equality String to be displayed on screen
     - Returns: The equality string to be displayed on screen
     # Important Notes #
     - The string is computed from 2 arrays : stringNumbers and operators
     */
    func calculateTotal() -> String {
        var myArrayOfNumber = [Int]()
        // Transform array of string into array of Int to be used in computation process
        for number in stringNumbers {
            myArrayOfNumber.append(Int(number)!)
        }
        // computation
        resultMemory = String(calculation(arrayOf: myArrayOfNumber, with: operators))
        // result as a equality string
        let finalResultDisplay = updateDisplay() + " = " + resultMemory
        return finalResultDisplay
    }
    /**
     Function that resets all arrays
     */
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    /**
     Function that checks if typed numbers are Int
     - Returns: Bool
     */
    func isAnInt() -> Bool {
        for number in stringNumbers {
            if Int(number) == nil {
                self.clear()
                return false
            }
        }
        return true
    }
    
    /**
     Recursive function that computes the result and returns result as a Int
     - Parameter numbers: Arrays of Int to be computed
     - Parameter operators: Arrays of String (operators) to be used
     - Returns: The result of computation as a Int
     # Important Notes #
     - The string is computed from 2 arrays : stringNumbers and operators
     - A specific computation is made depending on the number of items in the array
     */
    func calculation(arrayOf numbers: [Int], with operators: [String]) -> Int {
        // Case1
        if numbers.count == 0 {
            print("la table est vide")
            return 0
        }
        // Case 2
        if numbers.count == 1 {
            return numbers[0]
        }
        // cas 3 : Simple case with two items
        if numbers.count == 2 {
            let resultNum =  calcul2(arrayOf: numbers, with: operators)
            return resultNum
        }
        // case 4 : Recursive case
        if numbers.count >= 3 {
            // case with no priority
            if operators[2] == "+" || operators[2] == "-" {
                let firstTable = [numbers[0], numbers[1]]
                let firstOperator = ["+", operators[1]]
                var newTable = Array(numbers.dropFirst().dropFirst())
                var newOperators = Array(operators.dropFirst().dropFirst())
                newTable.insert(calculation(arrayOf: firstTable, with: firstOperator), at: 0)
                newOperators.insert("+", at: 0)
                return calculation(arrayOf: newTable, with: newOperators)
                // case with priority "*" or "/"
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
            }
        }
        return 0
    }
    /**
    Function of base case that computes the result of computation with two elements and returns result as a Int
     - Parameter numbers: Arrays of Int to be computed
     - Parameter operators: Arrays of String (operators) to be used
     - Returns: The result of the basic computation as a Int
     */
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
    /**
     Function that checks if result is a Int and returns result as a Int if so
     - Parameter num: Number to be checked
     - Returns: The result if is an Int, 0 if false
     # Important Notes #
     - The test consists in casting result as a double and checking if less that Int.max
     */
    private func checkIfNil(num: Double) -> Int {
        if num >  Double(Int.max) {
            print("error")
            self.fatalError = true
            self.clear()
            return 0
        } else {
            return Int(num)
        }
    }
}
