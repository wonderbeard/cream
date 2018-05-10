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

extension Reactive where Base: DatabaseQuery {
    
    func observe(_ eventType: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create { [ref = base] observer in
            
            let subscription = ref.observe(eventType, with: { snapshot in
                
                observer.onNext(snapshot)
                
            }, withCancel: observer.onError)
            
            return Disposables.create {
                ref.removeObserver(withHandle: subscription)
            }
        }
    }
    
//    func observeCollectionChanges() -> Observable<CollectionEvent<FirebaseEntity>> {
//        return Observable.merge(
//            observeCollection(.childAdded).map(CollectionEvent.added),
//            observeCollection(.childChanged).map(CollectionEvent.changed),
//            observeCollection(.childRemoved).map(CollectionEvent.removed)
//        )
//    }
//
//    private func observeCollection(_ event: FIRDataEventType) -> Observable<FirebaseEntity> {
//        return observe(event)
//            .filter{ $0.value is FirebaseObject }
//            .map{ snapshot in (snapshot.key, snapshot.value as! FirebaseObject) }
//    }
}
