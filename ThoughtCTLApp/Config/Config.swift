//
//  Config.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 15/12/23.
//

import Foundation

//All App config related changes need to be added here
struct Config{
    static let url = "https://api.imgur.com/3/"
    static let clientID = "Client-ID 35094e914ced1dd"
}

//Api related details need to be added
enum Api{
    case gallery(queryParam:String)
    func getURLRequest()->URLRequest?{
        var urlString = Config.url
        var method = ""
        switch self{
        case .gallery(let queryParam):
            urlString+=queryParam
            method="GET"
        }
        guard let url = URL(string: urlString) 
        else {
            debugPrint("Invalid URL")
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.addValue(Config.clientID, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
