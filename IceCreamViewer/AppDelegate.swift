//
//  AppDelegate.swift
//  IceCreamViewer
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
        
        
        let snapshotValueMapper = AnyMapper { (snapshot: DataSnapshot) -> [String:Any] in
            return (snapshot.value as? [String:Any]) ?? [:]
        }
        let iceCreamMapper = FirebaseObjectToIceCreamMapper()
        
        let board = UIStoryboard(name: "IceCreamListViewController", bundle: .main)
        let navView = board.instantiateInitialViewController() as! UINavigationController
        let view = navView.topViewController as! IceCreamListViewController
        let presenter = IceCreamListPresenter()
        let interactor = IceCreamListInteractor(
            iceCreamRepository: FirebaseReadableRepository(
                route: iceCreamDatabaseRef,
                dataFetchStrategy: ObserveValueFirebaseDataFetchStrategy(),
                entityMapper: snapshotValueMapper.chain(iceCreamMapper),
                entityCollectionMapper: AnyMapper(FirebaseCollectionMapper(entityMapper: iceCreamMapper))
            )
        )
        
        let assembly = IceCreamListModuleAssembler(
            view: view,
            presenter: presenter,
            interactor: interactor
        )
        _ = assembly.assembly()
        
        window?.rootViewController = navView
        window?.makeKeyAndVisible()
        
        return true
    }

}

