//
//  wallet_create.swift
//  megawallet
//
//  Created by hu on 2021/9/11.
//

import SwiftUI
import web3swift
import CoreData

struct wallet_create: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Wallet.mnemonic, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Wallet>
    
    var body: some View {
        let mnemonic = try?BIP39.generateMnemonics(bitsOfEntropy: 128)
        // 助记词转换为随机种子
        let seed = BIP39.seedFromMmemonics(mnemonic ?? "")!
        let seed1 = seed.toHexString()
        let see = seed.base64EncodedString()
        let keystore = try! BIP32Keystore(seed: seed, password: "123456")
        let keystoreManager = KeystoreManager([keystore!])
        let account = keystoreManager.addresses![0].address
        VStack{
            Text(mnemonic ?? "")
            Text(seed1)
            Text(see)
            Text(account)
//            let path = Bundle.main.path(forResource: "testmega", ofType:"plist")!
//            let dict = NSDictionary(contentsOfFile: path)
//            let dictionary:NSDictionary = ["order": 2]
//            let SortData = dict!.object(forKey: "order") as!Int
//            let SortData1 = String(SortData)
//            let bl1:Bool = dictionary.write(toFile: path, atomically: true)
//            if bl1{
//                Text("ok")
//            }else{
//                Text("fail")
//            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func addItem(mnemonic: String, account: String, password: String) {
        withAnimation {
//            let path = Bundle.main.path(forResource: "Info", ofType:"plist")!
//            let dict = NSDictionary(contentsOfFile: path)
//            let dictionary:NSDictionary = ["order": 2]
//            let SortData = dict!.object(forKey: "order") as!Int
//            let SortData1 = String(SortData)
            let newItem = Wallet(context: viewContext)
//            let bl1:Bool = dictionary.write(toFile: path, atomically: true)
//            let array1 = ["order": 1]
//            let filepath: String = NSHomeDirectory() + "/megawallet/Info.plist"
//            NSArray(array:array1).write(toFile: filepath, atomically: true)
            newItem.mnemonic = mnemonic
            newItem.password = password
            newItem.account = account
            //newItem.order =
//            newItem.order = Int64(SortData)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct wallet_create_Previews: PreviewProvider {
    static var previews: some View {
        wallet_create().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
