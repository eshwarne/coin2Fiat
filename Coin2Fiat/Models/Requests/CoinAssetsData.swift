//
//  CoinAssetsData.swift
//  Coin2Fiat
//
//  Created by Eshwar S on 31/12/21.
//


import Foundation

// MARK: - Asset
struct Asset: Codable {
    let assetID, name: String
    let typeIsCrypto: Int
    let idIcon: String

    enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case name
        case typeIsCrypto = "type_is_crypto"
        case idIcon = "id_icon"
    }
}

// MARK: - Asset Data
typealias AssetsData = [Asset]
