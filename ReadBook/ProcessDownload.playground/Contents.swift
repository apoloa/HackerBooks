//: This playgroun see the process to download the files.

import UIKit

enum ErrorParsing :ErrorType{
    case WrongURLFormatToNSData
    case ErrorParsingJsonData
    case WrongURLFormatForJSONResource
}

enum JSONKeys: String{
    case authors    = "authors"
    case imageUrl   = "image_url"
    case pdfUrl     = "pdf_url"
    case tags       = "tags"
    case title      = "title"
}

struct StrictBook {
    let title       : String
    let tags        : [String]
    let authors     : [String]
    let pdfUrl      : NSURL
    let imageUrl    : NSURL
}


// MARK: - Aliases
typealias JSONObject        = AnyObject
typealias JSONDictionary    = [String:JSONObject]
typealias JSONArray         = [JSONDictionary]


func parseString(values: String) -> [String]{
    
    let data = values.characters.split{$0 == ","}.map(String.init)
    
    return data
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
            
            let tags = parseString(tagsString)
            let authors = parseString(authorsString)
            
            let book = StrictBook(title: title, tags: tags, authors: authors, pdfUrl: url, imageUrl: imageUrl)
            
            return book
            
    }
    
    throw ErrorParsing.WrongURLFormatForJSONResource
}


func decode(books json: JSONArray) throws -> [StrictBook]{
    let books = try json.map({try decode(book: $0)})
    return books
}

let stringUrl : String = "https://t.co/K9ziV0z3SJ"

let url : NSURL? = NSURL(string: stringUrl)

if let cUrl = url {
    let jsonData = NSData(contentsOfURL: cUrl)
    guard jsonData != nil,
    let jsonDataCorrect = jsonData else{
        throw ErrorParsing.WrongURLFormatToNSData
    }
    
    do{
        let jsonArrayData = try NSJSONSerialization.JSONObjectWithData(jsonDataCorrect, options: .AllowFragments)
        let strictBooks = try decode(books: jsonArrayData as! JSONArray)
        print(strictBooks.count)
    }catch{
        
    }
    
}


extension String{
    static func createArray(withLiteralString literalString: String, separatator: Character) -> [String] {
        let array = literalString.characters.split{$0 == separatator}.map(String.init)
        let trimmedArray = array.map({$0.trim()})
        return trimmedArray
    }
}

extension String
{
    func trim() -> String{
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}


String.createArray(withLiteralString: "Hola,Hola, Que,Tal?", separatator: ",")


let StringTest = "       Esto es un Test"
let Trimming = StringTest.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
print(StringTest)
print(Trimming)



print(parseString("hola"))




