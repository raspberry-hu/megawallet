//
//  megawalletApp.swift
//  megawallet
//
//  Created by hu on 2021/9/11.
//

import SwiftUI
import WCDBSwift

//使用Struct封装数据库
struct wallet_test {
    static var database_test : Database = createDB()
}

@main

struct megawalletApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
