//
//  Repository.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

typealias EntityIdentifier = String

typealias Repository = ReadableRepository & WritableRepository

struct AnyRepository<Entity>: Repository {
    
    private let getEntity: (EntityIdentifier, @escaping (Entity) -> Void, @escaping (Error?) -> Void) -> Void
    private let getAllEntities: (@escaping ([(EntityIdentifier, Entity)]) -> Void, @escaping (Error?) -> Void) -> Void
    private let createEntity: (Entity,  @escaping (EntityIdentifier) -> Void, @escaping (Error?) -> Void) -> Void
    private let updateEntity: (Entity, EntityIdentifier, @escaping  (Entity) -> Void, @escaping (Error?) -> Void) -> Void
    private let deleteEntity: (EntityIdentifier, @escaping  () -> Void, @escaping (Error?) -> Void) -> Void
    
    init<R: ReadableRepository, W: WritableRepository>(reader: R, writer: W) where R.Entity == Entity, W.Entity == Entity {
        getEntity = reader.entity
        getAllEntities = reader.allEntities
        createEntity = writer.create
        updateEntity = writer.update
        deleteEntity = writer.delete
    }
    
    init<R: Repository>(_ wrapped: R) where R.Entity == Entity {
        self.init(reader: wrapped, writer: wrapped)
    }
    
    // MARK: - ReadableRepository
    
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
    
    // MARK: - WritableRepository
    
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
