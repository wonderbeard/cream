//
//  FirebaseObjectToIceCreamMapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct FirebaseObjectToIceCreamMapper: Mapper {
    
    func map(_ json: [String : Any]) -> IceCream? {
        guard let name = json["name"] as? String else {
            return nil
        }
        return IceCream(
            name: name,
            weight: json["weight"] as? Double,
            color: json["color"] as? String,
            flavor: json["flavor"] as? String,
            temp: json["temp"] as? Double
        )
    }
    
}
