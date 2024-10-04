//
//  EmptyResultsViewController.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 05/10/2024.
//

import UIKit
import Localize_Swift

class EmptyResultsViewController: BaseViewController<BaseViewModel> {
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let subtitleLabel: UILabel = UILabel()
    private let tryAgainButton: UIButton = UIButton()
    
    private let buttonHeight: CGFloat = .pt(44)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func setupViews() {
        super.setupViews()
        
        imageView.image = .empty
        
        titleLabel.text = "empty_title".localized()
        titleLabel.font = .poppinsSemiBold(size: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        subtitleLabel.text = "empty_subtitle".localized()
        subtitleLabel.font = .poppinsRegular(size: 14)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        tryAgainButton.addTarget(self, action: #selector (tryAgainButtonTapped), for: .touchUpInside)
        tryAgainButton.setTitle("try_again".localized(), for: .normal)
        tryAgainButton.backgroundColor = .appBlack
        tryAgainButton.titleLabel?.font = .poppinsSemiBold(size: 14)
        tryAgainButton.layer.cornerRadius = buttonHeight / 2
        
        [imageView, titleLabel, subtitleLabel, tryAgainButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .pt(16)),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .pt(24)),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.pt(24)),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .pt(16)),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            tryAgainButton.topAnchor.constraint(greaterThanOrEqualTo: subtitleLabel.bottomAnchor, constant: .pt(16)),
            tryAgainButton.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            tryAgainButton.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            tryAgainButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func tryAgainButtonTapped() {
        AppNavigator.shared.pop()
    }
}
