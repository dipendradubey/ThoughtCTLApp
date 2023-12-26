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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.dateTime = try container.decode(Int.self, forKey: .dateTime)
        self.imageCount = try container.decodeIfPresent(Int.self, forKey: .imageCount)
        
        self.images = try container.decodeIfPresent([ImageInfo].self, forKey: .images)
        if let images = self.images{
            
        }
    }
}


struct ImageInfo:Decodable{
    let type:String?
    let link:String?
}
