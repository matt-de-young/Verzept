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
    @StateObject private var model = Model()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.ui.headerColor),
            .font : UIFont(name: "Futura Bold", size: 42)!
        ]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.ui.headerColor)]
        UIToolbar.appearance().barTintColor = UIColor(Color.ui.backgroundColor)
        UIButton.appearance().tintColor = UIColor(Color.ui.accentColor)
        UITableView.appearance().backgroundColor = UIColor(Color.ui.backgroundColor)
        UITableView.appearance().tintColor = UIColor(Color.ui.backgroundColor)
        UITextView.appearance().backgroundColor = .clear
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(.blue)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(model)
        }
    }
}
