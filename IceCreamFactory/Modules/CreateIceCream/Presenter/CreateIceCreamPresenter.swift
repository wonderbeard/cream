//
//  CreateIceCreamPresenter.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

class CreateIceCreamPresenter: CreateIceCreamModuleInput {
    
    weak var output: CreateIceCreamPresenterOutput?
    var view: CreateIceCreamViewInput!
    var interactor: CreateIceCreamInteractorInput!
    var weightMapper: AnyBidirectionalMapper<Double?, String?>!
    
    private var iceCream: IceCream = .empty
    
}

extension CreateIceCreamPresenter: CreateIceCreamViewOutput {
    
    func viewIsReady() {
        view.set(.name(iceCream.name))
        let weight = weightMapper.map(iceCream.weight)
        view.set(.weight(weight))
        view.set(.color(iceCream.color))
        view.set(.flavor(iceCream.flavor))
        view.set(.temp(iceCream.temp))
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
            iceCream.temp = temp
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
