//
//  RouteModel.swift
//  Spider
//
//  Created by admin on 2019/8/8.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

class RouteModel {
    var originUrl: String?
    var host: String?
    var route: String?
    var scheme: String?
    var params: [String : String]?
}

class ModuleModel {
    var route: String?
    var selector: Selector?
    var moduleName: String?
    
    init(route: String , selector: Selector) {
        self.route = route
        self.selector = selector
    }
}
