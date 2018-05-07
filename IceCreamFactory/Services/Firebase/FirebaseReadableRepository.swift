//
//  FirebaseReadableRepository.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation
import FirebaseDatabase


struct FirebaseReadableRepository<Entity>: ReadableRepository {
    
    var route: DatabaseReference
    var entityMapper: AnyMapper<DataSnapshot, Entity>
    var entityCollectionMapper: AnyMapper<DataSnapshot, [(EntityIdentifier, Entity)]>
    
    func entity(
        withID identifier: EntityIdentifier,
        success: @escaping (Entity) -> Void,
        failure: @escaping (Error?) -> Void)
    {
        route.child(identifier).single(.value, with: entityMapper, success: success, failure: failure)
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
                do {
                    let entity = try mapper.map(dataSnapshot)
                    success(entity)
                } catch {
                    failure(error)
                }
            },
            withCancel: { error in
                failure(error)
            }
        )
    }
    
}
