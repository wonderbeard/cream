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

extension Mapper {
    
    func chain<M: Mapper>(_ mapper: M) -> AnyMapper<Input, M.Output> where M.Input == Output {
        return AnyMapper { input in
            mapper.map(self.map(input))
        }
    }
    
    func optionalizeInput(nilMapping mapNil: @escaping () -> Output) -> AnyMapper<Input?, Output> {
        return AnyMapper { input in
            input.map(self.map) ?? mapNil()
        }
    }
    
    func optinalizeOutput() -> AnyMapper<Input, Output?> {
        return AnyMapper { input in
            self.map(input)
        }
    }
    
    func optionalized() -> AnyMapper<Input?, Output?> {
        return AnyMapper{ input in
            input.map(self.map)
        }
    }
    
}
