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

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.ui.headerColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.ui.headerColor)]
        UIToolbar.appearance().barTintColor = UIColor(Color.ui.backgroundColor)
        UIButton.appearance().tintColor = UIColor(Color.ui.accentColor)
        UITableView.appearance().backgroundColor = UIColor(Color.ui.backgroundColor)
//        UITextView.appearance().tintColor = UIColor(Color.ui.foregreoundColor)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListRecipesView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
