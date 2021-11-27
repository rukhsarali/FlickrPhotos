//
//  SavedItems.swift
//  FlickrPhotos
//
//  Created by Rukhsar Ali on 27/11/2021.
//

import Foundation


struct SavedItems {
    
    static var selectedRows : [Int] {
        get{
            return UserDefaults.standard.array(forKey: "selectedStar") as? [Int] ?? []
        }set{
            UserDefaults.standard.setValue(newValue, forKey: "selectedStar")
        }
    }

    static var realmRows : [Int] {
        get{
            return UserDefaults.standard.array(forKey: "realmRows") as? [Int] ?? []
        }set{
            UserDefaults.standard.setValue(newValue, forKey: "realmRows")
        }
    }
}



