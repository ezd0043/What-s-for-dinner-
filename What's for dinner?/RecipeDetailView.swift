//
//  RecipeDetailView.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import SwiftUI
import Combine

struct RecipeDetailView: View {
    let recipeId: Int
    @ObservedObject var viewModel: RecipeDetailViewModel
    @State private var navigationTitle: String = "Recipe Detail" 

    init(recipeId: Int) {
        self.recipeId = recipeId
        self.viewModel = RecipeDetailViewModel(recipeId: recipeId)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let recipe = viewModel.recipe {
                    Text(recipe.title)
                        .font(.title)
                        .padding()

                    if let instructions = recipe.instructions, !instructions.isEmpty {
                        Text("Instructions")
                            .font(.headline)
                            .padding(.top)
                        Text(instructions)
                            .padding()
                    } else {
                        Text("No instructions provided.")
                            .padding()
                    }
                } else {
                    Text("Loading...")
                        .padding()
                }
            }
        }
        .navigationTitle(navigationTitle)
        .onAppear {
            viewModel.loadRecipeDetail()
            if let recipeTitle = viewModel.recipe?.title {
                navigationTitle = recipeTitle
            }
        }
    }
}


class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: Recipe?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var recipeService = RecipeService()
    private var cancellables = Set<AnyCancellable>()
    private let recipeId: Int

    init(recipeId: Int) {
        self.recipeId = recipeId
    }
    
    func loadRecipeDetail() {
        isLoading = true
        errorMessage = nil
        
        recipeService.fetchRecipeDetail(recipeId: recipeId)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching recipe detail: \(error)")
                }
            }, receiveValue: { [weak self] recipe in
                self?.recipe = recipe
                print("Recipe detail loaded: \(recipe.title)")
            })
            .store(in: &cancellables)
    }
}
