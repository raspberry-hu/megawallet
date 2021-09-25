//
//  NFT_Content.swift
//  megawallet
//
//  Created by hu on 2021/9/23.
//

import SwiftUI

class TextBindingManager: ObservableObject {
    @Published var showWarning = false
    @Published var description = ""
    @Published var set = ""
    @Published var number = ""
    @Published var description_url = ""
    @Published var name = ""
    @Published var chain = ""
    @Published var Imgae: Image?
}

struct NFT_Content: View {
    @EnvironmentObject var tfMgr:TextBindingManager
    var body: some View {
        VStack{
            TextField("名称", text: $tfMgr.name)
            TextField("描述", text: $tfMgr.description)
            TextField("详细描述链接", text: $tfMgr.description_url)
                .keyboardType(.URL)
            TextField("设置集合", text: $tfMgr.description)
            TextField("铸造个数", text: $tfMgr.number)
                .keyboardType(.numberPad)
            Menu("选择主链"){
                Button("Ethereum", action: {
                    tfMgr.chain = "Ethereum"
                })
                Button("Polygon", action: {
                    tfMgr.chain = "Polygon"
                })
            }
            HStack{
                Button("上传", action: {
                    print(self.tfMgr.Imgae)
                    
                })
                Button("取消", action: {
                    tfMgr.description = ""
                    tfMgr.description_url = ""
                    tfMgr.name = ""
                    tfMgr.number = ""
                    tfMgr.chain = ""
                })
            }
        }
    }
}

struct NFT_Content_Previews: PreviewProvider {
    static var previews: some View {
        NFT_Content()
    }
}
