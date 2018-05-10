//
//  ModuleAssembly.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit

protocol ModuleAssembly {
    
    associatedtype Module
    
    func assemble() -> (Module, UIViewController)
    
}
