//
//  Library.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 04/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit


class Library {
    // MARK: - Variables
    var books : [Book]
    var tags : [String]
    var loadingLibrary : Bool = false
    weak var delegate: LibraryDelegate?
    // MARK - Constructor
    
    init (){
        books = []
        tags = []
    }
    
    init (arrayOfBooks books: [Book], tags: [String]){
        self.books = books
        self.tags = tags
    }
    
}

// This extension can help to create a Library. 
extension Library {
    
    convenience init(arrayOfBooks books: [Book]){
        let tags = Library.getAllTags(arrayOfBooks: books)
        
        self.init(arrayOfBooks:books, tags:tags)
    }
    
    private static func getAllTags(arrayOfBooks books:[Book]) -> [String]{
        var tags : [String] = []
        for book in books{
            for tag in book.tags{
                if !tags.contains(tag){
                    tags.append(tag)
                    continue
                }
            }
        }
        return tags
    }
    
}

extension Library{
    var countTags: Int{
        get{
            return tags.count + 1
        }
    }
    
    func countBooks(tag t: Int) -> Int{
        if t == 0{
            let booksTag = books.filter({$0.favorite})
            return booksTag.count
        }
        if t >= 0 && t < tags.count {
            let sTag = tags[t]
            let booksTag = books.filter({$0.tags.contains(sTag)})
            return booksTag.count
            
        }
        return 0
    }
    
    subscript(tag tagId :Int) -> String{
        if tagId == 0{
            return "FAVORITES"
        }
        if tagId >= 0 && tagId < tags.count {
            return tags[tagId].uppercaseString
        }
        
        return ""
    }
    
    subscript(idBook: Int, tag tagId:Int) -> Book?{
        if tagId == 0{
            let booksTag = books.filter({$0.favorite})
            return booksTag[idBook]
        }
        if tagId >= 0 && tagId < tags.count {
            let sTag = tags[tagId]
            let booksTag = books.filter({$0.tags.contains(sTag)})
            if idBook >= 0 && idBook < booksTag.count{
                return booksTag[idBook]
            }
            return nil
        }
        return nil
    }
}

protocol LibraryDelegate: class{
    func addNewBook()
    func completeLoadBooks()
}
