//
//  AppDelegate.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 07.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
}

extension AppDelegate: UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool
    {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        let iceCreamDatabaseRef = Database.database().reference(withPath: "iceCream")
        iceCreamDatabaseRef.keepSynced(true)
        
        let board = UIStoryboard(name: "CreateIceCreamViewController", bundle: .main)
        let navView = board.instantiateInitialViewController() as! UINavigationController
        let view = navView.topViewController as! CreateIceCreamViewController
        
        let presenter = CreateIceCreamPresenter()
        let interactor = CreateIceCreamInteractor(
            iceCreamRepository: FirebaseWritableRepository(
                route: iceCreamDatabaseRef,
                entityMapper: AnyMapper(IceCreamToFirebaseObjectMapper())
            )
        )

        CreateIceCreamAssembler(
            view: view,
            interactor: interactor,
            presenter: presenter
        ).assembly()
        
        window?.rootViewController = navView
        window?.makeKeyAndVisible()
        return true
    }

}

