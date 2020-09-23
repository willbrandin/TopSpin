//
//  Match+Extensions.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import Foundation

extension Match {
    var shortDate: String {
        guard let date = self.date else {
            return ""
        }
        
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "MMM d"
        
        return dateFormmater.string(from: date)
    }
}
