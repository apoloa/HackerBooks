//: Playground - noun: a place where people can play

import UIKit

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

struct constants {
    
    static let nsUserJsonString : String = "jsonPDFs"
    static let urlJSON : String = "https://t.co/K9ziV0z3SJ"
    static let characterSeparatorJSON : Character = ","
    
}

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
            let book = StrictBook(title: title, tags: tags, authors: authors, pdfUrl: url, imageUrl: imageUrl)
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

func getJSONData()->NSData{
    let defaults = NSUserDefaults.standardUserDefaults()
    
    if let json = defaults.objectForKey(constants.nsUserJsonString) as? NSData{
        return json
    }else{
        // Download Data
        if let url = NSURL(string: constants.urlJSON),
            dataJSON = NSData(contentsOfURL: url) {
                defaults.setObject(dataJSON, forKey: constants.nsUserJsonString)
                return dataJSON
        }else{
            fatalError("We can't donwload files")
        }
        
    }
}

do {
    let data = getJSONData()
    let strictBooks = try decode(data: data)
    print(strictBooks[9].pdfUrl)

    
}catch{
    fatalError("")
}

dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [] in
    let data = getJSONData()
}


