//
//  URLUtils.swift
//  Coin2Fiat
//
//  Created by Eshwar S on 31/12/21.
//

import Foundation
enum URLError: Error {
    case ApiKeyNotFound
}
class URLUtils {
    private static var iconBaseUrl="https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id"
    static var coinApiBaseUrl = "https://rest.coinapi.io"
    static func iconUrl(iconId: String, iconSize:String = "512") -> String{
        let iconIdParsed = iconId.replacingOccurrences(of: "-", with: "")
        return iconBaseUrl+"/png_\(iconSize)/\(iconIdParsed).png"
    }
    static func allAssetsUrl() -> String{
        return coinApiBaseUrl + "/v1/assets"
    }
    static func authHeaders() throws -> (header:String, value:String) {
        if let infoDict = Bundle.main.infoDictionary {
            
            return("X-CoinAPI-Key", infoDict["COINAPI_API_SECRET_KEY"] as! String)
        } else {
            throw URLError.ApiKeyNotFound
        }
    }
}
