//
//  FirebaseReadableRepository.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum FirebaseRepositoryError: Error {
    case dataRetrieval
    case mapping
}

struct FirebaseReadableRepository<Entity>: ReadableRepository {
    
    var route: DatabaseReference
    var dataFetchStrategy: FirebaseDataFetchStrategy
    var entityMapper: AnyMapper<DataSnapshot, Entity?>
    var entityCollectionMapper: AnyMapper<DataSnapshot, [(EntityIdentifier, Entity)]?>
    
    init(
        route: DatabaseReference,
        dataFetchStrategy: FirebaseDataFetchStrategy = SingleValueFirebaseDataFetchStrategy(),
        entityMapper: AnyMapper<DataSnapshot, Entity?>,
        entityCollectionMapper: AnyMapper<DataSnapshot, [(EntityIdentifier, Entity)]?>)
    {
        self.route = route
        self.dataFetchStrategy = dataFetchStrategy
        self.entityMapper = entityMapper
        self.entityCollectionMapper = entityCollectionMapper
    }
    
    func entity(
        withID identifier: EntityIdentifier,
        success resolve: @escaping (Entity) -> Void,
        failure reject: @escaping (Error?) -> Void)
    {
        fetchData(
            from: route.child(identifier),
            using: entityMapper,
            success: resolve,
            failure: { error in
                reject(error)
            }
        )
    }
    
    func allEntities(
        success resolve: @escaping ([(EntityIdentifier, Entity)]) -> Void,
        failure reject: @escaping (Error?) -> Void)
    {
        fetchData(
            from: route.queryOrderedByKey(),
            using: entityCollectionMapper,
            success: resolve,
            failure: { error in
                reject(error)
            }
        )
    }
    
    private func fetchData<T>(
        from route: DatabaseQuery,
        using mapper: AnyMapper<DataSnapshot, T?>,
        success resolve: @escaping (T) -> Void,
        failure reject: @escaping (FirebaseRepositoryError) -> Void)
    {
        dataFetchStrategy.fetch(
            from: route,
            success: { [mapper] dataSnapshot in
                if let mappedData = mapper.map(dataSnapshot) {
                    resolve(mappedData)
                } else {
                    reject(.mapping)
                }
            },
            failure: { error in
                reject(.dataRetrieval)
            }
        )
    }
    
}
