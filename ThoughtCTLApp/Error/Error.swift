//
//  Error.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 15/12/23.
//

import Foundation

enum ApiError:Error{
    case networkError
    case invalidUrl
    case badResponse
    case otherError(msg:String)
}
