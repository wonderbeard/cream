//
//  CreateIceCreamPresenter.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

class CreateIceCreamPresenter {
    
    weak var output: CreateIceCreamPresenterOutput?
    var view: CreateIceCreamViewInput!
    var interactor: CreateIceCreamInteractorInput!
    var weightMapper: AnyBidirectionalMapper<Double?, String?>!
    var temperatureMapper: AnyBidirectionalMapper<Double?, String?>!
    
    private var iceCream: IceCream = .empty
    
}

extension CreateIceCreamPresenter: CreateIceCreamViewOutput {
    
    func viewIsReady() {
        view.set(.name(iceCream.name))
        let weight = weightMapper.map(iceCream.weight)
        view.set(.weight(weight))
        view.set(.color(iceCream.color))
        view.set(.flavor(iceCream.flavor))
        let temp = temperatureMapper.map(iceCream.temp)
        view.set(.temp(temp))
    }
    
    func didUpdate(_ field: CreateIceCreamViewField) {
        switch field {
        case .name(let name):
            iceCream.name = name ?? ""
        case .weight(let weight):
            iceCream.weight = weightMapper.reverseMap(weight)
        case .color(let color):
            iceCream.color = color
        case .flavor(let flavor):
            iceCream.flavor = flavor
        case .temp(let temp):
            iceCream.temp = temperatureMapper.reverseMap(temp)
        }
    }
    
    func didTapCreate() {
        interactor.createIceCream(
            iceCream,
            success: { [unowned self, iceCream] in
                self.output?.didCreateIceCream(iceCream)
            },
            failure: { [unowned self] _ in
                self.output?.didFailToCreateIceCream()
            }
        )
    }
    
}
