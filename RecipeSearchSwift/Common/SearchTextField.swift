//
//  SearchTextField.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import Foundation
import UIKit

class SearchTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let padding: CGFloat = 16
        
        let searchIcon: UIImage = .loupeIcon
        let searchImageView = UIImageView(image: searchIcon)
        searchImageView.contentMode = .scaleAspectFit
        let searchView = UIView(frame: CGRect(x: 0, y: 0, width: 16 + padding + 8, height: 16))
        searchImageView.frame = CGRect(x: padding, y: 0, width: 16, height: 16)
        searchView.addSubview(searchImageView)
        leftView = searchView
        leftViewMode = .always

        let clearIcon: UIImage = .removeIcon
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(clearIcon, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        let clearButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 30 + padding, height: 30))
        clearButtonView.addSubview(clearButton)
        rightView = clearButtonView
        rightViewMode = .whileEditing
    }

    @objc private func clearText() {
        self.text = ""
    }
}
