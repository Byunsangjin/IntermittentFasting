//
//  Date+String.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 26/04/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

extension Date {
    
    
    func timeToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm"
        return dateFormatter.string(from: self)
    }
    
    
    
    func stringToTime(from: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm"
        let time = dateFormatter.date(from: from)
        
        return time!
    }
    
    
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
    
    
    
    func stringToDate(from: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let date = dateFormatter.date(from: from)
        
        return date!
    }
}
