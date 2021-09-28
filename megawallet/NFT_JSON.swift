//
//  NFT_JSON.swift
//  megawallet
//
//  Created by hu on 2021/9/26.
//

import Foundation
class JSONHelper{
    /*
     let json = "[ 1, \"Banana\", 2, \"Apple\", 3, \"Orange\", 4, \"Apricot\" ]"
     print(JSONHelper.json2array(jstr:json))
     */

    static func json2array(jstr:String) -> [Any]{

        let json = jstr
        let result:[Any]?
        if let data = json.data(using: .utf8) {


            result = try? (JSONSerialization.jsonObject(with: data, options: []) as! [Any])

            //print(result ?? "Ooops... Error converting JSON!")
            return result!

        }
        return []
    }
    /*
       let arr : [Any] = [ 1, "Banana", 2, "Apple", 3, "Orange", 4, "Apricot" ]
      print(JSONHelper.json2array(arr:arr))

     */
    static func array2json( arr : [Any]) -> String{


        do {

            // Convert our array to JSON data
            let json = try JSONSerialization.data(withJSONObject: arr, options: .prettyPrinted)

            // Convert our JSON data to string
            let str = String(data: json, encoding: .utf8)

            // And if all went well, print it out
            //print(str ?? "Ooops... Error converting JSON to string!")
            return str!

        }
        catch let error
        {
            print("Error: \(error)")
            return ""
        }

    }

}
