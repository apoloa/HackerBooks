//
//  FrameworkExtensionsTest.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 08/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import XCTest
@testable import ReadBook

class FrameworkExtensionsTest: XCTestCase {

    func testArrayCreatedWithStrings() {
        let correctString = "Hello, how are you?"
        
        let array = String.createArray(withLiteralString:correctString, separator:",")
        
        XCTAssertEqual(array, ["Hello", "how are you?"])
        
        let noCommaString = "Hola"
        
        let newArray = String.createArray(withLiteralString: noCommaString, separator: ",")
        
        XCTAssertEqual(newArray, ["Hola"])
    }

    

}
