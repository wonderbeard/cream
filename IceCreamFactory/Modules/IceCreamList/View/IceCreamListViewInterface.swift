//
//  IceCreamListViewInterface.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

struct IceCreamListItemViewModel {
    var name: String?
    var flavor: String?
    var temp: String?
    var color: String?
}

protocol IceCreamListViewInput {
    func setListItems(_ items: [IceCreamListItemViewModel])
    func setErrorMessage(_ error: String?)
}

protocol IceCreamListViewOutput: class {
    func viewIsReady()
}
