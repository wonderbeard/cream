//
//  BidirectionalMapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

protocol BidirectionalMapper: Mapper {
    
    func reverseMap(_ output: Output) -> Input
    
}

struct AnyBidirectionalMapper<Input, Output>: BidirectionalMapper {
    
    private let performMap: (Input) -> Output
    private let performReverseMap: (Output) -> Input
    
    init<B: BidirectionalMapper>(_ wrapped: B) where B.Input == Input, B.Output == Output {
        performMap = wrapped.map
        performReverseMap = wrapped.reverseMap
    }
    
    init<M: Mapper, R: Mapper>(forward: M, reverse: R) where M.Input == Input, M.Output == Output, R.Input == Output, R.Output == Input {
        performMap = forward.map
        performReverseMap = reverse.map
    }
    
    func map(_ input: Input) -> Output {
        return performMap(input)
    }
    
    func reverseMap(_ output: Output) -> Input {
        return performReverseMap(output)
    }
    
}
