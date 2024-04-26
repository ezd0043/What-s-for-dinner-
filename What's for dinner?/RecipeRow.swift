//
//  RecipeRow.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//

import Foundation
import SwiftUI

struct RecipeRow: View {
    let recipe: RecipeDetail

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image.resizable()
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.secondary.opacity(0.3))
            }
            .frame(width: 100, height: 100)
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("Tap to view recipe")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 10)
        }
    }
}
