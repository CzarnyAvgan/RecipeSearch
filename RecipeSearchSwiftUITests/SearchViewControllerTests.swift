//
//  SearchViewControllerTests.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 05/10/2024.
//


import XCTest
import RxCocoa
import RxSwift
@testable import RecipeSearchSwift

class SearchViewControllerTests: XCTestCase {
    var searchViewController: SearchViewController!
    
    override func setUp() {
        super.setUp()
        loadFont(name: "Poppins-Regular", extensionFont: "ttf")
        loadFont(name: "Poppins-Bold", extensionFont: "ttf")
        loadFont(name: "Poppins-SemiBold", extensionFont: "ttf")
        searchViewController = SearchViewController()
        searchViewController.viewModel = SearchViewModel()
        searchViewController.loadViewIfNeeded()
    }
    
    func loadFont(name: String, extensionFont: String) {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: name, withExtension: extensionFont) else {
            fatalError("Failed to locate font file in bundle.")
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
        if let error = error {
            print("Failed to load font: \(error.takeUnretainedValue())")
        }
    }

    func testInitialState() {
        XCTAssertFalse(searchViewController.searchSectionView.isHidden)
        XCTAssertTrue(searchViewController.searchResultsSectionView.isHidden)
        XCTAssertTrue(searchViewController.resultTableView.isHidden)
        XCTAssertTrue(searchViewController.loadingView.isHidden)
    }

    func testSearchState() {
        searchViewController.viewModel.changeSearchState(to: .search)
        XCTAssertFalse(searchViewController.searchSectionView.isHidden)
        XCTAssertTrue(searchViewController.searchResultsSectionView.isHidden)
        XCTAssertTrue(searchViewController.resultTableView.isHidden)
    }

    func testResultsState() {
        searchViewController.viewModel.changeSearchState(to: .results(title: "Test"))
        XCTAssertTrue(searchViewController.searchSectionView.isHidden)
        XCTAssertFalse(searchViewController.searchResultsSectionView.isHidden)
        XCTAssertFalse(searchViewController.resultTableView.isHidden)
    }

    func testLoadingState() {
        searchViewController.viewModel.state.accept(.loading)
        XCTAssertFalse(searchViewController.loadingView.isHidden)
    }

    func testLoadedState() {
        searchViewController.viewModel.state.accept(.idle)
        XCTAssertTrue(searchViewController.loadingView.isHidden)
    }
    
    
}
