//
//  RecipeData.swift
//  Forking
//
//  Created by Matt de Young on 12.08.21.
//

import Foundation

class RecipeData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("recipes.data")
    }
    @Published var recipes: [Recipe] = []
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                print("Loading data from \(Self.fileURL).")
                DispatchQueue.main.async {
                    self?.recipes = Recipe.data
                }
                #endif
                return
            }
            guard let recipes = try? JSONDecoder().decode([Recipe].self, from: data) else {
                fatalError("Can't decode saved recipe data from \(Self.fileURL).")
            }
            DispatchQueue.main.async {
                self?.recipes = recipes
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let recipes = self?.recipes else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(recipes) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
