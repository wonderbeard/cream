//
//  FirebaseWritableRepository.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FirebaseWritableRepository<Entity>: WritableRepository {
    
    var route: DatabaseReference
    var entityMapper: AnyMapper<Entity, [String:Any]>
    
    func create(
        entity: Entity,
        success: @escaping (EntityIdentifier) -> Void,
        failure: @escaping (Error?) -> Void)
    {
        let entityJSON = entityMapper.map(entity)
        let newEntity = route.childByAutoId()
        newEntity.setValue(entityJSON) { (error, ref) in
            if let error = error {
                failure(error)
            } else {
                success(newEntity.key)
            }
        }
    }
    
    func update(
        entity: Entity,
        for identifier: EntityIdentifier,
        success: @escaping () -> Void,
        failure: @escaping (Error?) -> Void)
    {
        let entityJSON = entityMapper.map(entity)
        route.child(identifier).updateChildValues(entityJSON) { (error, ref) in
            if let error = error {
                failure(error)
            } else {
                success()
            }
        }
    }
    
    func delete(
        entityWithID identifier: EntityIdentifier,
        success: @escaping () -> Void,
        failure: @escaping (Error?) -> Void)
    {
        route.child(identifier).removeValue { (error, ref) in
            if let error = error {
                failure(error)
            } else {
                success()
            }
        }
    }
    
}
