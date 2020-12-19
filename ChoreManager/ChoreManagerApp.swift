//
//  ChoreManagerApp.swift
//  ChoreManager
//
//  Created by Akash on 12/18/20.
//

import SwiftUI

@main
struct ChoreManagerApp: App {
    let persistenceController = PersistenceController.shared
    var envData = EnvData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(envData)
        }
    }
}
