//
//  StringExtension.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 15/12/23.
//

import Foundation

extension String{
    //Check whether string is empty or not
    var isStringEmpty:Bool{
        if isEmpty{return true}
        let trimWhitespace = trimmingCharacters(in: .whitespacesAndNewlines)
        if trimWhitespace.isEmpty{return true}
        return false
    }
    
    //Encode string
    func encodedString()->String?{
        let text = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}
