//
//  CreateIceCreamViewInterface.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

enum CreateIceCreamViewField {
    case name(String?)
    case weight(String?)
    case color(String?)
    case flavor(String?)
    case temp(String?)
}

protocol CreateIceCreamViewInput {
    func set(_ field: CreateIceCreamViewField)
}

protocol CreateIceCreamViewOutput: class {
    func viewIsReady()
    func didUpdate(_ field: CreateIceCreamViewField)
    func didTapCreate()
}
