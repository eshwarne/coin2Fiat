//
//  CoinsListView.swift
//  Coin2Fiat
//
//  Created by Eshwar S on 31/12/21.
//

import SwiftUI
class CoinsListViewModel {
    var coins: [Asset] = []
    init(){
        
    }
    func getAllCoins(){
        guard let url = URL(string: URLUtils.allAssetsUrl()) else {
            return
        }
        var urlRequest = URLRequest(url: url)
        let authHeaders = try! URLUtils.authHeaders()
        urlRequest.setValue(authHeaders.value, forHTTPHeaderField: authHeaders.header)
        
    }
}
struct CoinsListView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CoinsListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsListView()
    }
}
