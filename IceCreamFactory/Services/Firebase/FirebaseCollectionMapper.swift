//
//  FirebaseCollectionMapper.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RxSwift

struct FirebaseCollectionMapper<Entity>: Mapper {
    
    var entityMapper: AnyMapper<[String: Any], Entity?>
    
    func map(_ snapshot: DataSnapshot) -> [(EntityIdentifier, Entity)]? {
        let collection = snapshot.value as? [EntityIdentifier: [String: Any]]
        return collection?.compactMap { entityID, entityDictionary in
            return entityMapper
                .map(entityDictionary)
                .flatMap{ entity in (entityID, entity) }
        }
    }
    
}
