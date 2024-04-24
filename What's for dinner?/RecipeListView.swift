//
//  RecipeListView.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//

import Foundation
import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel = RecipesViewModel()
    var category: String

    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                ForEach(viewModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeRow(recipe: recipe)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadRecipes(for: category)
        }
        .navigationTitle("\(category) Recipes")
    }
}
