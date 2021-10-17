import UIKit
import Alamofire

struct Login: Encodable {
    let network: String
    let owner_address: String
    let mint_number: Int
}

func decode_1(json: String) -> (NFT_zhubi?) {
    if let jsonData = json.data(using: .utf8) {
        do {
            let loan = try decoder.decode(NFT_zhubi.self, from: jsonData)
            print(loan)
            return loan
        } catch {
            print(error)
        }
    }
    return nil
}

struct NFT_zhubi: Codable {
    var code: Int
    var msg: String
    init(_ code: Int, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

struct NFTTradeResponse: Codable{
    var code: Int?
    var msg: [String]
}

func test02() -> String{
    var msg = "0x112"
    let mnemonic = Login(network:"rinkeby", owner_address: "0xcccA3b7c428A4b6FFae5022Ab3A0B57C531f3aD0", mint_number: 1)
    let queue = DispatchQueue.global()
    print("进入线程")
    let sema = DispatchSemaphore(value: 0)
        AF.request("http://10.112.110.230:8888/api/mint",
                    method: .post,
                    parameters: mnemonic,requestModifier: {$0.timeoutInterval = 120})
            .responseDecodable(queue: queue){ (response: AFDataResponse<NFTTradeResponse>) in
        debugPrint(response)
                switch response.result {
                case .success(let model):
                    msg = model.msg[0]
                case .failure(let error):
                    print("error")
                }
                sema.signal()
      }
    sema.wait()
    return msg
}
func upload_chain_tokenid() -> String{
    var Msg = "0"
    let queue = DispatchQueue.global()
    let sema = DispatchSemaphore(value: 0)
    print("tokenid_upload")
    AF.request("http://10.112.110.230:8888/api/getTokenId", method: .post, requestModifier: { $0.timeoutInterval = 120})
        .responseDecodable(queue: queue){ (response: AFDataResponse<NFTTokenidResponse>) in
            switch response.result {
            case .success(let model):
                Msg = model.msg!
            case .failure(let error):
                print("error")
            }
            sema.signal()
        }

    sema.wait()
    return Msg
}

print(test02())
print(upload_chain_tokenid())
