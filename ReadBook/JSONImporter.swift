//
//  JSONImporter.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 08/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit

// MARK: - Aliases
typealias JSONObject        = AnyObject
typealias JSONDictionary    = [String:JSONObject]
typealias JSONArray         = [JSONDictionary]

// MARK: - Structs
struct StrictBook {
    let title       : String
    let tags        : [String]
    let authors     : [String]
    let pdfUrl      : NSURL
    let imageUrl    : NSURL
    let favorite    : Bool
}

// MARK: - Enums 
enum JSONKeys: String{
    case authors    = "authors"
    case imageUrl   = "image_url"
    case pdfUrl     = "pdf_url"
    case tags       = "tags"
    case title      = "title"
}

enum ErrorParsing :ErrorType{
    case WrongURLFormatToNSData
    case ErrorParsingJsonData
    case WrongURLFormatForJSONResource
}

func decode(book json: JSONDictionary, favorites: Array<String>) throws -> StrictBook{
    guard let urlString = json[JSONKeys.pdfUrl.rawValue] as? String,
        url = NSURL(string: urlString) else{
            throw ErrorParsing.WrongURLFormatForJSONResource
    }
    
    guard let imageUrlString = json[JSONKeys.imageUrl.rawValue] as? String,
        imageUrl = NSURL(string: imageUrlString) else{
            throw ErrorParsing.WrongURLFormatForJSONResource
    }
    
    if let tagsString = json[JSONKeys.tags.rawValue] as? String,
        authorsString = json[JSONKeys.authors.rawValue] as? String,
        title = json[JSONKeys.title.rawValue] as? String {
            
            let tags = String.createArray(withLiteralString: tagsString, separator: constants.characterSeparatorJSON)
            let authors = String.createArray(withLiteralString: authorsString, separator: constants.characterSeparatorJSON)
            let book = StrictBook(title: title, tags: tags, authors: authors, pdfUrl: url, imageUrl: imageUrl, favorite: favorites.contains(title))
            return book
            
    }
    throw ErrorParsing.WrongURLFormatForJSONResource
}

func decode(book json: JSONDictionary) throws -> StrictBook{
    guard let urlString = json[JSONKeys.pdfUrl.rawValue] as? String,
        url = NSURL(string: urlString) else{
            throw ErrorParsing.WrongURLFormatForJSONResource
    }
    
    guard let imageUrlString = json[JSONKeys.imageUrl.rawValue] as? String,
        imageUrl = NSURL(string: imageUrlString) else{
            throw ErrorParsing.WrongURLFormatForJSONResource
    }
    
    if let tagsString = json[JSONKeys.tags.rawValue] as? String,
        authorsString = json[JSONKeys.authors.rawValue] as? String,
        title = json[JSONKeys.title.rawValue] as? String {
            
            let tags = String.createArray(withLiteralString: tagsString, separator: constants.characterSeparatorJSON)
            let authors = String.createArray(withLiteralString: authorsString, separator: constants.characterSeparatorJSON)
            let book = StrictBook(title: title, tags: tags, authors: authors, pdfUrl: url, imageUrl: imageUrl, favorite: false)
            return book
            
    }
    throw ErrorParsing.WrongURLFormatForJSONResource
}

func decode(books json: JSONArray) throws -> [StrictBook]{
    let books = try json.map({try decode(book: $0)})
    return books
}

func decode(data data: NSData) throws -> [StrictBook]{
    
    let jsonArrayData = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
    
    if let jsonArray = jsonArrayData as? JSONArray{
        let strictBooks = try decode(books: jsonArray)
        return strictBooks
    }
    
    throw ErrorParsing.ErrorParsingJsonData
}

func decode(data data: NSData, favorites: Array<String>, funcNotification: (StrictBook) -> Bool, completeNotification: ()->()) throws {
    let jsonArrayData = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
    
    if let jsonArray = jsonArrayData as? JSONArray{
        for json in jsonArray{
            let book = try decode(book: json, favorites:favorites)
            if !funcNotification(book) {
                throw ErrorParsing.ErrorParsingJsonData
            }
        }
    }
    
    completeNotification()
}

// MARK: - Extensions For Classes

extension Book {
    convenience init(strictbook st: StrictBook){
        self.init(title: st.title, authors: st.authors, tags: st.tags, image:st.imageUrl, url:st.pdfUrl)
        self.favorite = st.favorite
    }
}

extension Library {
    convenience init(strictBooks sts: [StrictBook]){
        let books = sts.map({Book.init(strictbook:$0)})
        self.init(arrayOfBooks: books)
    }
    
    func addBook(strictBook st: StrictBook)-> Bool{
        
        loadingLibrary = true
        let book = Book(strictbook: st)
        if books.isEmpty {
            let userInfo = NSDictionary(object: book, forKey: "Book")
            NSNotificationCenter.defaultCenter().postNotificationName(NotificationKeys.firstBook, object: nil, userInfo: userInfo as [NSObject : AnyObject])
            
        }
        self.books.append(book)
        let tags = book.tags.filter({!self.tags.contains($0)})
        
        self.tags.appendContentsOf(tags)
        self.tags.sortInPlace()
        self.books.sortInPlace()
        self.delegate?.addNewBook()
        return true
    }
    
    func completeBook(){
        loadingLibrary = false
        delegate?.completeLoadBooks()
    }
}


