//
//  IceCreamTemperatureMapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct IceCreamTemperatureMapper: Mapper {
    
    var formatter = NumberFormatter()
    
    func map(_ input: Double?) -> String? {
        return input
            .map(NSNumber.init)
            .flatMap(formatter.string)
            .map{ $0 + "ºC" }
    }
    
}
