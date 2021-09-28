//
//  JSON_View.swift
//  megawallet
//
//  Created by hu on 2021/9/28.
//

import SwiftUI

let json = """
{
    "name": "John Davis",
    "country": "Peru",
    "use": "to buy a new collection of clothes to stock her shop before the holidays.",
    "amount": 150
}
"""

struct JSON_View: View {
    var body: some View {
        Button {
            let test = decode(json: json)
            if test{
                print("success")
            }else{
                print("fail")
            }
        } label: {
            Text("test")
        }
    }
}

struct JSON_View_Previews: PreviewProvider {
    static var previews: some View {
        JSON_View()
    }
}
