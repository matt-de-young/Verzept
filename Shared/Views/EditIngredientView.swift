//
//  EditIngredientView.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//

import SwiftUI

struct IngredientFormView: View {
    
    @Binding var name: String
    @Binding var quantity: String
    @Binding var unit: String
    @Binding var notes: String
    
    var body: some View {
        Form {
            Section() {
                HStack {
                    TextField("Quantity", text: $quantity)
                    TextField("Unit", text: $unit)
                }
                TextField("New Ingredient", text: $name)
            }
            Section(header: Text("Notes")) {
                TextEditor(text: $notes)
                    .frame(minHeight: 200.0)
            }
        }
    }
}

struct EditIngredientView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var name: String
    @State var quantity: String
    @State var unit: String
    @State var notes: String
    let onComplete: (String, String, String, String) -> Void
    
    var body: some View {
        NavigationView {
            IngredientFormView(
                name: $name,
                quantity: $quantity,
                unit: $unit,
                notes: $notes
            )
            .navigationBarItems(leading: Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Update") {
                onComplete(name, quantity, unit, notes)
            })
        }
    }
}

struct NewIngredientView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var name: String = ""
    @State var quantity: String = ""
    @State var unit: String = ""
    @State var notes: String = ""
    let onComplete: (String, String, String, String) -> Void
    
    var body: some View {
        NavigationView {
            IngredientFormView(
                name: $name,
                quantity: $quantity,
                unit: $unit,
                notes: $notes
            )
            .navigationBarItems(leading: Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                onComplete(name, quantity, unit, notes)
            })
        }
    }
}

struct EditIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        EditIngredientView(
            name: "",
            quantity: "",
            unit: "",
            notes: ""
        ) {  name, quantity, unit, notes in
            
        }
    }
}
