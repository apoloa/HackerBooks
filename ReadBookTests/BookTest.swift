//
//  BookTest.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 04/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import XCTest

@testable import ReadBook
class BookTest: XCTestCase {
    
    func testCreationBook() {
        let title = "PruebaBook"
        let authors = ["A", "B"]
        let tags = ["tags", "algorithms"]
        let image = NSURL(string: "http://google.es")
        let url = NSURL(string: "http://www.amoma.com/hotel.php?key=20151207201512081205000000500000050000111115235&id=127753&referer=06658traHty5C_esB9&curid=EUR&langid=4&sessionKey=LSEtRGUxNFFvQTkyQXIxR29lNUxiTWZLWFZTbmtHYy9UQmUxbDVXbmVvVllYdThFQ1FPd2kxUkRsSWozM0twTVBtejVPN09iWVNqTG5INThYMVMwL1BQMnc9PQ%3D%3D&reqsource=2&clickThroughId=386281683")
        
        let book = Book(title: title, authors: authors, tags: tags, image: image, url: url)
        XCTAssertEqual(book.title, title)
        XCTAssertEqual(book.authors, authors)
        XCTAssertEqual(book.tags, tags)
        XCTAssertEqual(book.image, image)
        XCTAssertEqual(book.url, url)
    }
}
