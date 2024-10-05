//
//  RecipeTableViewCell.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 05/10/2024.
//

import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {
    private let mainContentView: UIView = UIView()
    private let mainImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let mainNutrientStackView: UIStackView = UIStackView()
    private let topNutrientStackView: UIStackView = UIStackView()
    private let bottomNutrientStackView: UIStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        mainContentView.translatesAutoresizingMaskIntoConstraints = false
        mainContentView.backgroundColor = .appWhite
        mainContentView.layer.cornerRadius = .pt(8)
        
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.layer.cornerRadius = .pt(4)
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFill
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .poppinsSemiBold(size: 16)
        titleLabel.numberOfLines = 2
        
        mainNutrientStackView.translatesAutoresizingMaskIntoConstraints = false
        mainNutrientStackView.axis = .vertical
        mainNutrientStackView.spacing = .pt(4)
        
        topNutrientStackView.axis = .horizontal
        topNutrientStackView.spacing = .pt(4)
        topNutrientStackView.distribution = .fillEqually
        
        bottomNutrientStackView.axis = .horizontal
        bottomNutrientStackView.spacing = .pt(4)
        bottomNutrientStackView.distribution = .fillEqually
        
        mainNutrientStackView.addArrangedSubview(topNutrientStackView)
        mainNutrientStackView.addArrangedSubview(bottomNutrientStackView)
    
        contentView.addSubview(mainContentView)
        mainContentView.addSubview(mainImageView)
        mainContentView.addSubview(titleLabel)
        mainContentView.addSubview(mainNutrientStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .pt(24)),
            mainContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.pt(24)),
            mainContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.pt(8)),
            
            mainImageView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: .pt(16)),
            mainImageView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: .pt(16)),
            mainImageView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -.pt(16)),
            mainImageView.widthAnchor.constraint(equalToConstant: .pt(100)),
            mainImageView.heightAnchor.constraint(equalToConstant: .pt(130)),
            
            titleLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: .pt(16)),
            titleLabel.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -.pt(16)),
            
            mainNutrientStackView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            mainNutrientStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            mainNutrientStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            mainNutrientStackView.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: .pt(16))
        ])
    }
    
    func setupCell(_ recipe: Recipe?) {
        guard let recipe else { return }
        if let url = URL(string: recipe.image ?? "") {
            mainImageView.kf.setImage(with: url)
        }
        
        titleLabel.text = recipe.label
        setupNutrient(recipe.totalNutrients)
    }
    
    func setupNutrient(_ nutrition: TotalNutrient?) {
        topNutrientStackView.removeAllArrangedSubviews()
        bottomNutrientStackView.removeAllArrangedSubviews()
        
        let proteinView = SingleNutrientView()
        let fatView = SingleNutrientView()
        let carbohydrateView = SingleNutrientView()
        
        if let protein = nutrition?.protein {
            proteinView.setupView(nutrient: protein, type: .protein)
            topNutrientStackView.addArrangedSubview(proteinView)
        }
        
        if let fat = nutrition?.fat {
            fatView.setupView(nutrient: fat, type: .fat)
            topNutrientStackView.addArrangedSubview(fatView)
        }
        
        if let carbohydrate = nutrition?.carb {
            carbohydrateView.setupView(nutrient: carbohydrate, type: .carbohydrate)
            bottomNutrientStackView.addArrangedSubview(carbohydrateView)
        }
        
        
    }
}
