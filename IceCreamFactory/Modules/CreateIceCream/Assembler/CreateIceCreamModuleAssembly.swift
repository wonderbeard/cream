//
//  CreateIceCreamModuleAssembly.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit

struct CreateIceCreamAssembler {
    
    var view: CreateIceCreamViewController
    var interactor: CreateIceCreamInteractor
    var presenter: CreateIceCreamPresenter
    
    func assembly() {
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.weightMapper = AnyBidirectionalMapper(IceCreamWeightMapper())
        presenter.temperatureMapper = AnyBidirectionalMapper(NumberFormatterBidirectionalMapperAdapter(NumberFormatter()))
    }
    
}
