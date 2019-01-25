//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by ALEXANDRE GROSSON on 23/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
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
}
