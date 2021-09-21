//
//  EditRecipeView.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//

import SwiftUI
import CoreData

struct RecipeFormView: View {
    
    @State var viewContext: NSManagedObjectContext

    @State private var newIngredientIsPresented: Bool = false
    
    @Binding var title: String
    @Binding var ingredients: String
    @Binding var directions: String
    
    var body: some View {
        Form {
            Section(header: Text("Title").modifier(formLabel())) {
                TextField("", text: $title)
                    .foregroundColor(Color.ui.foregroundColor)
                    .accentColor(Color.ui.accentColor)
            }
            Section(header: Text("Ingredients").modifier(formLabel())) {
                ZStack {
                    TextEditor(text: $ingredients)
                        .frame(minHeight: 200.0)
                        .foregroundColor(Color.ui.foregroundColor)
                        .accentColor(Color.ui.accentColor)
                    Text(ingredients)
                        .opacity(0)
                        .padding(.all, 8)
                }
                
            }
            Section(header: Text("Directions").modifier(formLabel())) {
                TextEditor(text: $directions)
                    .frame(minHeight: 200.0)
                    .foregroundColor(Color.ui.foregroundColor)
                    .accentColor(Color.ui.accentColor)
            }
        }
    }
}

struct EditRecipeView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var viewContext: NSManagedObjectContext
    
    @State var title: String
    @State var ingredients: String
    @State var directions: String
    @State var versionName: String = ""
    let onComplete: (String, String, String, String) -> Void
    
    @State private var isShowingNameAlert = false
    
    var body: some View {
        NavigationView {
            RecipeFormView(
                viewContext: viewContext,
                title: $title,
                ingredients: $ingredients,
                directions: $directions
            )
            .navigationBarTitle(Text("Edit Recipe"))
            .navigationBarItems(
                leading: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }.buttonStyle(DismissTextButton()),
                trailing: Button("Update") {
                    self.isShowingNameAlert = true
                }.buttonStyle(TextButton())
            )
        }
        .alert(isPresented: $isShowingNameAlert, TextAlert(title: "Name this update", accept: "Update", action: { versionName in
            if versionName != nil {
                onComplete(title, ingredients, directions, versionName!)
            }
        }))
    }
}

struct CreateRecipeView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var viewContext: NSManagedObjectContext
    
    @State var title: String = ""
    @State var ingredients: String = ""
    @State var directions: String = ""
    let onComplete: (String, String, String) -> Void
    
    var body: some View {
        NavigationView {
            RecipeFormView(
                viewContext: viewContext,
                title: $title,
                ingredients: $ingredients,
                directions: $directions
            )
            .navigationBarTitle(Text("New Recipe"))
            .navigationBarItems(
                leading: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }.buttonStyle(DismissTextButton()),
                trailing: Button("Create") {
                    onComplete(title, ingredients, directions)
                }.buttonStyle(TextButton())
            )
        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView(
            viewContext: PersistenceController.preview.container.viewContext
        ) { title, ingredients, directions in
            
        }
        EditRecipeView(
            viewContext: PersistenceController.preview.container.viewContext,
            title: "Black Bean Burgers",
            ingredients: "",
            directions: ""
        ) { title, ingredients, directions, versionName in
            
        }
    }
}
