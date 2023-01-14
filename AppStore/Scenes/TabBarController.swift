//
//  TabBarController.swift
//  AppStore
//
//  Created by 정상훈 on 2023/01/14.
//

import UIKit

class TabBarController: UITabBarController {
    
    // 익명함수? 형태로 초기화, 게터같은 컴포지션 value로는 lazy 값이 초기화가 안됨
    private lazy var todayViewController: UIViewController = {
        let viewController = TodayViewController()
        let tabBarItem = UITabBarItem(
            title: "today",
            image: UIImage(systemName: "mail"),
            tag: 0
        )
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    private lazy var appViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(
            title: "앱",
            image: UIImage(systemName: "square.stack.3d.up"),
            tag: 1
        )
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // uitabbar controller 내부 요소
        viewControllers = [todayViewController, appViewController]
    }
    
}

