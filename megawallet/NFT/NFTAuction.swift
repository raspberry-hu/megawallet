//
//  NFTAuction.swift
//  megawallet
//
//  Created by hu on 2021/11/5.
//

import Foundation
import Alamofire

struct NftAuction: Encodable {
    var network: String
    var owner_address: String
    var my_mnemonic: String
    var start_price: Int
    var expirationTime: Int
    var token_id: String
}

struct NftAuctionResponse: Codable{
    var code: Int?
    var msg: String?
}

func UploadNftAuction(NftAuction: NftAuction) -> String{
    var Msg = "0"
    let queue = DispatchQueue.global()
    let sema = DispatchSemaphore(value: 0)
    print("开始upload")
    AF.request("http://10.112.110.230:8888/api/euAuction",
               method: .post,
               parameters: NftAuction,
               requestModifier: { $0.timeoutInterval = 180})
        .responseDecodable(queue: queue){ (response: AFDataResponse<NftAuctionResponse>) in
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
