//
//  CreateIceCreamPresenterInterface.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 08.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import Foundation

protocol CreateIceCreamPresenterOutput: class {
    
    func didCreateIceCream(_ iceCream: IceCream)
    func didFailToCreateIceCream()
    
}
