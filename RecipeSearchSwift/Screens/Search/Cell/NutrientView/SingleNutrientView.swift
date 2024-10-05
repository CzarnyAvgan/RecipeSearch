//
//  SingleNutrientView.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 05/10/2024.
//

import Foundation
import UIKit

enum NutrientType: String, Codable {
    case protein
    case fat
    case carbohydrate
}

class SingleNutrientView: UIView {
    private let titleLabel: UILabel = UILabel()
    private let valueLabel: UILabel = UILabel()
    private let contentView: UIView = UIView()
    private let colorView: UIView = UIView()
    
    private let contentViewHeight: CGFloat = .pt(26)
    private let colorViewHeight: CGFloat = .pt(12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .beige
        contentView.layer.cornerRadius = contentViewHeight / 2
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .poppinsRegular(size: 12)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = .poppinsBold(size: 12)
        
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.layer.cornerRadius = colorViewHeight / 2
        
        contentView.addSubview(colorView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        self.addSubview(contentView)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: contentViewHeight),
            
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .pt(7)),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .pt(8)),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.pt(7)),
            colorView.heightAnchor.constraint(equalToConstant: colorViewHeight),
            colorView.widthAnchor.constraint(equalTo: colorView.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: .pt(4)),
            titleLabel.centerYAnchor.constraint(equalTo: colorView.centerYAnchor),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: .pt(4)),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -.pt(4)),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: .pt(4)),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.pt(12)),
        ])
    }
    
    func setupView(nutrient: Nutrient, type: NutrientType) {
        switch type {
        case .protein:
            colorView.backgroundColor = .superLightGreen
        case .fat:
            colorView.backgroundColor = .lightOrange
        case .carbohydrate:
            colorView.backgroundColor = .lightRed
        }
        
        titleLabel.text = nutrient.label
        let valueText = String(Int(nutrient.quantity ?? 0.0)) + (nutrient.unit ?? "g")
        valueLabel.text = valueText
    }
}
