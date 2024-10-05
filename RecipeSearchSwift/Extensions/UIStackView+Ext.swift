//
//  UIStackView+Ext.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 05/10/2024.
//


import Foundation
import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}