//
//  WritableRepository.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

protocol WritableRepository {
    
    associatedtype Entity
    
    func create(
        entity: Entity,
        success: @escaping (EntityIdentifier) -> Void,
        failure: @escaping (Error?) -> Void
    )
    
    func update(
        entity: Entity,
        for identifier: EntityIdentifier,
        success: @escaping (Entity) -> Void,
        failure: @escaping (Error?) -> Void
    )
    
    func delete(
        entityWithID entityIdentifier: EntityIdentifier,
        success: @escaping () -> Void,
        failure: @escaping (Error?) -> Void
    )
    
}

struct AnyWritableRepository<Entity>: WritableRepository {
    
    private let createEntity: (Entity,  @escaping (EntityIdentifier) -> Void, @escaping (Error?) -> Void) -> Void
    private let updateEntity: (Entity, EntityIdentifier, @escaping  (Entity) -> Void, @escaping (Error?) -> Void) -> Void
    private let deleteEntity: (EntityIdentifier, @escaping  () -> Void, @escaping (Error?) -> Void) -> Void
    
    init<R: WritableRepository>(_ wrapped: R) where R.Entity == Entity {
        createEntity = wrapped.create
        updateEntity = wrapped.update
        deleteEntity = wrapped.delete
    }
    
    func create(
        entity: Entity,
        success: @escaping (EntityIdentifier) -> Void,
        failure: @escaping (Error?) -> Void)
    {
        createEntity(entity, success, failure)
    }
    
    func update(
        entity: Entity,
        for identifier: EntityIdentifier,
        success: @escaping (Entity) -> Void,
        failure: @escaping (Error?) -> Void)
    {
        updateEntity(entity, identifier, success, failure)
    }
    
    func delete(
        entityWithID entityIdentifier: EntityIdentifier,
        success: @escaping () -> Void,
        failure: @escaping (Error?) -> Void)
    {
        deleteEntity(entityIdentifier, success, failure)
    }
    
}
