//
//  IceCreamListPresenter.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

class IceCreamListPresenter {
    
    private enum Constants {
        static let listObservationFailureMessage = "Failed to read ice cream list"
    }
    
    var view: IceCreamListViewInput!
    var interactor: IceCreamListInteractorInput!
    
    var iceCreamTemperatureMapper: AnyMapper<Double?, String?>!
    var iceCreamNameMapper: AnyMapper<String?, String?>!
    var iceCreamColorMapper: AnyMapper<String?, String?>!
    var iceCreamFlavorMapper: AnyMapper<String?, String?>!
    
    func itemViewModel(from iceCream: IceCream) -> IceCreamListItemViewModel {
        return IceCreamListItemViewModel(
            name: iceCreamNameMapper.map(iceCream.name),
            flavor: iceCreamFlavorMapper.map(iceCream.flavor),
            temp: iceCreamTemperatureMapper.map(iceCream.temp),
            color: iceCreamColorMapper.map(iceCream.color)
        )
    }
    
}

extension IceCreamListPresenter: IceCreamListViewOutput {
    
    func viewIsReady() {
        interactor.observeList { [unowned self] state in
            switch state {
            case .list(let iceCream):
                let itemViewModels = iceCream.map(self.itemViewModel)
                self.view.setListItems(itemViewModels)
            case .error:
                self.view.setErrorMessage(Constants.listObservationFailureMessage)
            }
        }
    }
    
}
