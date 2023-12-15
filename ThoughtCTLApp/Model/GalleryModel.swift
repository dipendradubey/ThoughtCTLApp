//
//  GalleryModel.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 15/12/23.
//

import Foundation

struct GalleryRootModel:Decodable{
    let data:[Gallery]
}

struct Gallery:Decodable, Identifiable{
    let id:String
    let title:String
    let dateTime:Int
    let imageCount:Int?
    let images:[ImageInfo]?
    
    enum CodingKeys: String,CodingKey{
        case id
        case title
        case dateTime = "datetime"
        case imageCount = "images_count"
        case images
    }
}


struct ImageInfo:Decodable{
    let type:String?
    let link:String?
}
