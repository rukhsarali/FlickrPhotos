//
//  RealmData.swift
//  FlickrPhotos
//
//  Created by Rukhsar Ali on 27/11/2021.
//

import Foundation
import RealmSwift

class RealmData : Object {
    @objc dynamic var indexPath: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var ownerName: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var selfIndexPath: Int = 0
   
}
