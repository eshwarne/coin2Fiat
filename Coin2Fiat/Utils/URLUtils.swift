//
//  URLUtils.swift
//  Coin2Fiat
//
//  Created by Eshwar S on 31/12/21.
//

import Foundation
class URLUtils {
    private static var iconBaseUrl="https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id"
    static var coinApiBaseUrl = "https://rest.coinapi.io"
    static func iconUrl(iconId: String, iconSize:String = "512") -> String{
        let iconIdParsed = iconId.replacingOccurrences(of: "-", with: "")
        return iconBaseUrl+"/png_\(iconSize)/\(iconIdParsed)"
    }
    static func allAssetsUrl() -> String{
        return coinApiBaseUrl + "/v1/assets"
    }
}
