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
    
    
    var path: String {
        switch self {
        case .getRecipes:
            return "/api/recipes/v2"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRecipes:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRecipes(let query):
            var parameters = getBaseParameters()
            parameters["q"] = query
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
