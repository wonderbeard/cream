//
//  OptionalOutputMapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct OptionalizeMapperOutput<Input, Output>: Mapper {
    
    private let performMap: (Input) -> Output
    
    init<M: Mapper>(_ wrapped: M) where M.Input == Input, M.Output == Output {
        performMap = wrapped.map
    }
    
    func map(_ input: Input) -> Output? {
        return performMap(input)
    }
    
}
