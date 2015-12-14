//: Playground - noun: a place where people can play

import UIKit

let filemgr = NSFileManager.defaultManager()


let currentPath = filemgr.currentDirectoryPath

let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)

let docsDir = dirPaths[0]

let newDir = docsDir.stringByAppendingString("/images")

let pdfDir = docsDir.stringByAppendingFormat("/books")

try filemgr.createDirectoryAtPath(newDir, withIntermediateDirectories: true, attributes: nil)

try filemgr.createDirectoryAtPath(pdfDir, withIntermediateDirectories: true, attributes: nil)

let dirPathsNew = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)

let fileList = try filemgr.contentsOfDirectoryAtPath(docsDir)

//let attrib = try filemgr.attributesOfFileSystemForPath(.DocumentDirectory)

filemgr.changeCurrentDirectoryPath(pdfDir)

let url = NSURL(string: "http://hackershelf.com/media/cache/46/61/46613d24474140c53ea6b51386f888ff.jpg")
url?.lastPathComponent


let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)

let docsDir2 = dirPaths[0]

let pathDirectory = NSSearchPathDirectory.UserDirectory.rawValue

let directory = try filemgr.contentsOfDirectoryAtPath(filemgr.currentDirectoryPath)



let fileMgr = NSFileManager.defaultManager()

let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)

let documentsPaths = paths[0]



filemgr.changeCurrentDirectoryPath(documentsPaths)

let filePath = try filemgr.contentsOfDirectoryAtPath(filemgr.currentDirectoryPath)

enum Folders : String {
    case ImagesFolder = "/images"
    case BookFolders = "/books"
    case DefaultDirectory
}

class FileManager {
    
    let fileMgr = NSFileManager.defaultManager()
    var defaultPath :String
    
    init(){
        defaultPath = ""
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsPath = paths[0]
        fileMgr.changeCurrentDirectoryPath(documentsPath)
        
        print(fileMgr.currentDirectoryPath)
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
            print(defaultPath)
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


let filMgr = FileManager()

let data = NSData(contentsOfURL: url!)
let name = url?.lastPathComponent

filMgr.writeFile(name!, data: data!, folderType: Folders.ImagesFolder)

filMgr.containsFile(name!, folderType: Folders.ImagesFolder)

let DataFromSandBox = filMgr.readFile(name!, folderType: Folders.ImagesFolder)



