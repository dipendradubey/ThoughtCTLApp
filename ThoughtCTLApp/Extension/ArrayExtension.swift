//
//  ArrayExtension.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 15/12/23.
//

import Foundation

//Added extension for Array to sort in descending order of time
extension Array where Element == Gallery{
    var arrSorted:[Element]{
        return self.sorted{ $0.dateTime > $1.dateTime}
    }
}
