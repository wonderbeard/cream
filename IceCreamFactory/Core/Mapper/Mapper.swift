//
//  Mapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

protocol Mapper {
    
    associatedtype Input
    associatedtype Output
    
    func map(_ input: Input) -> Output
    
}

struct AnyMapper<Input, Output>: Mapper {
    
    private let performMap: (Input) -> Output
    
    init<M: Mapper>(_ wrapped: M) where M.Input == Input, M.Output == Output {
        performMap = wrapped.map
    }
    
    init(_ mapping: @escaping (Input) -> Output) {
        performMap = mapping
    }
    
    func map(_ input: Input) -> Output {
        return performMap(input)
    }
    
}
