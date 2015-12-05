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
    let books : [Book]
    let tags : [String]
    
    // MARK - Constructor
    
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
            return tags.count
        }
    }
    
    func countBooks(tag t: Int) -> Int{
        var numBooks = 0
        if t >= 0 && t < tags.count {
            let sTag = tags[t]
            for book in books{
                if book.tags.contains(sTag){
                    numBooks += 1
                }
            }
        }
        return numBooks
    }
    
    subscript(tag tagId :Int) -> String{
        
        if tagId >= 0 && tagId < tags.count {
            return tags[tagId]
        }
        
        return ""
    }
    
    subscript(idBook: Int, tag tagId:Int) -> Book?{
        if tagId >= 0 && tagId < tags.count {
            let sTag = tags[tagId]
            for book in books{
                if book.tags.contains(sTag){
                    return book
                }
            }
        }
        return nil
    }
}
