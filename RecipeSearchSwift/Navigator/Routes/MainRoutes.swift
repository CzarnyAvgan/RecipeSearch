//
//  MainRoutes.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//



import Foundation
import UIKit

enum MainRoutes: Route {
    case splash
    case search
    case empty
    
    var screen: UIViewController {
        switch self {
        case .splash:
            return buildSplashViewController()
        case .search:
            return buildSearchViewController()
        case .empty:
            return buildEmptyViewController()
        }
    }
    
    private func buildSplashViewController() -> UIViewController {
        let controller = SplashViewController()
        return controller
    }
        
    private func buildSearchViewController() -> UIViewController {
        let controller = SearchViewController()
        let vm = SearchViewModel()
        controller.viewModel = vm
        return controller
    }
    
    private func buildEmptyViewController() -> UIViewController {
        let controller = EmptyResultsViewController()
        let vm = BaseViewModel()
        controller.viewModel = vm
        return controller
    }
}
