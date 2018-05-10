//
//  CreateIceCreamModuleAssembly.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit

struct CreateIceCreamAssembly: ModuleAssembly {
    
    var view: CreateIceCreamViewController
    var interactor: CreateIceCreamInteractor
    var presenter: CreateIceCreamPresenter
    
    func assemble() -> (Void, UIViewController) {
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.weightMapper = AnyBidirectionalMapper(IceCreamWeightMapper())
        presenter.temperatureMapper = AnyBidirectionalMapper(NumberFormatterBidirectionalMapperAdapter(NumberFormatter()))
        return ((), view)
    }
    
}
