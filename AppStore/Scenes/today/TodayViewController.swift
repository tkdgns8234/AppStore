//
//  TodayViewController.swift
//  AppStore
//
//  Created by 정상훈 on 2023/01/14.
//

import SnapKit
import UIKit

final class TodayViewController: UIViewController {
    
    private var todayList: [Today] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // 반드시 레이아웃을 초기화 해줘야함
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "todayCell")
        collectionView.register(
            TodayCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, //string 대신 미리 정의된 string 사용
            withReuseIdentifier: "TodayCollectionHeaderView"
        )
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        fetchData()
    }
}

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell
        debugPrint("row=" + String(indexPath.row) + "item= " + String(indexPath.item))
        let today = todayList[indexPath.item]
        cell?.setup(today: today)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayList.count
    }
    
    // 헤더 리턴
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 헤더, 푸터 모두 kind 사용하기에 구분해야함
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayCollectionHeaderView", for: indexPath
              ) as? TodayCollectionHeaderView else { return UICollectionReusableView() }
        
        header.setupViews()
        return header
    }
}

//그냥 delegate 가 아니라 delegateflowlayout임에 유의
extension TodayViewController: UICollectionViewDelegateFlowLayout {
    // cell 사이즈 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32.0 //16씩 패딩을 줌
        
        return CGSize(width: width, height: width)
    }
    
    //헤더 사이즈 정하자
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32.0, height: 100.0)
    }
    
    // 섹션간의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value:CGFloat = 16.0
        
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    // 아이템 선택 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let today = todayList[indexPath.item]
        let vc = AppdetailViewController(today: today)
        present(vc, animated: true)
    }
}

private extension TodayViewController {
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Data/Today", withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Today].self, from: data)
            todayList = result
        } catch {
            
        }
    }
}
