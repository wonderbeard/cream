//
//  IceCreamListInteractorInterface.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

enum IceCreamListState {
    case list([IceCream])
    case error(Error?)
}

protocol IceCreamListInteractorInput {
    
    func observeList(handler: @escaping (IceCreamListState) -> Void)
    
}
