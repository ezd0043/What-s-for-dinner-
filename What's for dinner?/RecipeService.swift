//
//  RecipeService.swift
//  What's for dinner?
//
//  Created by Emily Denham on 4/24/24.
//
import Combine
import Foundation

struct RecipeService {
    let apiKey = "576df50975404f929fbcb71e61b60a2e"

    // Fetch a list of recipe summaries based on a category
    func fetchRecipes(category: String) -> AnyPublisher<[Recipe], Error> {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(category)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .decode(type: RecipeResults.self, decoder: JSONDecoder())
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // Fetch detailed information for a single recipe by its ID
    func fetchRecipeDetail(recipeId: Int) -> AnyPublisher<RecipeDetail, Error> {
        let detailUrlString = "https://api.spoonacular.com/recipes/\(recipeId)/information?includeNutrition=false&apiKey=\(apiKey)"
        guard let detailUrl = URL(string: detailUrlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: detailUrl)
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .decode(type: RecipeDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
