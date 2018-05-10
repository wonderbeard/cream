//
//  NumberFormatterBidirectionalMapperAdapter.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct NumberFormatterBidirectionalMapperAdapter: BidirectionalMapper {
    
    var formatter: NumberFormatter
    
    init(_ adaptee: NumberFormatter) {
        self.formatter = adaptee
    }
    
    func map(_ weight: Double?) -> String? {
        return weight.map(NSNumber.init).flatMap(formatter.string)
    }
    
    func reverseMap(_ weightText: String?) -> Double? {
        return weightText.flatMap(formatter.number)?.doubleValue
    }
    
}
