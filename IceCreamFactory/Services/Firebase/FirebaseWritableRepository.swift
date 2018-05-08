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
        
    }
    
    func update(
        entity: Entity,
        for identifier: EntityIdentifier,
        success: @escaping (Entity) -> Void,
        failure: @escaping (Error?) -> Void)
    {
        
    }
    
    func delete(
        entityWithID entityIdentifier: EntityIdentifier,
        success: @escaping () -> Void,
        failure: @escaping (Error?) -> Void)
    {
        
    }
    
}
