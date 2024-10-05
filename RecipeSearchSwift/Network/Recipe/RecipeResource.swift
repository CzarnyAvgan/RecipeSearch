//
//  RecipeResource.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import Foundation
import Moya

enum RecipeResource: TargetType {
    case getRecipes(query: String)
    case nextPage(nextPage: String)
    
    var baseURL: URL {
        switch self {
        case .getRecipes:
            return self.apiURL
        case .nextPage(let nextPage):
            return URL(string: nextPage)!
        }
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            return "/api/recipes/v2"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRecipes, .nextPage:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRecipes(let query):
            var parameters = getBaseParameters()
            parameters["q"] = query
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .nextPage:
            return .requestPlain
        }
    }
}
