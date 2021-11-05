//
//  filewallet.swift
//  megawallet
//
//  Created by hu on 2021/9/11.
//

import SwiftUI

struct filewallet: View {
    var body: some View {
        HStack{
            VStack{
                NavigationLink(destination: wallet_create()) {
                                Text("创建钱包")
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                }
            }
            VStack{
                NavigationLink(destination: wallet_import()) {
                                Text("导入钱包")
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
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
