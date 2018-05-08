//
//  CreateIceCreamInteractor.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

class CreateIceCreamInteractor: CreateIceCreamInteractorInput {
    
    private let iceCreamRepository: AnyWritableRepository<IceCream>
    
    init<R: WritableRepository>(iceCreamRepository: R) where R.Entity == IceCream {
        self.iceCreamRepository = AnyWritableRepository(iceCreamRepository)
    }
    
    func createIceCream(
        _ iceCream: IceCream,
        success: @escaping () -> Void,
        failure: @escaping (CreateIceCreamInteractorError) -> Void)
    {
        iceCreamRepository.create(
            entity: iceCream,
            success: { entityID in
                success()    
            },
            failure: { error in
                failure(.failedToCreate)
            }
        )
    }
    
}
