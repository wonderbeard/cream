//
//  FirebaseReadableRepository.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum FirebaseDatabaseRepositoryError: Error {
    case dataRetrieval
    case mapping
}

struct FirebaseReadableRepository<Entity>: ReadableRepository {
    
    var route: DatabaseReference
    var entityMapper: AnyMapper<DataSnapshot, Entity?>
    var entityCollectionMapper: AnyMapper<DataSnapshot, [(EntityIdentifier, Entity)]>
    
    func entity(
        withID identifier: EntityIdentifier,
        success: @escaping (Entity) -> Void,
        failure: @escaping (Error?) -> Void)
    {
        route
            .child(identifier)
            .single(.value, with: entityMapper, success: { entity in
                if let entity = entity {
                    success(entity)
                } else {
                    failure(FirebaseDatabaseRepositoryError.mapping)
                }
            }, failure: failure)
    }
    
    func allEntities(
        success: @escaping ([(EntityIdentifier, Entity)]) -> Void,
        failure: @escaping (Error?) -> Void)
    {
        route.single(.value, with: entityCollectionMapper, success: success, failure: failure)
    }
    
}

private extension DatabaseReference {
    
    func single<E>(
        _ eventType: DataEventType,
        with mapper: AnyMapper<DataSnapshot, E>,
        success: @escaping (E) -> Void,
        failure: @escaping (Error) -> Void)
    {
        observeSingleEvent(
            of: eventType,
            with: { dataSnapshot in
                let entity = mapper.map(dataSnapshot)
                success(entity)
            },
            withCancel: { error in
                failure(FirebaseDatabaseRepositoryError.dataRetrieval)
            }
        )
    }
    
}
