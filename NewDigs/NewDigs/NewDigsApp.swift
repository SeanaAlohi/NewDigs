//
//  NewDigsApp.swift
//  NewDigs
//
//  Created by Seana Marie Lanias on 11/2/22.
//

import SwiftUI

@main
struct NewDigsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
