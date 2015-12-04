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

class Book{
    
    // MARK: - Attributes
    let title : String
    let authors : [String]
    let tags : [String]
    let image: NSURL?
    let url: NSURL?
    
    
    init(title: String, authors: [String], tags: [String], image: NSURL?, url: NSURL?){
        self.title = title
        self.authors = authors
        self.tags = tags
        self.image = image
        self.url = url
    }
}

