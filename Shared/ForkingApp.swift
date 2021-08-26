//
//  ForkingApp.swift
//  Shared
//
//  Created by Matt de Young on 22.08.21.
//

import SwiftUI

@main
struct ForkingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListRecipesView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
