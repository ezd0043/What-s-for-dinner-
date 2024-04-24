//
//  RecipeRow.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//

import Foundation
import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 100, height: 100)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.headline)
            }
        }
    }
}
