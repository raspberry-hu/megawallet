//
//  wallet_create.swift
//  megawallet
//
//  Created by hu on 2021/9/11.
//

import SwiftUI
import web3swift
import WCDBSwift
import Foundation

class ZipCodeModel: ObservableObject {
    var limit: Int = 64
    @Published var zip: String = "" {
        didSet {
            if zip.count > limit {
                zip = String(zip.prefix(limit))
            }
        }
    }
}

struct wallet_create: View {
    @ObservedObject private var zipCodeModel = ZipCodeModel()
    var body: some View {
        VStack{
            TextField("Input your password", text: $zipCodeModel.zip)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
            HStack{
                if !zipCodeModel.zip.isEmpty{
                    Button(action:{
                        zipCodeModel.zip = ""
                    }){
                        Text("取消")
                    }
                    }
                    Button (action:{
                        let password = zipCodeModel.zip
                        let mnemonic = try?BIP39.generateMnemonics(bitsOfEntropy: 128)
                        let seed = BIP39.seedFromMmemonics(mnemonic ?? "")!
                        let keystore = try! BIP32Keystore(seed: seed, password: password)
                        let keystoreManager = KeystoreManager([keystore!])
                        let account = keystoreManager.addresses![0].address
                        let account_eth = keystoreManager.addresses![0]
                        let privateKey = try! keystore?.UNSAFE_getPrivateKeyData(password: password, account: account_eth)
                        let privateKey_hexstring = privateKey?.toHexString() ?? ""
                        let judge = Insert_Wallet(Account: account, Mnemonic: mnemonic ?? "", Private: privateKey_hexstring, database: wallet_test.database_test)
                        if judge{
                            print("创建成功")
                        }else{
                            print("创建失败")
                        }
                    }){
                        Text("确定")
                    }
                }
            
            }
        }
    }

struct wallet_create_Previews: PreviewProvider {
    static var previews: some View {
        wallet_create()
    }
}
