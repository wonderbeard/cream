//
//  IceCream.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct IceCream {
    var name: String
    var weight: Double?
    var color: String?
    var flavor: String?
    var temp: Double?
}

extension IceCream {
    
    static var empty: IceCream {
        return IceCream(
            name: "",
            weight: nil,
            color: nil,
            flavor: nil,
            temp: nil
        )
    }
    
}
