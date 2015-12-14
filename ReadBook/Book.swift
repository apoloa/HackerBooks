//
//  Book.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 03/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//
//  This class represents a book
//

import UIKit

class Book : NSObject, Comparable {
    
    // MARK: - Attributes
    let title : String
    let authors : [String]
    let tags : [String]
    let imageUrl: NSURL?
    let url: NSURL?
    var favorite: Bool = false {
        didSet{
            sendNotifications()
        }
    }
    var book : NSData? = nil
    var image: UIImage? = nil
    
    // To DownloadBook
    weak var delegate: BookDownloadDelegate?
    var downloadTask: NSURLSessionDownloadTask? = nil
    var backgroundSession: NSURLSession? = nil
    
    func sendNotifications(){
        if favorite {
            addFavorite(title)
        }else{
            removeFavorite(title)
        }
        NSNotificationCenter.defaultCenter().postNotificationName(NotificationKeys.notifyUpdates, object: nil, userInfo: nil )
    }
    
    init(title: String, authors: [String], tags: [String], image: NSURL?, url: NSURL?){
        self.title = title
        self.authors = authors
        self.tags = tags
        self.imageUrl = image
        self.url = url
        let fileMgr = FilesManager()
        if let url = image,
            nameUrl = url.lastPathComponent{
                if let dataImage = fileMgr.readFile(nameUrl, folderType: Folders.ImagesFolder){
                    self.image = UIImage(data: dataImage)
                }else{
                    if let data = NSData(contentsOfURL: url){
                        self.image = UIImage(data: data)
                        fileMgr.writeFile(nameUrl, data: data, folderType: Folders.ImagesFolder)
                    }
                }
        }
        if let url = url,
            namePdf = url.lastPathComponent{
                if let dataPdf = fileMgr.readFile(namePdf, folderType: Folders.BookFolders){
                    book = dataPdf
                }
        }
    }
    
}


extension Book {
    // MARK: - Proxies
    var proxyForComparison: String{
        get{
            return "\(title)\(authors)\(tags)\(imageUrl)\(url)"
        }
    }
    
    var proxyForSorting: String{
        get{
            return "A\(title)\(authors)"
        }
    }
}

extension Book {
    var authorsString : String {
        get{
            return authors.joinWithSeparator(", ")
        }
    }
    var tagsString: String{
        get{
            return tags.joinWithSeparator(", ")
        }
    }
}

extension Book : NSURLSessionDownloadDelegate {
    // TODO: Descargar libro
    func downloadBook(){
        if let url = url,
            namePdf = url.lastPathComponent{
            let urlSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(namePdf)
            
            backgroundSession = NSURLSession(configuration: urlSessionConfiguration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
            
            downloadTask = backgroundSession?.downloadTaskWithURL(url)
            downloadTask?.resume()
            
        }
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        if let data = NSData(contentsOfURL: location){
            book = data
            if let url = url,
                namePdf = url.lastPathComponent{
                    let fileMgr = FilesManager()
                    fileMgr.writeFile(namePdf, data: data, folderType: Folders.BookFolders)
                    
            }
            self.delegate?.finish()
            //self.downloadTask?.finalize()
            self.downloadTask = nil
            //self.backgroundSession?.finalize()
            self.backgroundSession = nil
        }
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        let totalBytesWritten = Float.init(integerLiteral: totalBytesWritten)
        let totalBytesExpectedToWrite = Float.init(integerLiteral: totalBytesExpectedToWrite)
        self.delegate?.update(totalBytesWritten/totalBytesExpectedToWrite)
    }
}


func ==(lhs: Book, rhs: Book) -> Bool{
    // First Case: Same Object
    if lhs == rhs {
        return true
    }
    
    // Second Case: Diferent types
    if lhs.dynamicType != rhs.dynamicType {
        return false
    }
    
    return (lhs.proxyForComparison == rhs.proxyForComparison)
}

func <(lhs: Book, rhs: Book) ->Bool{
    return (lhs.proxyForSorting < rhs.proxyForSorting)
}

protocol BookDownloadDelegate : class{
    func update(process:Float)
    func finish()
}

