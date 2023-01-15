//
//  RankingFeature.swift
//  AppStore
//
//  Created by 정상훈 on 2023/01/15.
//

import Foundation

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
