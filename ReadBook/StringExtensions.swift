//
//  StringExtensions.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 08/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import Foundation

// MARK - Extension
extension String{
    
    func trim() -> String{
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    static func createArray(withLiteralString literalString: String, separator: Character) -> [String] {
        let array = literalString.characters.split{$0 == separator}.map(String.init)
        let trimmedArray = array.map({$0.trim()})
        return trimmedArray
    }
}
