//
//  NFTJSON.swift
//  megawallet
//
//  Created by hu on 2021/9/28.
//

import Foundation
import Alamofire

struct HTTPBinResponse: Decodable { let url: String }

func upload(image: UIImage, json: NFT, imageName: String){
    let imageData : Data = image.pngData()!
    let httpHeaders = HTTPHeaders([:])
    AF.upload(multipartFormData: { Multipart in
//        for (key, value) in parameters {
//            Multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//        }
        Multipart.append(, withName: "data")
        Multipart.append(imageData, withName: "file", fileName: "\(imageName).jpg", mimeType: "image/jpg")
    },to: "http://10.28.179.235:8090/api/server", method: .post, headers: httpHeaders)
    .responseDecodable(of: HTTPBinResponse.self) { response in
        debugPrint(response)
    }
}
