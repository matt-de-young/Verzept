//
//  ContentView.swift
//  Forking
//
//  Created by Matt de Young on 27.09.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    @State var viewContext: NSManagedObjectContext

    var body: some View {
        #if os(iOS)
            if horizontalSizeClass == .compact {
                NavigationView {
                    ListRecipesView()
                        .environment(\.managedObjectContext, viewContext)
                }
            } else {
                NavigationView {
                    ListRecipesView()
                        .environment(\.managedObjectContext, viewContext)
                }
            }
        #else
            NavigationView {
                ListRecipesView()
                    .environment(\.managedObjectContext, viewContext)
            }
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewContext: PersistenceController.preview.container.viewContext)
    }
}
