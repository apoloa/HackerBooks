//
//  DownloadJSON.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 06/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//


import XCTest

@testable import ReadBook

class DownloadJSON: XCTestCase {

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
}
