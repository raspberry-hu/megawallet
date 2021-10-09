//
//  NFT_Content.swift
//  megawallet
//
//  Created by hu on 2021/9/23.
//

import SwiftUI

class TextBindingManager: ObservableObject {
    @Published var walletcount = ""
    @Published var showWarning = "2"
    @Published var description = ""
    @Published var set = ""
    @Published var number = ""
    @Published var description_url = ""
    @Published var name = ""
    @Published var chain = ""
    @Published var Imgae: UIImage?
}

struct NFT_Content: View {
    @EnvironmentObject var tfMgr:TextBindingManager
    var body: some View {
        VStack{
            TextField("选择钱包", text: $tfMgr.walletcount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(TextAlignment.center)
            TextField("名称", text: $tfMgr.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(TextAlignment.center)
            TextField("描述", text: $tfMgr.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(TextAlignment.center)
            TextField("详细描述链接", text: $tfMgr.description_url)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(TextAlignment.center)
            TextField("设置集合", text: $tfMgr.set)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(TextAlignment.center)
            TextField("铸造个数", text: $tfMgr.number)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(TextAlignment.center)
                .keyboardType(.numberPad)
            Menu("选择主链"){
//                Button("Ethereum", action: {
//                    tfMgr.chain = "Ethereum"
//                })
                Button("rinkeby", action: {
                    tfMgr.chain = "rinkeby"
                })
                .foregroundColor(.gray)
            }
            HStack{
                Button("铸币", action: {
                    let value = Int(tfMgr.walletcount)!
                    let wallet:WalletTable = Search_Wallet(Count: value, database: wallet_test.database_test)!
                    let chain_json = upload_chain(network: tfMgr.chain, owner_address: wallet.WalletAccount!)
                    print("1")
                    print(chain_json)
                    print("2")
                    let nft = NFT(tfMgr.name, tfMgr.description, tfMgr.number, tfMgr.description_url, tfMgr.set, chain_json)
                    let jsonstring = encoder(loan: nft)
                    upload(image: tfMgr.Imgae!, json: jsonstring!, imageName: tfMgr.name)
                })
                .foregroundColor(.gray)
                .padding()
                Button("取消", action: {
                    tfMgr.description = ""
                    tfMgr.description_url = ""
                    tfMgr.name = ""
                    tfMgr.number = ""
                    tfMgr.chain = ""
                    tfMgr.set = ""
                })
                .foregroundColor(.gray)
                .padding()
            }
        }
    }
}

struct NFT_Content_Previews: PreviewProvider {
    static var previews: some View {
        NFT_Content()
    }
}
