//
//  CoinsListView.swift
//  Coin2Fiat
//
//  Created by Eshwar S on 31/12/21.
//

import SwiftUI
import Combine
var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
class CoinsListViewModel: ObservableObject {
    @Published var coins: AssetsData = []
    @Published var hasLoaded = false;
    @Published var hasError = false
    init(){
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
                    self.hasLoaded = true
                    self.hasError = true
                    return
                } else {
                    guard let data = data else {
                        self.hasLoaded = true
                        self.hasError = true
                        return
                    }
                    
                        DispatchQueue.main.async {
                            do {
                                self.hasLoaded = true
                                self.coins = try JSONDecoder().decode(AssetsData.self, from: data).filter{
                                    asset in
                                    asset.typeIsCrypto == 1
                                }
                            }
                            catch {
                                self.hasError = true
                                print(error)
                             
                            }
                        
                        }
                       
                
                    
                }
        }
        fetchAssetsTask.resume()
        return
    }
       
}

let cardBackgroundColor = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2724343844))
let cardShadowColor = Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))

struct CoinsListView: View {
    @StateObject var coinsListVM = CoinsListViewModel.init()
    var body: some View {
        if coinsListVM.hasLoaded {
            if !coinsListVM.hasError {
                ScrollView{
                    LazyVGrid(columns: twoColumnGrid, spacing: 20){
                        ForEach(coinsListVM.coins) { coin in
                            ZStack{
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .fill(.white)
                                    .shadow(color:cardShadowColor, radius: 10, x: 0, y: 10)
                                    .frame(height: 100 )
                                    
                                    
                                CoinRowView(coin: coin)
                                    .padding()
                            }
                            .padding()
                          
                           
                        }
                    }
                }
            } else {
                VStack{
                    Text("COINS UNAVAILABLE, TRY LATER")
                }
            }
        } else {
            VStack{
                Text("Loading Coins...")
            }
        }
       
        
    }
}

struct CoinsListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsListView()
    }
}
