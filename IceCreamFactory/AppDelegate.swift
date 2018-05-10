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
        
//        let board = UIStoryboard(name: "CreateIceCreamViewController", bundle: .main)
//        let view = board.instantiateInitialViewController() as! CreateIceCreamViewController
//        let presenter = CreateIceCreamPresenter()
//        let interactor = CreateIceCreamInteractor(
//            iceCreamRepository: FirebaseWritableRepository(
//                route: iceCreamDatabaseRef,
//                entityMapper: AnyMapper(FirebaseIceCreamMapper())
//            )
//        )
//
//        let assembly = CreateIceCreamAssembly(
//            view: view,
//            interactor: interactor,
//            presenter: presenter
//        )
//        let (_, moduleView) = assembly.assemble()
        
        let snapshotValueMapper = AnyMapper{ (snapshot: DataSnapshot) in (snapshot.value as? [String:Any]) ?? [:] }
        let iceCreamMapper = AnyMapper(FirebaseObjectToIceCreamMapper())
        
        let board = UIStoryboard(name: "IceCreamListViewController", bundle: .main)
        let view = board.instantiateInitialViewController() as! IceCreamListViewController
        let presenter = IceCreamListPresenter()
        let interactor = IceCreamListInteractor(
            iceCreamRepository: FirebaseReadableRepository(
                route: iceCreamDatabaseRef,
                dataFetchStrategy: ObserveValueFirebaseDataFetchStrategy(),
                entityMapper: AnyMapper(TransitMapper(snapshotValueMapper, iceCreamMapper)),
                entityCollectionMapper: AnyMapper(FirebaseCollectionMapper(entityMapper: iceCreamMapper))
            )
        )
        
        let assembly = IceCreamListModuleAssembly(
            view: view,
            presenter: presenter,
            interactor: interactor
        )
        let (_, moduleView) = assembly.assemble()
        
        window?.rootViewController = moduleView
        window?.makeKeyAndVisible()
        return true
    }

}

