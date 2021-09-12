//
//  wallet_create.swift
//  megawallet
//
//  Created by hu on 2021/9/11.
//

import SwiftUI
import web3swift

struct wallet_create: View {
    var body: some View {
        let mnemonic = try?BIP39.generateMnemonics(bitsOfEntropy: 128)
        // 助记词转换为随机种子
        let seed = BIP39.seedFromMmemonics(mnemonic ?? "")!
        let seed1 = seed.toHexString()
        let see = seed.base64EncodedString()
        let keystore = try! BIP32Keystore(seed: seed, password: "123456")
        let keystoreManager = KeystoreManager([keystore!])
        let account = keystoreManager.addresses![0].address
        VStack{
            Text(mnemonic ?? "")
            Text(seed1)
            Text(see)
            Text(account)
        }
    }
}

struct wallet_create_Previews: PreviewProvider {
    static var previews: some View {
        wallet_create()
    }
}
