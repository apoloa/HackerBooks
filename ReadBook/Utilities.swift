//
//  Utilities.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 06/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit


func getJSONData() -> NSData {
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