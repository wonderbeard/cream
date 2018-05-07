//
//  AppDelegate.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder {
    
}

extension AppDelegate: UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool
    {
        FirebaseApp.configure()
        return true
    }

}

