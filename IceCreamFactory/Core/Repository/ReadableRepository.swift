//
//  ReadableRepository.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

protocol ReadableRepository {
    
    associatedtype Entity
    
    func entity(
        withID identifier: EntityIdentifier,
        success: @escaping (Entity) -> Void,
        failure: @escaping (Error?) -> Void
    )
    
    func allEntities(
        success: @escaping ([(EntityIdentifier, Entity)]) -> Void,
        failure: @escaping (Error?) -> Void
    )
    
}

struct AnyReadableRepository<Entity>: ReadableRepository {
    
    private let getEntity: (EntityIdentifier, @escaping (Entity) -> Void, @escaping (Error?) -> Void) -> Void
    private let getAllEntities: (@escaping ([(EntityIdentifier, Entity)]) -> Void, @escaping (Error?) -> Void) -> Void
    
    init<R: ReadableRepository>(_ wrapped: R) where R.Entity == Entity {
        getEntity = wrapped.entity
        getAllEntities = wrapped.allEntities
    }
    
    func entity(
        withID identifier: EntityIdentifier,
        success: @escaping (Entity) -> Void,
        failure: @escaping (Error?) -> Void)
    {
        getEntity(identifier, success, failure)
    }
    
    func allEntities(
        success: @escaping ([(EntityIdentifier, Entity)]) -> Void,
        failure: @escaping (Error?) -> Void)
    {
        getAllEntities(success, failure)
    }
    
}
