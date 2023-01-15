//
//  AppViewController.swift
//  AppStore
//
//  Created by 정상훈 on 2023/01/14.
//

/**
ui scroll view에 ui stack view 사용 시 장점
ui stack view -> 내부 요소의 크기에따라 크기가 달라짐 -> 스크롤 크기 자동으로 달라짐
 
 */
import SnapKit
import UIKit

final class AppViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing // 간격만 동일하게 설정
        stackView.spacing = 0.0 // 결국 stackview는 subview의 높이에서만 간격이 달라짐
        
        let featureSectionView = FeatureSectionView(frame: .zero)
        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonView = ExchangeCodeButtonView(frame: .zero)
        
        // 하위 공간을 안만들면 버튼이 짤림
        let spacingVIew = UIView()
        spacingVIew.snp.makeConstraints {
            $0.height.equalTo(100.0)
        }
        
        [
            featureSectionView,
            rankingFeatureSectionView,
            exchangeCodeButtonView,
            spacingVIew
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
    }
}

private extension AppViewController {
    func setupNavigationController() {
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true // 무슨일이 있어도 larege 타이틀만
    }
    
    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview() // 가로 스크롤은 안되게 가로크기 설정
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { // stack view는 자신의 subview에따라 크기가 지정되기때문에 강제로 크기를 지정하면 안됨
            $0.edges.equalToSuperview()
        }
    }
}
