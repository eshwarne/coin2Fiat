//
//  CoinRowView.swift
//  Coin2Fiat
//
//  Created by Eshwar S on 31/12/21.
//

import SwiftUI
import Combine
class CoinRowViewModel: ObservableObject {
    @Published var iconLoaded = false
    @Published var icon:UIImage?
    init(iconId:String){
        if iconId == "NO ICON" {
            return
        }
        guard let iconUrl = URL(string:URLUtils.iconUrl(iconId: iconId)) else {
            print("ERROR")
            return
        }
        print("PARSEDDD")
        URLSession.shared.dataTask(with: iconUrl){ data, response, error in
            if error != nil {
                print("ERROR")
                return
            } else {
                guard let data = data else {
                    print("ERROR")
                    return
                }
                DispatchQueue.main.async {
                    self.iconLoaded = true
                    self.icon = UIImage(data: data)
                   
                }
               
            }
            
            
        }.resume()
    }
}
struct CoinRowView: View {
    var coin:Asset?
    @StateObject private var coinVM:CoinRowViewModel
    init(coin:Asset?){
        self.coin = coin
        _coinVM = StateObject(wrappedValue: CoinRowViewModel(iconId: coin?.idIcon ?? "NO ICON"))
    }
    var body: some View {
        HStack{
            Text(
                coin?.name ?? ""
            )
            Spacer()
            if coinVM.iconLoaded {
                Image(uiImage: coinVM.icon!)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            } else {
                Text("Loading icon...")
            }
           
        }
      
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin:nil)
    }
}
