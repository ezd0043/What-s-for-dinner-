//
//  RecipesViewModel.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import Combine
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var detailedRecipes: [RecipeDetail] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var recipeService = RecipeService()
    private var cancellables = Set<AnyCancellable>()

    func loadRecipes(for category: String) {
        isLoading = true
        errorMessage = nil
        
        print("Loading recipes for category: \(category)")

        recipeService.fetchRecipes(category: category)
            .flatMap { recipeSummaries -> AnyPublisher<[RecipeDetail], Error> in
                print("Fetched recipe summaries: \(recipeSummaries.count)")
                return Publishers.MergeMany(recipeSummaries.map { summary in
                    self.recipeService.fetchRecipeDetail(recipeId: summary.id).eraseToAnyPublisher()
                })
                .collect()
                .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if case let .failure(error) = completion {
                        self?.errorMessage = error.localizedDescription
                        print("Error fetching recipes: \(error)")
                    }
                }
            }, receiveValue: { [weak self] detailedRecipes in
                DispatchQueue.main.async {
                    self?.detailedRecipes = detailedRecipes
                    print("Detailed recipes loaded: \(detailedRecipes.count)")
                }
            })
            .store(in: &cancellables)
    }
}


