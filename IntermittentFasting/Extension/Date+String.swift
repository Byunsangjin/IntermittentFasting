//
//  Date+String.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 26/04/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

extension Date {
    
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm"
        return dateFormatter.string(from: self)
    }
    
    
    
    func stringToDate(from: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm"
        let date = dateFormatter.date(from: from)
        
        return date!
    }
}
