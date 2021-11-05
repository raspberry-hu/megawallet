//
//  NFTSell.swift
//  megawallet
//
//  Created by hu on 2021/11/5.
//

import Foundation
import Alamofire

struct NftSell: Encodable {
    var network: String
    var owner_address: String
    var my_mnemonic: String
    var fix_price: Int
    var token_id: String
}

struct NftSellResponse: Codable{
    var code: Int?
    var msg: String?
}

func UploadNftSell(NftSell: NftSell) -> String{
    var Msg = "0"
    let queue = DispatchQueue.global()
    let sema = DispatchSemaphore(value: 0)
    print("开始upload")
    AF.request("http://10.112.110.230:8888/api/fixSell",
               method: .post,
               parameters: NftSell,
               requestModifier: { $0.timeoutInterval = 180})
        .responseDecodable(queue: queue){ (response: AFDataResponse<NftSellResponse>) in
            debugPrint(response)
            switch response.result {
            case .success(let model):
                Msg = model.msg!
            case .failure(let error):
                print("error")
            }
        sema.signal()
    }
    print("wait开始")
    sema.wait()
    print("wait结束")
    return Msg
}
