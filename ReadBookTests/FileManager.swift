//
//  FileManager.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 13/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import XCTest
@testable import ReadBook

class FileManager: XCTestCase {

    func testSaveAndRecu() {
        let fileMgr = FilesManager()
        let url = NSURL(string: "http://hackershelf.com/media/cache/46/61/46613d24474140c53ea6b51386f888ff.jpg")
        let data = NSData(contentsOfURL: url!)
        let name = url?.lastPathComponent
        
        fileMgr.writeFile(name!, data: data!, folderType: Folders.ImagesFolder)
        
        fileMgr.containsFile(name!, folderType: Folders.ImagesFolder)
        
        let DataFromSandBox = fileMgr.readFile(name!, folderType: Folders.ImagesFolder)
        
        XCTAssertEqual(data, DataFromSandBox)
    }
}
