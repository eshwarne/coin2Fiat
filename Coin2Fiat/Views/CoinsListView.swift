//
//  CoinsListView.swift
//  Coin2Fiat
//
//  Created by Eshwar S on 31/12/21.
//

import SwiftUI
import Combine
class CoinsListViewModel: ObservableObject {
    @Published var coins: AssetsData = []
    init(){
        print("EXEC")
        guard let url = URL(string: URLUtils.allAssetsUrl()) else {
            return
        }
     
        var urlRequest = URLRequest(url: url)
        let authHeaders = try! URLUtils.authHeaders()
        urlRequest.setValue(authHeaders.value, forHTTPHeaderField: authHeaders.header)
        let session = URLSession.shared
        let fetchAssetsTask = session.dataTask(with: urlRequest) {
            (data, response, error) in
                if error != nil {
                    return
                } else {
                    guard let data = data else {
                        return
                    }
                    
                        DispatchQueue.main.async {
                            do {
                                self.coins = try JSONDecoder().decode(AssetsData.self, from: data).filter{
                                    asset in
                                    asset.typeIsCrypto == 1
                                }
                            }
                            catch {
                                print(error)
                             
                            }
                        
                        }
                       
                
                    
                }
        }
        fetchAssetsTask.resume()
        return
    }
       
}
struct CoinsListView: View {
    @StateObject var coinsListVM = CoinsListViewModel.init()
    var body: some View {
        List(coinsListVM.coins){ coin in
            Text(coin.name)
        }
        
    }
}

struct CoinsListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsListView()
    }
}
