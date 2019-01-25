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
}
