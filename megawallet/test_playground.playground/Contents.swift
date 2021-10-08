import Foundation
import Alamofire

struct Login: Encodable {
    let network: String
    let owner_address: String
}

struct NFT_zhubi: Codable {
    var code: Int
    var msg: String 
    init(_ code: Int, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

let menmonic = Login(network:"rinkeby", owner_address: "0xcccA3b7c428A4b6FFae5022Ab3A0B57C531f3aD0")

AF.request("http://10.112.110.230:8888/api/mint",
           method: .post,
           parameters: menmonic,
           encoder: JSONParameterEncoder.default)
    .responseJSON { response in
    debugPrint(response)
    print(response.result)
    let result = response.result
    print("0")
    let t = String(bytes: response.data!, encoding: .utf8)!
    print(String(bytes: response.data!, encoding: .utf8)!)
    switch result {
    case .success(let data):
    //print(String(bytes: data, encoding: .utf8)!)
    print("1")
    print(data)
    print("2")
    var key = response.result
    print(decode_1(json: t))
    print("3")
    case .failure(let Error):
    print("error")
  }
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
