//
//  megawalletApp.swift
//  megawallet
//
//  Created by hu on 2021/9/11.
//

import SwiftUI
import CoreData

@main
struct megawalletApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
