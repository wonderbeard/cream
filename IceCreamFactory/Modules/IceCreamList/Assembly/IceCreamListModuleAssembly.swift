//
//  IceCreamListAssembly.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit
import ObjectiveC

struct IceCreamListModuleAssembly: ModuleAssembly {
    
    var view: IceCreamListViewController
    var presenter: IceCreamListPresenter
    var interactor: IceCreamListInteractor
    
    func assemble() -> (Void, UIViewController) {
        objc_setAssociatedObject(view, "presenter", presenter, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.iceCreamNameMapper = AnyMapper(OptionalizeMapper(CapitalizedStringMapper()))
        presenter.iceCreamTemperatureMapper = AnyMapper(IceCreamTemperatureMapper())
        presenter.iceCreamColorMapper = AnyMapper(OptionalizeMapper(UppercasedStringMapper()))
        presenter.iceCreamFlavorMapper = AnyMapper(OptionalizeMapper(CapitalizedStringMapper()))
        return ((), view)
    }
    
}
