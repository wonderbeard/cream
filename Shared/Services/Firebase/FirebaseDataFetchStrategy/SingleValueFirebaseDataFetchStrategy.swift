//
//  SingleValueFirebaseDataFetchStrategy.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct SingleValueFirebaseDataFetchStrategy: FirebaseDataFetchStrategy {
    
    func fetch(
        from route: DatabaseQuery,
        success: @escaping (DataSnapshot) -> Void,
        failure: @escaping (Error) -> Void)
    {
        route.observeSingleEvent(of: .value, with: success, withCancel: failure)
    }
    
}
