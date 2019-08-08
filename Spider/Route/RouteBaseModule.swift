//
//  RouteBaseModule.swift
//  Spider
//
//  Created by admin on 2019/8/8.
//  Copyright © 2019 ChengYing. All rights reserved.
//

import Foundation

typealias RouteModuleCallback = ([String: String]) -> ()

class RouteBaseModule {
    
    public func moduleName() -> String {
        return "base"
    }
    
    public func services() -> [ModuleModel]? {
        return nil
    }
    
    public func handlerUrl(args: [String: String],  callback: @escaping RouteModuleCallback) {
        callback(args)
    }
}
