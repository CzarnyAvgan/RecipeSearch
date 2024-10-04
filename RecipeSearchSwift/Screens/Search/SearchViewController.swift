//
//  SearchViewController.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import UIKit

class SearchViewController: BaseViewController<SearchViewModel> {
    let mainStackView: UIStackView = UIStackView()
    let searchSectionView: SearchSectionView = SearchSectionView()
    let searchResultsSectionView: SearchResultTopView = SearchResultTopView()
    let loadingView: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    override func setupViews() {
        super.setupViews()
        
        mainStackView.axis = .vertical
        mainStackView.addArrangedSubview(searchSectionView)
        mainStackView.addArrangedSubview(searchResultsSectionView)
        mainStackView.spacing = .pt(24)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        searchSectionView.delegate = self
        searchSectionView.isHidden = true
        
        searchResultsSectionView.delegate = self
        searchResultsSectionView.isHidden = true
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.color = .appBlack
        
        view.addSubview(mainStackView)
        view.addSubview(loadingView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .pt(24)),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .pt(24)),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.pt(24)),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    override func bindToViewModel() {
        viewModel.recipes.subscribe { recipies in
            
        }.disposed(by: disposeBag)
        
        viewModel.searchState.subscribe {[weak self] state in
            guard let self else { return }
            switch state {
            case .search:
                searchSectionView.isHidden = false
                searchResultsSectionView.isHidden = true
            case .results(let title):
                searchSectionView.isHidden = true
                searchResultsSectionView.isHidden = false
                searchResultsSectionView.titleText = title
            case .empty:
                searchSectionView.clearTextField()
                viewModel.goToEmptyStateView()
            }
        }.disposed(by: disposeBag)
        
        viewModel.state.subscribe {[weak self] state in
            guard let self else { return }
            if state == .loading {
                loadingView.startAnimating()
                loadingView.isHidden = false
            } else {
                loadingView.stopAnimating()
                loadingView.isHidden = true
            }
        }.disposed(by: disposeBag)
    }
}

extension SearchViewController: SearchSectionViewDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let query = textField.text {
            viewModel.getRecipes(query: query)
        }
    }
}

extension SearchViewController: SearchResultTopViewDelegate {
    func clearButtonTapped() {
        searchSectionView.clearTextField()
        viewModel.changeSearchState(to: .search)
    }
}
