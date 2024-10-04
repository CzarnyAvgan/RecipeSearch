//
//  SearchSection.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import Foundation
import UIKit
import Localize_Swift

protocol SearchSectionViewDelegate: AnyObject {
    func textFieldDidEndEditing(_ textField: UITextField)
}

class SearchSectionView: UIView {
    
    private let titleLabel: UILabel = UILabel()
    private let searchTextField: SearchTextField = SearchTextField()
    private let searchTextFieldHeight: CGFloat = .pt(54)
    
    weak var delegate: SearchSectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        titleLabel.font = .poppinsSemiBold(size: 24)
        titleLabel.text = "search_section_title".localized()
        
        searchTextField.backgroundColor = .appWhite
        searchTextField.layer.cornerRadius = .pt(8)
        searchTextField.placeholder = "search_section_textfield_placeholder".localized()
        searchTextField.delegate = self
        
        [titleLabel, searchTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            searchTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .pt(16)),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: searchTextFieldHeight),
            
        ])
    }
    
    func clearTextField() {
        searchTextField.text = nil
    }
}

extension SearchSectionView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
