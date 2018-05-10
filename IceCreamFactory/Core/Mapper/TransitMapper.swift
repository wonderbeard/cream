//
//  TransitMapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct TransitMapper<Input, Output>: Mapper {
    
    private let performMap: (Input) -> Output
    
    init<M1: Mapper, M2: Mapper>(_ m1: M1, _ m2: M2) where M1.Input == Input, M1.Output == M2.Input, M2.Output == Output {
        performMap = { input in
            m2.map(m1.map(input))
        }
    }
    
    func map(_ input: Input) -> Output {
        return performMap(input)
    }
    
}
