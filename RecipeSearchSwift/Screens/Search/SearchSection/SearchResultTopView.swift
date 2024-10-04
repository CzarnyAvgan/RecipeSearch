//
//  SearchResultTopView.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import Foundation
import UIKit

protocol SearchResultTopViewDelegate: AnyObject {
    func clearButtonTapped()
}

class SearchResultTopView: UIView {
    private let titleLabel: UILabel = UILabel()
    private let clearButton: UIButton = UIButton()
    
    weak var delegate: SearchResultTopViewDelegate?
    
    var titleText: String = "" {
        didSet {
            titleLabel.text = "\"\(titleText)\""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        titleLabel.font = .poppinsSemiBold(size: 32)
        
        setupButton()
        
        [titleLabel, clearButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            clearButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .pt(8)),
            clearButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            clearButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -.pt(16)),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    private func setupButton() {
        let attributesForBoldText: [NSAttributedString.Key: Any] = [
            .font: UIFont.poppinsBold(size: 14),
            .foregroundColor: UIColor.appBlack
        ]
        let boldText = NSAttributedString(string: "[X] ", attributes: attributesForBoldText)

        let attributesForRegularText: [NSAttributedString.Key: Any] = [
            .font: UIFont.poppinsRegular(size: 14),
            .foregroundColor: UIColor.appBlack
        ]
        let regularText = NSAttributedString(string: "results", attributes: attributesForRegularText)

        let combinedText = NSMutableAttributedString()
        combinedText.append(boldText)
        combinedText.append(regularText)

        clearButton.setAttributedTitle(combinedText, for: .normal)
        clearButton.addTarget(self, action: #selector (clearButtonTapped), for: .touchUpInside)
    }
    
    @objc private func clearButtonTapped() {
        delegate?.clearButtonTapped()
    }
}
