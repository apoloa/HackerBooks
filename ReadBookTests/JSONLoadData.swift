//
//  DownloadJSON.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 06/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//


import XCTest

@testable import ReadBook

class JSONLoadData: XCTestCase {

    func testDownload(){
        let _ = getJSONData()
        
        let _ = getJSONData()
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            let _ = getJSONData()
        }
    }
    
    func testPerformanceNSDefault(){
        let _ = getJSONData()
        
        self.measureBlock({
            let _ = getJSONData()
        })
    }
    
    func testLoadData(){
        let data = getJSONData()
        do{
            let strictBooks = try decode(data: data)
            XCTAssertNotNil(strictBooks)
            XCTAssertEqual(strictBooks.count, 30)
            let library = Library.init(strictBooks: strictBooks)
            XCTAssertEqual(library.books.count, 30)
            XCTAssertEqual(library.tags.count,62)
        }catch{
            
        }
    }
}
