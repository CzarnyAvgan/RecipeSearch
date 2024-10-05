//
//  BaseViewController.swift
//  RecipeSearchSwift
//
//  Created by Kacper Wysocki on 04/10/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BaseViewController<T: BaseViewModel>: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: T!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        configureNavigationBarBackButton()
    }
    
    func setupViews() {
        view.setGradientBackground(colorOne: .superLightOrange, colorTwo: .appWhite)
    }
    
    func setupConstraints() {}
    
    func bindToViewModel() {}
    
    func configureNavigationBarBackButton(buttonColor: UIColor? = .appBlack, image: UIImage = .backButton) {
        let item = UIBarButtonItem(image: image.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(backButtonAction))
        item.tintColor = buttonColor
        item.imageInsets = UIEdgeInsets(top: .pt(4), left: 0, bottom: 0, right: 0)
        navigationItem.setLeftBarButton(item, animated: true)
    }
    
    func removeCustomBackButton() {
        let item = UIBarButtonItem()
        navigationItem.setLeftBarButton(item, animated: false)
    }
    
    @objc func backButtonAction() {
        AppNavigator.shared.pop()
    }
}
