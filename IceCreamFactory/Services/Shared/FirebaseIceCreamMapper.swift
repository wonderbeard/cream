//
//  FirebaseIceCreamMapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 09.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct FirebaseIceCreamMapper: Mapper {
    
    func map(_ iceCream: IceCream) -> [String:Any] {
        return [
            "name": iceCream.name,
            "weight": iceCream.weight as Any,
            "color": iceCream.color as Any,
            "flavor": iceCream.flavor as Any,
            "temp": iceCream.temp as Any
        ]
    }
    
}
