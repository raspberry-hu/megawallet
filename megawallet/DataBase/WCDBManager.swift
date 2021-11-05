//
//  WCDBManager.swift
//  megawallet
//
//  Created by hu on 2021/9/16.
//

import Foundation
import WCDBSwift

class WalletTable: TableCodable {
    var WalletAccount: String?
    var WalletPrivate: String?
    var WalletMnemonic: String?
    var WalletCount: Int? = 0
    enum CodingKeys: String, CodingTableKey {
        typealias Root = WalletTable
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case WalletAccount
        case WalletPrivate
        case WalletMnemonic
        case WalletCount
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                WalletCount: ColumnConstraintBinding(isPrimary: true),
            ]
        }
    }
    var isAutoIncrement: Bool = true // 用于定义是否使用自增的方式插入
    var lastInsertedRowID: Int64 = 0
}

func Insert_Wallet(Account:String, Mnemonic:String, Private:String, database:Database) -> Bool {
    print("123")
    let object = WalletTable()
    object.WalletAccount = Account
    object.WalletMnemonic = Mnemonic
    object.WalletPrivate = Private
    object.isAutoIncrement = true
    do {
        try database.create(table: "WalletDB", of: WalletTable.self)
    } catch let error {
        print("creat table error: \(error)")
    }
    do{
        let table: Table<WalletTable>? = try database.getTable(named: "WalletDB")
    } catch let error{
        print("get table error: \(error)")
    }
    do{
        try database.insert(objects: object, intoTable: "WalletDB")
    }catch let error{
        print("Insert Wallet error: \(error)")
    }
    return true
}

func Search_Wallet(Count: Int, database:Database) -> WalletTable?{
    do {
        let order = [(WalletTable.Properties.WalletCount).asOrder(by: .ascending)]
        let object: WalletTable? = try database.getObject(
            fromTable: "WalletDB",
            orderBy: order,
            offset: Count)
        return object
    } catch let error {
        print("select objects error: \(error)")
        return nil
    }
}

func createDB() -> Database{
    let machPath = CommandLine.arguments.first!
    let baseDirectory = URL(fileURLWithPath: machPath).deletingLastPathComponent().appendingPathComponent("WalletDB").path
    let className = String(describing: WalletTable.self)
    print(className)
    let path = URL(fileURLWithPath: baseDirectory).appendingPathComponent(className).path
    let tableName = className
    let database = Database(withPath: path)
    do {
        try database.create(table: tableName, of: WalletTable.self)
    } catch let error {
        print("creat table error: \(error)")
    }
    return database
}
