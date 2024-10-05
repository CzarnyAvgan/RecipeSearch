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
    let resultTableView: UITableView = UITableView()
    
    let loadingView: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func setupViews() {
        super.setupViews()
        setupTableView()
        
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
        
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        view.addSubview(resultTableView)
        view.addSubview(loadingView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .pt(24)),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .pt(24)),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.pt(24)),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            resultTableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            resultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            resultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            resultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    override func bindToViewModel() {
        viewModel.recipes.subscribe { [weak self] _ in
            guard let self else { return }
            self.resultTableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.searchState.subscribe {[weak self] state in
            guard let self else { return }
            switch state {
            case .search:
                searchSectionView.isHidden = false
                searchResultsSectionView.isHidden = true
                resultTableView.isHidden = true
            case .results(let title):
                searchSectionView.isHidden = true
                searchResultsSectionView.isHidden = false
                searchResultsSectionView.titleText = title
                resultTableView.isHidden = false
                if !viewModel.recipes.value.isEmpty {
                    resultTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
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
    
    func setupTableView() {
        resultTableView.bounces = false
        resultTableView.separatorStyle = .none
        resultTableView.showsVerticalScrollIndicator = false
        resultTableView.register(
            RecipeTableViewCell.self,
            forCellReuseIdentifier: String(describing: RecipeTableViewCell.self))
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.backgroundColor = .clear
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.recipes.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeTableViewCell.self)) as? RecipeTableViewCell else { return UITableViewCell() }
        let hit = viewModel.recipes.value[indexPath.row]
        cell.setupCell(hit.recipe)
        
        if indexPath.row >= viewModel.recipes.value.count - 5 {
            viewModel.loadMoreRecipes()
        }
        return cell
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
