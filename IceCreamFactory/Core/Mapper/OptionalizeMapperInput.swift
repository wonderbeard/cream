//
//  OptionalizeMapperInput.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct OptionalizeMapperInput<Input, Output>: Mapper {
    
    private let performMap: (Input) -> Output
    private let mapNil: () -> Output
    
    init<M: Mapper>(_ wrapped: M, nilMapping: @escaping () -> Output) where M.Input == Input, M.Output == Output {
        performMap = wrapped.map
        mapNil = nilMapping
    }
    
    func map(_ input: Input?) -> Output {
        return input.map(performMap) ?? mapNil()
    }
    
}
