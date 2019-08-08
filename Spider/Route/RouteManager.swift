//
//  RouteManager.swift
//  Spider
//
//  Created by admin on 2019/8/8.
//  Copyright © 2019 ChengYing. All rights reserved.
//

import Foundation

class RouteManager {
    
    static let shared = RouteManager()
    
    private var serviceMap = [String: ModuleModel]()
    private var moduleMap = [String: AnyObject]()

    public func callRoute(routeStr: String) -> Bool {
        if let _ = serviceMap[routeStr] {
            return true
        }
        return false
    }

    @discardableResult
    public func route(routeStr: String, extraArgs: [String: String]?) -> Bool {
        
        let model = analysisToModel(url: routeStr)
        
        var params = [String: String]()
        for item in extraArgs ?? [:] {
            params[item.key] = item.value
        }
        for item in model.params ?? [:] {
            params[item.key] = item.value
        }
        return callServiceWithRoute(routeStr: model.route!, parameter: params)
    }
    
    public func callServiceWithRoute(routeStr: String, parameter: [String : String]?) -> Bool {
        
        guard let serviceInfo = serviceMap[routeStr],
            let moduleName = serviceInfo.moduleName,
            let selector = serviceInfo.selector,
            let module = moduleMap[moduleName],
            module.responds(to: selector) else {
                return false
        }
        
        if(parameter == nil) {
            let _ = module.perform(selector);
        }else {
            let _ = module.perform(selector, with: parameter)
        }
        return true;
    }
}

extension RouteManager {
    
    public func registerModule(module: RouteBaseModule) {
        
        let moduleName = module.moduleName()
        if(moduleMap[moduleName] == nil) {
            moduleMap[moduleName] = module
        }
        
        for serviceModel in module.services() ?? [] {
            serviceModel.moduleName = moduleName
            serviceMap[serviceModel.route!] = serviceModel
        }
    }
}

extension RouteManager {
    
   private func analysisToModel(url: String) -> RouteModel {
        let model = RouteModel()
        model.originUrl = url
        model.host = RouteManager.fetchHost(url)
        model.scheme = RouteManager.fetchScheme(url)
        model.params = RouteManager.fetchParams(url)
        model.route = url.components(separatedBy: "?")[0]
        return model
    }
}

extension RouteManager {

    private func performModuleMethod(methodName: String, moduleClassString: String) -> Any? {
        
        guard let moduleClass: AnyClass = NSClassFromString(moduleClassString) else {
            return nil
        }
        let module: AnyObject = moduleClass.alloc()
        let selector: Selector  = NSSelectorFromString(methodName)
        if module.responds(to: selector) {
            return module.perform(selector)
        }
        return nil
    }
}

//MARK: Hander URL
extension RouteManager {
    
    static func urlComponents (_ url: String) -> URLComponents? {
        guard let url = urlEncoded(url),
            let components = URLComponents(string: url) else {
            return nil
        }
        return components
    }
    
    static func fetchParams(_ url: String) -> [String : String]? {
        var params = [String: String]()
        guard let components = urlComponents(url),
              let queryItems = components.queryItems  else {
            return nil
        }
        for item in queryItems {
            params[item.name] = item.value
        }
        return params
    }
    
    static func fetchScheme(_ url: String) -> String? {
        guard let components = urlComponents(url),
            let scheme = components.scheme  else {
                return nil
        }
        return scheme
    }
    
    static func fetchHost(_ url: String) -> String? {
        guard let components = urlComponents(url),
            let host = components.host  else {
                return nil
        }
        return host
    }
    
    static func urlEncoded(_ url: String) -> String? {
        let encodeUrlString = url.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString
    }
    
}



