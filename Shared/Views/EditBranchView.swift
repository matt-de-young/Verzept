//
//  EditBranchView.swift
//  Forking
//
//  Created by Matt de Young on 17.08.21.
//

import SwiftUI

struct EditBranchView: View {
    @Binding var branchData: RecipeBranch.Data
    
    var body: some View {
        List {
            Section(header: Text("Name")) {
                TextField("", text: $branchData.name)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditBranchView_Previews: PreviewProvider {
    static var previews: some View {
        EditBranchView(
            branchData: .constant(RecipeBranch.testData["BBBVegan"]!.data)
        )
    }
}
