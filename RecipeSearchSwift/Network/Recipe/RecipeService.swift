//
//  SurveyService.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//


//
//  SurveyService.swift
//  4F
//
//  Created by Adam Majczyk on 17/07/2024.
//

import Foundation
import Moya

class RecipeService: MoyaProvider<RecipeResource> {
    static let shared = RecipeService()
    let provider = MoyaProvider<RecipeResource>()
    
    func getRecipes(query: String, completion: ((RecipeResponse?, Error?) -> Void)?) {
        request(.getRecipes(query: query)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedValue = try response.map(RecipeResponse.self)
                    completion?(decodedValue, nil)
                } catch {
                    completion?(nil, error)
                }
            case .failure(let error):
                completion?(nil, error)
                
            }
        }
    }
    
    func getNextRecipies(nextPage: String, completion: ((RecipeResponse?, Error?) -> Void)?) {
        request(.nextPage(nextPage: nextPage)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedValue = try response.map(RecipeResponse.self)
                    completion?(decodedValue, nil)
                } catch {
                    completion?(nil, error)
                }
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
}
