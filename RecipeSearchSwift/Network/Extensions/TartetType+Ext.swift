//
//  TartetType+Ext.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import Foundation
import Moya

enum HTTPHeader: String {
    case language = "Accept-Language"
    case accept = "Accept"
}

enum BaseParameter: String {
    case query = "q"
    case apiType = "type"
    case appId = "app_id"
    case appKey = "app_key"
}

extension TargetType {
    var apiURL: URL {
        let baseApiString = (Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String) ?? ""
        return URL(string: baseApiString)!
    }
    
    var baseURL: URL {
        let baseApiString = (Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String) ?? ""
        return URL(string: baseApiString)!
    }
    
    var headers: [String: String]? {
        return getHeaders()
    }
}

extension TargetType {
    public func getHeaders() -> [String:String] {
        return [
            HTTPHeader.accept.rawValue: "application/json",
            HTTPHeader.language.rawValue: "en",
        ]
    }
    
    public func getBaseParameters() -> [String:String] {
        var parameters: [String:String] = [BaseParameter.apiType.rawValue: "public"]
        
        if let appId = Bundle.main.object(forInfoDictionaryKey: "APP_ID") as? String {
            parameters[BaseParameter.appId.rawValue] = appId
        }
        
        if let appKey = Bundle.main.object(forInfoDictionaryKey: "APP_KEY") as? String {
            parameters[BaseParameter.appKey.rawValue] = appKey
        }
        
        return parameters
    }
}

