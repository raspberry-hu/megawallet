//
//  NFTSellView.swift
//  megawallet
//
//  Created by hu on 2021/11/5.
//

import SwiftUI

extension View{
    func prefixedWithIcon(named name: String) -> some View {
        HStack {
            Image(systemName: name)
            self
        }
    }
}

struct NFTSellView: View {
    @State private var fix_price: String
    @State private var network: String
    @State var NFTSell: NftSell
    @State var url: String
    let token_id: String
    let wallet:WalletTable = Search_Wallet(Count: 0, database: wallet_test.database_test)!
    var body: some View {
        NavigationView{
            Form{
                TextField("选择价格", text: $fix_price)
                    .prefixedWithIcon(named: "bitcoinsign.circle.fill")
                TextField("选择主链", text: $network)
                    .prefixedWithIcon(named: "link.circle.fill")
                Button(
                    action: {
                        NFTSell.fix_price = Int(fix_price)!
                        NFTSell.network = network
                        NFTSell.owner_address = wallet.WalletAccount!
                        NFTSell.my_mnemonic = wallet.WalletMnemonic!
                        NFTSell.token_id = token_id
                        url = UploadNftSell(NftSell: NFTSell)
                    },
                    label: { Text("确定") }
                )
            }.navigationTitle(Text("定价销售"))
            if #available(iOS 15.0, *) {
                Link("Go To OpenSea", destination: URL(string: url)!)
                    .buttonStyle(.borderedProminent)
            } else {
                Link("Go To OpenSea", destination: URL(string: url)!)
            }
        }
    }
}
