//
//  wallet_import.swift
//  megawallet
//
//  Created by hu on 2021/9/11.
//

import SwiftUI
import web3swift
import Foundation

class wallet_import_key: ObservableObject {
    @Published var privatekey: String = ""
    @Published var mnemonic: String = ""
    @Published var password: String = ""
}

struct wallet_import: View {
    @ObservedObject private var Wallet_import_key = wallet_import_key()
    var body: some View {
        HStack{
            VStack{
                TextField("input your mnemonic", text: $Wallet_import_key.mnemonic)
                TextField("input your password", text: $Wallet_import_key.password)
                Button {
                    let seed = BIP39.seedFromMmemonics(Wallet_import_key.mnemonic ?? "")!
                    let keystore = try! BIP32Keystore(seed: seed, password: Wallet_import_key.password)
                    let keystoreManager = KeystoreManager([keystore!])
                    let account = keystoreManager.addresses![0].address
                    let account_eth = keystoreManager.addresses![0]
                    let privateKey = try! keystore?.UNSAFE_getPrivateKeyData(password: Wallet_import_key.password, account: account_eth)
                    let privateKey_hexstring = privateKey?.toHexString() ?? ""
                    let judge = Insert_Wallet(Account: account, Mnemonic: Wallet_import_key.mnemonic ?? "", Private: privateKey_hexstring, database: wallet_test.database_test)
                    if judge{
                        print("创建成功")
                    }else{
                        print("创建失败")
                    }
                } label: {
                    Text("导入")
                }
            }
            VStack{
                TextField("input your privatekey", text: $Wallet_import_key.privatekey)
                TextField("input your password", text: $Wallet_import_key.password)
                Button {
                    let password = Wallet_import_key.password
                    let key = Wallet_import_key.privatekey
                    let formattedKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
                    let dataKey = Data.fromHex(formattedKey)!
                    let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
                    let account = keystore.addresses!.first!.address
                    let mnemonic = "no"
                    let judge = Insert_Wallet(Account: account, Mnemonic: mnemonic, Private: key, database: wallet_test.database_test)
                    if judge{
                        print("创建成功")
                    }else{
                        print("创建失败")
                    }
                } label: {
                    Text("导入")
                }
            }
        }
    }
}

struct wallet_import_Previews: PreviewProvider {
    static var previews: some View {
        wallet_import()
    }
}
