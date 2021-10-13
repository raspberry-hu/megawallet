import Foundation
import Alamofire

struct NFT: Codable {
    var nft_name: String
    var description: String
    var mint_num: String
    var external_link: String
    var input_arr: String
    var tokenId: String
    init(_ name: String, _ description: String, _ number: String, _ external_link: String, _ input_arr: String, _ tokenId: String){
        self.nft_name = name
        self.description = description
        self.external_link = external_link
        self.mint_num = number
        self.input_arr = input_arr
        self.tokenId = tokenId
    }
}

struct NFT_zhubi: Codable {
    var code: String
    var msg: String
    init(_ code: String, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

struct NFTSellRequest: Encodable {
    let network: String
    let owner_address: String
    let my_mnemonic: String
    let fix_price: Int
    let token_id: String
}

struct NFTSellResponse: Codable{
    var code: Int
    var msg: String
    init(_ code: Int, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

struct NFTNetherlandsSellRequest: Encodable{
    let network: String
    let owner_address: String
    let my_mnemonic: String
    let start_price: String
    let end_price: String
    let expirationTime: String
    let token_id: String
}

struct NFTNetherlandsSellResponse: Codable{
    var code: Int
    var msg: String
    init(_ code: Int, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

struct NFTEnglandSellRequest: Encodable{
    let network: String
    let owner_address: String
    let my_mnemonic: String
    let start_price: String
    let end_price: String
    let expirationTime: String
    let token_id: String
}

struct NFTEnglandSellResponse: Codable{
    var code: Int
    var msg: String
    init(_ code: Int, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

struct NFTBindSellRequest: Encodable{
    let network: String
    let owner_address: String
    let my_mnemonic: String
    let bundleName: String
    let bundleDescription: String
    let start_price: String
    let expirationTime: String
    let token_id: String
}

struct NFTBindSellResponse: Codable{
    var code: Int
    var msg: String
    init(_ code: Int, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

struct NFTAssetsRequest: Encodable{
    let owner: String
    let asset_contract_address: String
    let limit: String
}

struct NFTAssetsResponse: Codable{
    var code: Int
    var msg: String
    init(_ code: Int, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

struct NFTBundlesRequest: Encodable{
    let on_sale: Bool
    let owner: String
    let asset_contract_address: String
    let limit: String
}

struct NFTBundlesResponse: Codable{
    var code: Int
    var msg: String
    init(_ code: Int, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

struct NFTEventsRequest: Encodable{
    let asset_contract_address: String
    let account_address: String
    let limit: String
    let only_opensea: Bool
    let event_type: String
    let auction_type: String
}

struct NFTEventsResponse: Codable{
    var code: Int
    var msg: String
    init(_ code: Int, _ msg: String){
        self.code = code
        self.msg = msg
    }
}

struct NFTTokenidResponse: Codable{
    var code: Int?
    var msg: String?
    //var id: Int?
}

struct mnemonic_json: Encodable {
    let network: String
    let owner_address: String
}

struct HTTPBinResponse: Decodable { let url: String }
let decoder = JSONDecoder()
let encoder = JSONEncoder()

func upload(image: UIImage, json: String, imageName: String){
    let imageData : Data = image.pngData()!
    let httpHeaders = HTTPHeaders([:])
    AF.upload(multipartFormData: { Multipart in
        Multipart.append(json.data(using: String.Encoding.utf8)!, withName: "data")
        Multipart.append(imageData, withName: "file", fileName: "\(imageName).jpg", mimeType: "image/png")
    },to: "http://10.28.179.235:8090/api/server", method: .post, headers: httpHeaders)
    .responseDecodable(of: HTTPBinResponse.self) { response in
        debugPrint(response)
    }
}

func upload_chain(network: String, owner_address: String) -> String{
    let menmonic = mnemonic_json(network: network, owner_address: owner_address)
    var Msg = "0"
    let queue = DispatchQueue.global()
    let sema = DispatchSemaphore(value: 0)
    AF.request("http://10.112.110.230:8888/api/mint",
               method: .post,
               parameters: menmonic,
               encoder: JSONParameterEncoder.default, requestModifier: { $0.timeoutInterval = 60})
        .responseJSON { response in
        let result = response.result
        let t = String(bytes: response.data!, encoding: .utf8)!
        switch result {
        case .success(let data):
            Msg = decode_msg(json: t)!.msg
        case .failure(let Error):
        print("error")
      }
        sema.signal()
    }
    sema.wait()
    return Msg
}

func upload_chain_tokenid() -> String{
    var Msg = "0"
    let queue = DispatchQueue.global()
    let sema = DispatchSemaphore(value: 0)
    AF.request("http://10.112.110.230:8888/api/getTokenId", method: .post, requestModifier: { $0.timeoutInterval = 60})
        .responseDecodable{ (response: AFDataResponse<NFTTokenidResponse>) in
            switch response.result {
            case .success(let model):
                Msg = model.msg!
                break
            case .failure(let error):
                break
            }
            sema.signal()
        }

    sema.wait()
    return Msg
}

func decode(json: String) -> (NFT?) {
    if let jsonData = json.data(using: .utf8) {
        do {
            let loan = try decoder.decode(NFT.self, from: jsonData)
            print(loan)
            return loan
        } catch {
            print(error)
        }
    }
    return nil
}

func decode_msg(json: String) -> (NFT_zhubi?) {
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

func encoder(loan: NFT) -> String?{
    do  {
        let data: Data = try encoder.encode(loan)
        let json_string = String(data: data, encoding: String.Encoding.utf8) ?? ""
        print(data)
        print(String(data: data, encoding: String.Encoding.utf8) as Any)
        print(loan)
        return json_string
    } catch {
        print(error)
    }
    return nil
}

func encoder_msg(loan: NFT_zhubi) -> String?{
    do  {
        let data: Data = try encoder.encode(loan)
        let json_string = String(data: data, encoding: String.Encoding.utf8) ?? ""
        print(data)
        print(String(data: data, encoding: String.Encoding.utf8) as Any)
        print(loan)
        return json_string
    } catch {
        print(error)
    }
    return nil
}
