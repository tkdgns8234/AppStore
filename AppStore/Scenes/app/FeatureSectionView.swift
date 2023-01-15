//
//  FeatureSectionView.swift
//  AppStore
//
//  Created by 정상훈 on 2023/01/14.
//

import SnapKit
import UIKit
import SwiftUI

final class FeatureSectionView: UIView {
    private var featureList: [Feature] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.isPagingEnabled = true //가로 스크롤 될 때 width에 딱맞는 크기로 페이징됨
        collectionview.backgroundColor = .systemBackground
        collectionview.showsHorizontalScrollIndicator = false
        
        collectionview.register(FeatureSectionCollectionViewCell.self, forCellWithReuseIdentifier: "FeatureSectionCollectionViewCell")
        return collectionview
    }()
    
    private let seperatorView: SeparatorView = SeparatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        fetchData()
        collectionView.reloadData() //데이ㅓㅌ를 가져온 후 꼭 한번 다시그리기
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FeatureSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // cell 재사용
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionCollectionViewCell", for: indexPath) as? FeatureSectionCollectionViewCell
        
        let feature = featureList[indexPath.item]
        cell?.setUp(feature: feature)
        
        return cell ?? UICollectionViewCell()
    }
}

extension FeatureSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    //섹션의 최소 마진
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32.0
    }
    
}

private extension FeatureSectionView {
    func setupViews() {
        [collectionView, seperatorView].forEach {
            addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(snp.width)
            $0.bottom.equalToSuperview()
        }
        
        seperatorView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
        }
    }
    
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Data/Feature", withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            self.featureList = result
        } catch {}
    }
}
