//
//  DirectionsListView.swift
//  Forking
//
//  Created by Matt de Young on 21.09.21.
//

import SwiftUI

struct DirectionsListView: View {
    var directions: String

    var trimmedDirections: [String] {
        var ret: [String] = []
        for line in directions.lines {
            let trimmedLine = line.trimmingCharacters(in: NSCharacterSet.whitespaces)
            if !trimmedLine.isEmpty {
                ret.append(trimmedLine)
            }
        }
        return ret
    }
    
    private let columns = [
        GridItem(.fixed(14), alignment: .topTrailing),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
            ForEach(Array(trimmedDirections.enumerated()), id: \.offset) { offset, line in
                Text("\(offset + 1)")
                    .foregroundColor(Color.ui.accentColor)
                    .font(Font.system(size: 12))
                    .fontWeight(.black)
                    .padding(.top, 2)
                Text(line.trimmingCharacters(in: NSCharacterSet.whitespaces))
                    .padding(.leading, 4)
            }
            .padding(.bottom)
        }
    }
}

struct DirectionsListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
            HStack() {
                VStack(alignment: .leading) {
                    DirectionsListView(
                        directions: """
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et
                                dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip
                                ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
                                fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt
                                mollit anim id est laborum.
                            """
                    )
                    Spacer()
                }
                .foregroundColor(Color.ui.foregroundColor)
                .font(Font.body.weight(.semibold))
                Spacer()
            }
        }
    }
}
