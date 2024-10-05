//
//  SearchViewModelTests.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 05/10/2024.
//


import XCTest
import RxSwift
import RxCocoa
@testable import RecipeSearchSwift

class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    var mockRecipeService: MockRecipeService!
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        mockRecipeService = MockRecipeService()
        viewModel = SearchViewModel()
        viewModel.recipeService = mockRecipeService
    }

    func testGetRecipes() {
        let expectation = self.expectation(description: "Recipes loaded")
        viewModel.recipes.asObservable().subscribe(onNext: { recipes in
            if !recipes.isEmpty {
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        viewModel.getRecipes(query: "test")
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLoadMoreRecipes() {
        let expectation = self.expectation(description: "More recipes loaded")
        viewModel.nextPageURLString = "nextURL"
        viewModel.recipes.asObservable().subscribe(onNext: { recipes in
            if recipes.count > 5 {
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        viewModel.loadMoreRecipes()
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockRecipeService: RecipeService {
    override func getRecipes(query: String, completion: ((RecipeResponse?, (any Error)?) -> Void)?) {
        completion?(RecipeResponse(hits: [Hit(recipe: Recipe(label: "Text", image: "", calories: 8.0, totalNutrients: nil))], links: nil), nil)
    }
    
    override func getNextRecipies(nextPage: String, completion: ((RecipeResponse?, (any Error)?) -> Void)?) {
        let hit = Hit(recipe: Recipe(label: "Text", image: "", calories: 8.0, totalNutrients: nil))
        completion?(RecipeResponse(hits: [hit,hit,hit,hit,hit,hit,hit,hit], links: nil), nil)
    }

}
