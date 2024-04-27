//
//  RecipesViewModel.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import Combine
import SwiftUI
import Foundation

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
            .flatMap { recipeSummaries -> AnyPublisher<[Recipe], Error> in
                print("Fetched recipe summaries: \(recipeSummaries.count)")
                
                return Just(recipeSummaries).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching recipes: \(error)")
                }
            }, receiveValue: { [weak self] recipes in
                self?.recipes = recipes
                print("Recipes loaded: \(recipes.count)")
            })
            .store(in: &cancellables)
    }
}
