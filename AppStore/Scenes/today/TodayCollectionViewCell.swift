//
//  todayCollectionViewCell.swift
//  AppStore
//
//  Created by 정상훈 on 2023/01/14.
//

import SnapKit
import Kingfisher
import UIKit

final class TodayCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true //이미지뷰의 크기보다 이미지가 크면 clip 시킴
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    func setup(today: Today) {
        setUpSubViews()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        
        subTitleLabel.text = today.subTitle
        descriptionLabel.text = today.description
        titleLabel.text = today.title
        
        if let imageURL = URL(string: today.imageURL) {
            imageView.kf.setImage(with: imageURL)
        }
    }
}

private extension TodayCollectionViewCell {
    func setUpSubViews() {
        [imageView, titleLabel, subTitleLabel, descriptionLabel]
            .forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0) //offset
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(24.0)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
