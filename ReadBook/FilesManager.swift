//
//  FilesManager.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 13/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit

enum Folders : String {
    case ImagesFolder = "/images"
    case BookFolders = "/books"
    case DefaultDirectory
}

class FilesManager {
    
    let fileMgr = NSFileManager.defaultManager()
    var defaultPath :String
    
    init(){
        defaultPath = ""
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsPath = paths[0]
        fileMgr.changeCurrentDirectoryPath(documentsPath)
        do{
            let filePath = try fileMgr.contentsOfDirectoryAtPath(fileMgr.currentDirectoryPath)
            let pathOfDocuments = fileMgr.currentDirectoryPath
            defaultPath = pathOfDocuments
            if !filePath.contains("images"){
                try fileMgr.createDirectoryAtPath(fileMgr.currentDirectoryPath + Folders.ImagesFolder.rawValue, withIntermediateDirectories: true, attributes: nil)
                fileMgr.changeCurrentDirectoryPath(pathOfDocuments)
            }
            if !filePath.contains("books"){
                try fileMgr.createDirectoryAtPath(fileMgr.currentDirectoryPath + Folders.BookFolders.rawValue, withIntermediateDirectories: true, attributes: nil)
                fileMgr.changeCurrentDirectoryPath(pathOfDocuments)
            }
        }catch{
            
        }
        
    }
    
    private func changeToDirectory(folder: Folders)-> Bool{
        if (folder == Folders.DefaultDirectory){
            return fileMgr.changeCurrentDirectoryPath(defaultPath)
        }
        return fileMgr.changeCurrentDirectoryPath(fileMgr.currentDirectoryPath + folder.rawValue)
    }
    
    
    func containsFile(name: String, folderType: Folders) -> Bool{
        guard changeToDirectory(Folders.DefaultDirectory) else{
            return false
        }
        guard changeToDirectory(Folders.ImagesFolder) else{
            return false
        }
        do{
            let files = try fileMgr.contentsOfDirectoryAtPath(fileMgr.currentDirectoryPath)
            if(files.contains(name)){
                return true
            }else{
                return false
            }
        }catch{
            return false
        }
    }
    
    func readFile(name: String, folderType: Folders) -> NSData?{
        if(containsFile(name, folderType: folderType)){
            return fileMgr.contentsAtPath(fileMgr.currentDirectoryPath + "/" + name)
        }else{
            return nil
        }
    }
    
    func writeFile(name: String, data: NSData, folderType: Folders) -> Bool{
        guard changeToDirectory(Folders.DefaultDirectory) else{
            return false
        }
        guard changeToDirectory(folderType) else{
            return false
        }
        
        data.writeToFile(fileMgr.currentDirectoryPath + "/" + name, atomically: true)
        
        return true
    }
}
