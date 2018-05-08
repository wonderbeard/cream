//
//  CreateIceCreamInteractorInterface.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

enum CreateIceCreamInteractorError: Error {
    case failedToCreate
}

protocol CreateIceCreamInteractorInput {
    
    func createIceCream(
        _ iceCream: IceCream,
        success: @escaping () -> Void,
        failure: @escaping (CreateIceCreamInteractorError) -> Void
    )
    
}
