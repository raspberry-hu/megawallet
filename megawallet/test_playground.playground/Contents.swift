import Foundation
import Alamofire
import PlaygroundSupport

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

let mnemonic = Login(network:"rinkeby", owner_address: "0xcccA3b7c428A4b6FFae5022Ab3A0B57C531f3aD0")

//AF.request("http://10.112.110.230:8888/api/mint",
//           method: .post,
//           parameters: menmonic,
//           encoder: JSONParameterEncoder.default)
//    .responseJSON { response in
//    debugPrint(response)
//    print(response.result)
//    let result = response.result
//    print("0")
//    let t = String(bytes: response.data!, encoding: .utf8)!
//    print(String(bytes: response.data!, encoding: .utf8)!)
//    switch result {
//    case .success(let data):
//    //print(String(bytes: data, encoding: .utf8)!)
//    print("1")
//    print(data)
//    print("2")
//    var key = response.result
//    print(decode_1(json: t))
//    print("3")
//    case .failure(let Error):
//    print("error")
//  }
//}

func decode_1(json: String) -> (NFT_zhubi?) {
    if let jsonData = json.data(using: .utf8) {
        do {
            let loan = try decoder.decode(NFT_zhubi.self, from: jsonData)
            return loan
        } catch {
            print(error)
        }
    }
    return nil
}

//func performRequest(mnemonic: Login, completion: @escaping (_ Str: String) -> String) {
//    AF.request("http://10.112.110.230:8888/api/mint",
//               method: .post,
//               parameters: menmonic,
//               encoder: JSONParameterEncoder.default)
//        .responseJSON{ response in
//            switch response.result {
//            case .success(let JSON):
//                let t = String(bytes: response.data!, encoding: .utf8)!
//                let key = decode_1(json: t)
//                completion(key!.msg)
//            case .failure(let error):
//                completion("0")
//            }
//        }
//    AF.request(urlEndPointApp, method: .post, parameters: parameters, encoding: URLEncoding.httpBody,  headers: headers).validate().responseJSON{ response in
//        switch response.result {
//        case .success(let JSON): // stores the json file in JSON variable
//            // the JSON file is printed correctly
//            print("Validation Successful with response JSON \(JSON)")
//            // this variable is seen as nil outside this function (even in return)
//            completion(.success(JSON))
//        case .failure(let error):
//            print("Request failed with error \(error)")
//            completion(.failure(error))
//        }
//    }
//}

//struct ResponseManager {
//
//    static let responseManager = ResponseManager()
//
//    let queue = DispatchQueue(label: "com.tsn.demo.escapingClosure", attributes: .concurrent)
//
//    let group = DispatchGroup()
//
//    func requestJSON(mnemonic: Login, completionHandler: @escaping(String?, Error?) -> Void){
//        queue.async {
//            AF.request("http://10.112.110.230:8888/api/mint",
//                       method: .post,
//                       parameters: mnemonic,
//                       encoder: JSONParameterEncoder.default)
//                .responseJSON { response in
//                    debugPrint(response)
//                    print(response.result)
//                    let result = response.result
//                    let t:String? = String(bytes: response.data!, encoding: .utf8)
//                    switch result {
//                    case .success(let data):
//                    //print(decode_1(json: t))
//                        guard let string1 = t else{
//                            return
//                        }
//                        DispatchQueue.main.async {
//                            completionHandler(string1, nil)
//                        }
//                    case .failure(let Error):
//                    DispatchQueue.main.async {
//                        completionHandler(nil, Error)
//                    }
//                }
//            }
//        }
//    }
//
//    private init() {
//
//    }
//}
//print("9")
//ResponseManager.responseManager.requestJSON(mnemonic: mnemonic){ (string1: String?, error: Error?) in
//    if let error = error {
//        print("error==========\(error)")
//    } else{
//        guard let str = string1 else {return}
//        print(decode_1(json: str)?.code)
//    }
//}
//print("10")
//func test() -> (String){
//    var msg = "0x112"
//    let group = DispatchGroup()
//    let mnemonic = Login(network:"rinkeby", owner_address: "0xcccA3b7c428A4b6FFae5022Ab3A0B57C531f3aD0")
//    DispatchQueue.global().async {
//        AF.request("http://10.112.110.230:8888/api/mint",
//                   method: .post,
//                   parameters: mnemonic,
//                   encoder: JSONParameterEncoder.default)
//         .responseJSON { response in
////         debugPrint(response)
////         print(response.result)
//         let result = response.result
////         print("0")
//         let t = String(bytes: response.data!, encoding: .utf8)!
////         print(String(bytes: response.data!, encoding: .utf8)!)
//         switch result {
//         case .success(let data):
//         //print(String(bytes: data, encoding: .utf8)!)
////         print(data)
//         var key = response.result
////         print(decode_1(json: t))
////         print("3")
//         msg = decode_1(json: t)!.msg
//         case .failure(let Error):
//         print("error")
//       }
//      }
//    }
//    group.notify(queue: DispatchQueue.main){
//
//    }
//    return msg
//}
//let test1 = test()
//print(test1)

func test02() -> String{
    var msg = "0x112"
    let mnemonic = Login(network:"rinkeby", owner_address: "0xcccA3b7c428A4b6FFae5022Ab3A0B57C531f3aD0")
    let queue = DispatchQueue.global()
    let sema = DispatchSemaphore(value: 0)
        AF.request("http://10.112.110.230:8888/api/mint",
                    method: .post,
                    parameters: mnemonic,
                    encoder: JSONParameterEncoder.default)
            .responseJSON(queue: queue) { response in
        debugPrint(response)
        let result = response.result
        let t = String(bytes: response.data!, encoding: .utf8)
        //print(t)
        switch result {
        case .success(let data):
        var key = response.result
            //msg = decode_1(json: t)!.msg
            //msg = t!
            print("1")
            print(msg)
        case .failure(let Error):
            print("error")
        }
        sema.signal()
      }
    sema.wait()
    return msg
}
//print(test02())
