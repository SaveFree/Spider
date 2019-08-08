//
//  ViewController.swift
//  Spider
//
//  Created by admin on 2019/8/7.
//  Copyright © 2019 ChengYing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        RouteManager.shared.registerModule(module: XXRouteXXXModule())
        RouteManager.shared.route(routeStr: "xxx://xxxx", extraArgs: nil)
    }


}

