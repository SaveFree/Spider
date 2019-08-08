//
//  XXRouteXXXModule.swift
//  Spider
//
//  Created by admin on 2019/8/8.
//  Copyright © 2019 ChengYing. All rights reserved.
//

import UIKit

class XXRouteXXXModule: RouteBaseModule {

    override func moduleName() -> String {
        return "xxx"
    }
    
    override func services() -> [ModuleModel]? {
        var list = [ModuleModel]()
        list.append(ModuleModel(route: "xxx://xxxx", selector: #selector(gotoXXX(params:))))
        return list
    }

    @objc func gotoXXX(params: [String: String]) {
        self.handlerUrl(args: params, callback: {
            (params) in
             //
            print("XXXXXX")
        })
    }
    
}
