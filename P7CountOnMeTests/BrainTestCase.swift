//
//  BrainTestCase.swift
//  P7CountOnMeTests
//
//  Created by ALEXANDRE GROSSON on 25/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class BrainTestCase: XCTestCase {
        func testFirst() {
            XCTAssert(true)
        }
        func testGivenDataAlready_WhenUpdateDisplay_ThenStringIsCorrect() {
            //Given
            let brain = Brain()
            brain.stringNumbers = ["4", "6", "9"]
            brain.operators = ["+", "+", "*"]
            // When
            let result = brain.updateDisplay()
            // Test
            XCTAssert(result == "4+6*9")
        }
        func test1GivenFirstCharacterIsZero_WhenAddSecondCharacter_ThenDropFirstCharacter() {
            //Given
            let brain = Brain()
            brain.stringNumbers = ["0"]
            brain.operators = ["+"]
            // When
            let result = brain.addNewNumber(2)
            // Test
            XCTAssert(result == "2")
        }
        func test2GivenFirstCharacterIsZero_WhenAddSecondCharacter_ThenDropFirstCharacter() {
            //Given
            let brain = Brain()
            brain.stringNumbers = ["22", "0"]
            brain.operators = ["+", "+"]
            // When
            let result = brain.addNewNumber(2)
            // Test
            XCTAssert(result == "22+2")
        }
        func test2GivenFirstCharacterIsNotZero_WhenAddSecondCharacter_ThenNotDropFirstCharacter() {
        //Given
        let brain = Brain()
        brain.stringNumbers = ["22", "4"]
        brain.operators = ["+", "+"]
        // When
        let result = brain.addNewNumber(2)
        // Test
        XCTAssert(result == "22+42")
    }
        func testGivenOperatorsAndStringNumbersAreMoreThanOne_WhenClear_ThenOperatorsAndStringNumbersAreReset() {
            //Given
            let brain = Brain()
            brain.stringNumbers = ["22", "10"]
            brain.operators = ["+", "+"]
            // When
            brain.clear()
            // Test
            XCTAssert(brain.stringNumbers == [""] && brain.operators == ["+"] )
        }
        func testGiven4plus6times6_WhenCalculateTotal_ThenIsString4plus6times6equals40() {
            //Given
            let brain = Brain()
            brain.stringNumbers = ["4", "6", "6"]
            brain.operators = ["+", "+", "*"]
            // When
            let result = brain.calculateTotal()
            // Test
            XCTAssert(result == "4+6*6 = 40")
        }
    func testGiven4plus6plus6_WhenCalculateTotal_ThenIsString4plus6plus6equals16() {
        //Given
        let brain = Brain()
        brain.stringNumbers = ["4", "6", "6"]
        brain.operators = ["+", "+", "+"]
        // When
        let result = brain.calculateTotal()
        // Test
        XCTAssert(result == "4+6+6 = 16")
    }
    func testGivenMultiplyLongINT_WhenCalculateTotal_ThenFatalErrorIsTrue() {
        //Given
        let brain = Brain()
        brain.stringNumbers = ["4444444444444444", "4444444444444444", "4444444444444444"]
        brain.operators = ["*", "*", "*"]
        // When
        let result = brain.calculateTotal()
        // Test
        XCTAssert(brain.fatalError == true)
        XCTAssert(result == "4444444444444444*4444444444444444*4444444444444444 = 0")
    }
    func testGivenLonString_WhenCalculateTotal_ThenIsStringequals90() {
        //Given
        let brain = Brain()
        brain.stringNumbers = ["100", "10", "100", "10", "5", "2"]
        brain.operators = ["+", "-", "+", "/", "-", "*"]
        // When
        let result = brain.calculateTotal()
        // Test
        XCTAssert(result == "100-10+100/10-5*2 = 90")
    }
    func testGiven10divide2plus6_WhenCalculateTotal_ThenIsString10divide2plus6equals11() {
        //Given
        let brain = Brain()
        brain.stringNumbers = ["10", "2", "6"]
        brain.operators = ["+", "/", "+"]
        // When
        let result = brain.calculateTotal()
        // Test
        XCTAssert(result == "10/2+6 = 11")
    }
    func testGivenAllNumbersAreInt_WhenIsAnInt_ThenReturnTrue() {
    //Given
        let brain = Brain()
        brain.stringNumbers = ["4", "6", "6"]
    // When
        let answer = brain.isAnInt()
    // Test
    XCTAssert(answer == true)
    }
    func testGivenNotAllNumbersAreInt_WhenIsAnInt_ThenReturnFalse() {
        //Given
        let brain = Brain()
        brain.stringNumbers = ["444444444444444444444444444444444444444", "6", "6"]
        // When
        let answer = brain.isAnInt()
        // Test
        XCTAssert(answer == false)
    }
    func testGivenNumberEmpty_WhenCalculation_ThenReturn0() {
    //Given
        let brain = Brain()
        let stringNum = [Int]()
        let oper = [String]()
    // When
        let result = brain.calculation(arrayOf: stringNum, with: oper)
    // Test
    XCTAssert(result == 0)
    }
    func testGivenNumberHasOneElemznt_WhenCalculation_ThenReturnUniqueElement() {
        //Given
        let brain = Brain()
        brain.stringNumbers = ["6"]
        // When
        let result = brain.calculateTotal()
        // Test
        XCTAssert(result == "6 = 6")
}
}
