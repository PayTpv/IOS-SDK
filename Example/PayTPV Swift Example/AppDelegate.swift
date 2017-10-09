//
//  AppDelegate.swift
//  PAYTPV Swift Example
//
//  Created by Mihail Cristian Dumitru on 8/14/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

import UIKit
import PAYTPV

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // TODO: - Replace with your test credentials
        PTPVAPIClient.shared().configuration = PTPVConfiguration(merchantCode: "",
                                                                 terminal: "",
                                                                 password: "",
                                                                 jetId: "")


        let root = ProductsTableViewController()
        let navigationController = UINavigationController(rootViewController: root)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}
