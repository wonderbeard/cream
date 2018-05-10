//
//  UppercasedStringMapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct UppercasedStringMapper: Mapper {
    
    func map(_ input: String) -> String {
        return input.uppercased()
    }
    
}
