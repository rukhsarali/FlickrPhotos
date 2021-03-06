//
//  FlickrPhotosModel.swift
//  FlickrPhotos
//
//  Created by Rukhsar Ali on 26/11/2021.
//

import Foundation
struct FlickrPhotosModel : Codable {
    let photos : Photos?
    let stat : String?

    enum CodingKeys: String, CodingKey {

        case photos = "photos"
        case stat = "stat"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photos = try values.decodeIfPresent(Photos.self, forKey: .photos)
        stat = try values.decodeIfPresent(String.self, forKey: .stat)
    }

}
struct Photos : Codable {
    let page : Int?
    let pages : Int?
    let perpage : Int?
    let total : Int?
    let photo : [Photo]?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case total = "total"
        case photo = "photo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        pages = try values.decodeIfPresent(Int.self, forKey: .pages)
        perpage = try values.decodeIfPresent(Int.self, forKey: .perpage)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        photo = try values.decodeIfPresent([Photo].self, forKey: .photo)
    }

}
struct Photo : Codable {
    let id : String?
    let owner : String?
    let secret : String?
    let server : String?
    let farm : Int?
    let title : String?
    let ispublic : Int?
    let isfriend : Int?
    let isfamily : Int?
    let ownername : String?
    let url_m : String?
    let height_m : Int?
    let width_m : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
        case ispublic = "ispublic"
        case isfriend = "isfriend"
        case isfamily = "isfamily"
        case ownername = "ownername"
        case url_m = "url_m"
        case height_m = "height_m"
        case width_m = "width_m"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        owner = try values.decodeIfPresent(String.self, forKey: .owner)
        secret = try values.decodeIfPresent(String.self, forKey: .secret)
        server = try values.decodeIfPresent(String.self, forKey: .server)
        farm = try values.decodeIfPresent(Int.self, forKey: .farm)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        ispublic = try values.decodeIfPresent(Int.self, forKey: .ispublic)
        isfriend = try values.decodeIfPresent(Int.self, forKey: .isfriend)
        isfamily = try values.decodeIfPresent(Int.self, forKey: .isfamily)
        ownername = try values.decodeIfPresent(String.self, forKey: .ownername)
        url_m = try values.decodeIfPresent(String.self, forKey: .url_m)
        height_m = try values.decodeIfPresent(Int.self, forKey: .height_m)
        width_m = try values.decodeIfPresent(Int.self, forKey: .width_m)
    }

}


