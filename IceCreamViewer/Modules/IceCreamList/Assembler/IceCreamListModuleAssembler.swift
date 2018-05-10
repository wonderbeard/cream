//
//  IceCreamListAssembly.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit

struct IceCreamListModuleAssembler {
    
    var view: IceCreamListViewController
    var presenter: IceCreamListPresenter
    var interactor: IceCreamListInteractor
    
    func assembly() {
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.iceCreamNameMapper = CapitalizedStringMapper().optionalized()
        presenter.iceCreamTemperatureMapper = AnyMapper(IceCreamTemperatureMapper())
        presenter.iceCreamColorMapper = UppercasedStringMapper().optionalized()
        presenter.iceCreamFlavorMapper = CapitalizedStringMapper().optionalized()
    }
    
}
