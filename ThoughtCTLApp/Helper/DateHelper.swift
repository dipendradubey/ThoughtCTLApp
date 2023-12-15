//
//  DateHelper.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 15/12/23.
//

import Foundation

class DateHelper {
    
    //Created static property to stop initialising each time while getting date string
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy hh:mm a"
        return formatter
    }()
    
    static func formatDate(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return dateFormatter.string(from: date)
    }
}
