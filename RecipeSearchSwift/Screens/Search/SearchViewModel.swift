//
//  SearchViewModel.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchState {
    case search
    case results(title: String)
    case empty
}

class SearchViewModel: BaseViewModel {
    var recipeService: RecipeService = .shared
    let recipes = BehaviorRelay<[Hit]>(value: [])
    let searchState = BehaviorRelay<SearchState>(value: .search)
    var nextPageURLString: String?
    
    func getRecipes(query: String) {
        state.accept(.loading)
        recipeService.getRecipes(query: query) { [weak self] response, error in
            guard let self else { return }
            if let response {
                state.accept(.idle)
                if (response.hits ?? []).isEmpty {
                    changeSearchState(to: .empty)
                    return
                }
                recipes.accept(response.hits ?? [])
                changeSearchState(to: .results(title: query))
                nextPageURLString = response.links?.next?.href
            } else if let error {
                state.accept(.error(error.localizedDescription))
            }
        }
    }
    
    func loadMoreRecipes() {
        guard let nextPageURLString else { return }
        recipeService.getNextRecipies(nextPage: nextPageURLString) { [weak self] response, error in
            guard let self else { return }
            if let response {
                state.accept(.idle)
                if (response.hits ?? []).isEmpty {
                    return
                }
                self.recipes.accept(self.recipes.value + (response.hits ?? []))
                self.nextPageURLString = response.links?.next?.href
            } else if let error {
                state.accept(.error(error.localizedDescription))
            }
        }
    }
    
    func changeSearchState(to state: SearchState) {
        searchState.accept(state)
    }
    
    func goToEmptyStateView() {
        AppNavigator.shared.navigate(to: MainRoutes.empty, with: .push)
        searchState.accept(.search)
    }
}
