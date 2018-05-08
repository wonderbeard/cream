//
//  IceCreamWeightMapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct IceCreamWeightMapper: BidirectionalMapper {
 
    private let formatter = NumberFormatter()
    
    func map(_ weight: Double?) -> String? {
        return weight.map(NSNumber.init).flatMap(formatter.string)
    }
    
    func reverseMap(_ weightText: String?) -> Double? {
        return weightText.flatMap(formatter.number)?.doubleValue
    }
    
}
