//
//  RecipesViewModel.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import Foundation
import Combine
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var recipeService = RecipeService()
    private var cancellables = Set<AnyCancellable>()

    func loadRecipes(for category: String) {
        isLoading = true
        errorMessage = nil
        
        recipeService.fetchRecipes(category: category)
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    case .finished:
                        break
                    }
                }
            }, receiveValue: { [weak self] recipes in
                DispatchQueue.main.async {
                    self?.recipes = recipes
                }
            })
            .store(in: &cancellables)
    }

}

