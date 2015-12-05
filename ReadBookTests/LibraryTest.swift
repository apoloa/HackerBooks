//
//  LibraryTest.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 04/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import XCTest

@testable import ReadBook
class LibraryTest: XCTestCase {

    var books = [Book]()
    var library : Library = Library(arrayOfBooks: [])
    
    override func setUp() {
        var title = "PruebaBook"
        var authors = ["A", "B"]
        var tags = ["tags", "algorithms"]
        var image = NSURL(string: "http://google.es")
        var url = NSURL(string: "http://www.amoma.com/hotel.php?key=20151207201512081205000000500000050000111115235&id=127753&referer=06658traHty5C_esB9&curid=EUR&langid=4&sessionKey=LSEtRGUxNFFvQTkyQXIxR29lNUxiTWZLWFZTbmtHYy9UQmUxbDVXbmVvVllYdThFQ1FPd2kxUkRsSWozM0twTVBtejVPN09iWVNqTG5INThYMVMwL1BQMnc9PQ%3D%3D&reqsource=2&clickThroughId=386281683")
        
        var book = Book(title: title, authors: authors, tags: tags, image: image, url: url)
        
        books.append(book)
        
        authors = ["Scott Chacon", "Ben Straub"]
        image = NSURL(string: "http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg")
        url = NSURL(string:"https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf")
        tags = ["version control","git"]
        title = "Pro Git"
        
        book = Book(title: title, authors: authors, tags: tags, image: image, url: url)
        
        books.append(book)
        library = Library(arrayOfBooks: books)
    }
    
    func testCreateLibrary() {
        XCTAssertNotNil(library)
    }
    
    func testCountTags(){
        let numTags = library.countTags
        XCTAssertEqual(numTags, 4)
    }
    
    func testGetTagName(){
        let firstTag = library[tag:0]
        XCTAssertEqual(firstTag, "tags")
        
        let secondTag = library[tag:4]
        XCTAssertEqual(secondTag, "")
        
        let thirdTag = library[tag:-1]
        XCTAssertEqual(thirdTag, "")
    }
    
    func testGetBooksForTags(){
        let book = library[0, tag:0]
        XCTAssertNotNil(book) // Check if book is not nil
        
        XCTAssertEqual(book?.title, "PruebaBook")
    }
    
    func testNumberOfBooksForTag(){
        let numberOfBooks = library.countBooks(tag:0)
        XCTAssertEqual(numberOfBooks,1)
        
        let numberOfBookError = library.countBooks(tag: 4)
        XCTAssertEqual(numberOfBookError, 0)
    }
    
}
