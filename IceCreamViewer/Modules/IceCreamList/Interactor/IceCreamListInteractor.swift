//
//  IceCreamListInteractor.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct IceCreamListInteractor: IceCreamListInteractorInput {
    
    private let iceCreamRepository: AnyReadableRepository<IceCream>
    
    init<R: ReadableRepository>(iceCreamRepository: R) where R.Entity == IceCream {
        self.iceCreamRepository = AnyReadableRepository(iceCreamRepository)
    }
    
    func observeList(handler: @escaping (IceCreamListState) -> Void) {
        iceCreamRepository.allEntities(
            success: { iceCreamEntities in
                let iceCream = iceCreamEntities.map{ (_, iceCream) in iceCream }
                handler(.list(iceCream))
            },
            failure: { error in
                handler(.error(error))
            }
        )
    }
    
}
