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
        let mnemonic = try?BIP39.generateMnemonics(bitsOfEntropy: 128)
        let seed = BIP39.seedFromMmemonics(mnemonic ?? "")!
        let seed1 = seed.toHexString()
        let see = seed.base64EncodedString()
        let keystore = try! BIP32Keystore(seed: seed, password: "123456")
        let keystoreManager = KeystoreManager([keystore!])
        let account = keystoreManager.addresses![0].address
        let account_eth = keystoreManager.addresses![0]
        let privateKey = try! keystore?.UNSAFE_getPrivateKeyData(password: "123456", account: account_eth)
        let privateKey_hexstring = privateKey?.toHexString() ?? ""
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
                        let judge = Insert_Wallet(Account: account, Mnemonic: mnemonic ?? "", Private: privateKey_hexstring, database: wallet_test.database_test)
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
