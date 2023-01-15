//
//  Feature.swift
//  AppStore
//
//  Created by 정상훈 on 2023/01/15.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
