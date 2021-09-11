//
//  filewallet.swift
//  megawallet
//
//  Created by hu on 2021/9/11.
//

import SwiftUI

struct filewallet: View {
    var body: some View {
//        let wallet = HDWallet(strength: 128, passphrase: "")
//        Text(wallet?.mnemonic ?? "")
        HStack{
            VStack{
//                Button(action: {
//                    let wallet = HDWallet(strength: 128, passphrase: "")
//                    Text(wallet?.mnemonic ?? "")
//                }, label: {
//                    Text("创建钱包")
//                })
                NavigationLink(destination: wallet_create()) {
                                Text("创建钱包")
                }
            }
            VStack{
//                Button(action: {
//                    let wallet = HDWallet(strength: 128, passphrase: "")
//                    Text(wallet?.mnemonic ?? "")
//                }, label: {
//                    Text("导入钱包")
//                })
                NavigationLink(destination: wallet_import()) {
                                Text("导入钱包")
                }
            }
        }
    }
}

struct filewallet_Previews: PreviewProvider {
    static var previews: some View {
        filewallet()
    }
}
