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
    @EnvironmentObject private var model: Model

    var body: some View {
        #if os(iOS)
            if horizontalSizeClass == .compact {
                NavigationView {
                    ListRecipesView()
                }
            } else {
                NavigationView {
                    ListRecipesView()
                }
            }
        #else
            NavigationView {
                ListRecipesView()
            }
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
