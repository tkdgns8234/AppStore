//
//  AppViewController.swift
//  AppStore
//
//  Created by 정상훈 on 2023/01/14.
//

import SnapKit
import UIKit

final class AppViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
    }
}

private extension AppViewController {
    func setupNavigationController() {
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true // 무슨일이 있어도 larege 타이틀만
    }
}
