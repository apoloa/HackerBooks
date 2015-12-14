//
//  Utilities.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 06/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit


/**
 Function that permit get JSONData
 - returns: NSData with the json contains
*/
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

func getFavorites() -> Array<String>{
    let defaults  = NSUserDefaults.standardUserDefaults()
    if let array = defaults.objectForKey(constants.nsUserFavoritesString) as? Array<String>{
        return array
    }
    return []
}

func setFavorites(favorites : Array<String>){
    let defaults  = NSUserDefaults.standardUserDefaults()
    defaults.setObject(favorites, forKey: constants.nsUserFavoritesString)
}

func addFavorite(book: String){
    var favorites = getFavorites()
    favorites.append(book)
    setFavorites(favorites)
}

func removeFavorite(book: String){
    var favorites = getFavorites()
    if let index = favorites.indexOf(book){
        favorites.removeAtIndex(index)
        setFavorites(favorites)
    }
}

func loadLibrary() -> Library{
    do {
        let data = getJSONData()
        let strictBooks = try decode(data: data)
        let library = Library.init(strictBooks: strictBooks)
        return library
    }catch{
        fatalError("")
    }
}

func loadAsyncLibrary() -> Library{
    let library : Library = Library()
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
        let data = getJSONData()
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)){
            do{
                try decode(data: data, favorites: getFavorites(), funcNotification: library.addBook, completeNotification:  library.completeBook)
            }catch{
                fatalError("")
            }
            
        }
    }
    return library
}

